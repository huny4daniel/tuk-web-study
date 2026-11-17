<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
    trimDirectiveWhitespaces="true" %>
<%@ page import="java.io.File,java.io.IOException,java.nio.file.*,java.sql.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ include file="/WEB-INF/restaurant-config.jspf" %>
<%
    if (!"POST".equals(request.getMethod())) {
        response.sendError(405);
        return;
    }

    String uploadPath = application.getRealPath("/CHAPTER10/myimages");
    if (uploadPath == null) {
        throw new ServletException("WAR를 디렉터리로 풀어서 배포해 주세요.");
    }

    Path uploadDir = Files.createDirectories(Paths.get(uploadPath));
    Path tempDir = Files.createTempDirectory("restaurant-photo-");
    Path savedPhoto = null;
    boolean inserted = false;

    try {
        MultipartRequest multi = new MultipartRequest(
            request,
            tempDir.toString(),
            5 * 1024 * 1024,
            "UTF-8",
            new DefaultFileRenamePolicy()
        );

        File photo = multi.getFile("photo");
        String originalName = multi.getOriginalFileName("photo");

        if (photo == null || originalName == null || originalName.length() > 64 ||
                !originalName.matches("(?iu)[\\p{L}\\p{N}_() -]+\\.(jpg|jpeg|png)")) {
            response.sendError(400, "파일명이 64자 이하인 JPG 또는 PNG 사진을 선택해 주세요.");
            return;
        }

        String name = multi.getParameter("name");
        String review = multi.getParameter("review");
        if (name == null || name.trim().isEmpty() || name.length() > 100 ||
                review == null || review.trim().isEmpty() || review.length() > 500) {
            response.sendError(400, "가게 이름과 리뷰를 확인해 주세요.");
            return;
        }

        double latitude;
        double longitude;
        try {
            latitude = Double.parseDouble(multi.getParameter("latitude"));
            longitude = Double.parseDouble(multi.getParameter("longitude"));
        } catch (NumberFormatException | NullPointerException e) {
            response.sendError(400, "지도에서 가게 위치를 선택해 주세요.");
            return;
        }

        if (!validCoordinate(latitude, 90) || !validCoordinate(longitude, 180)) {
            response.sendError(400, "지도에서 가게 위치를 다시 선택해 주세요.");
            return;
        }

        int dot = originalName.lastIndexOf('.');
        String baseName = originalName.substring(0, dot);
        String extension = originalName.substring(dot);
        String storedName = originalName;

        String sql = "INSERT INTO restaurants "
                   + "(name, review, latitude, longitude, photo_name) "
                   + "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = openRestaurantDb();
             PreparedStatement existing = conn.prepareStatement(
                 "SELECT 1 FROM restaurants WHERE photo_name = ?");
             PreparedStatement insert = conn.prepareStatement(sql)) {

            for (int number = 0; ; number++) {
                if (number > 0) {
                    String suffix = "_" + number + extension;
                    int length = Math.min(baseName.length(), 64 - suffix.length());
                    storedName = baseName.substring(0, length) + suffix;
                }

                // 사진이 지워졌어도 DB에 이름이 남아 있으면 다음 이름을 사용합니다.
                existing.setString(1, storedName);
                try (ResultSet rows = existing.executeQuery()) {
                    if (rows.next()) {
                        continue;
                    }
                }

                try {
                    savedPhoto = Files.copy(photo.toPath(), uploadDir.resolve(storedName));
                    break;
                } catch (FileAlreadyExistsException e) {
                    // 같은 이름의 파일이 있으면 다음 번호로 시도합니다.
                }
            }

            insert.setString(1, name.trim());
            insert.setString(2, review.trim());
            insert.setDouble(3, latitude);
            insert.setDouble(4, longitude);
            insert.setString(5, storedName);
            insert.executeUpdate();
            inserted = true;
        }

        application.log("맛집 사진 저장 경로: " + savedPhoto.toAbsolutePath());
        response.sendRedirect("restaurant-map.jsp");

    } catch (Exception e) {
        application.log("맛집 등록 실패", e);
        throw new ServletException("맛집 등록에 실패했습니다. 톰캣 로그를 확인하세요.", e);
    } finally {
        try {
            if (!inserted && savedPhoto != null) {
                Files.deleteIfExists(savedPhoto);
            }
        } catch (IOException e) {
            application.log("저장 사진 정리 실패", e);
        }

        try {
            try (DirectoryStream<Path> files = Files.newDirectoryStream(tempDir)) {
                for (Path file : files) {
                    Files.deleteIfExists(file);
                }
            }
            Files.deleteIfExists(tempDir);
        } catch (IOException e) {
            application.log("임시 사진 정리 실패", e);
        }
    }
%>