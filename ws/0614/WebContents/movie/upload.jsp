<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="my.util.*,my.dao.*,my.model.*,java.util.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String title="";
	int price = 0;
	String maker="";
	String poster = "";
	//String uploadPath = request.getRealPath("images");
	String uploadPath = "C:\\DevProjects\\TUKorea\\tukorea-study\\2026_2\\web-programming\\ws\\0614\\WebContents\\images";
	Connection conn = ConnectionProvider.getConnection();
	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, 
				100*1024, "utf-8", new DefaultFileRenamePolicy());
		title = multi.getParameter("title");
		maker = multi.getParameter("maker");
		price = Integer.parseInt(multi.getParameter("price"));
		poster = multi.getFilesystemName("poster");
		MovieDao dao = new MovieDao(); 
		Movie movie = new Movie(title, maker, price, new java.util.Date(), poster);
		dao.insert(conn, movie);
	} catch(Exception e){}
%>
영화제목: <%= title %> <br>
제작사: <%= maker %> <br>
가격: <%= price %> <br>
포스터: <%= poster %> <br> 데이터베이스 입력이 완료되었습니다. 
</body>
</html>
