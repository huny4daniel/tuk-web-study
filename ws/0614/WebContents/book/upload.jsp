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
	String bookName="";
	int price = 0, bYear=0, bMonth=0;
	String maker="";
	String author = "";
	String bookImage = "";
	String uploadPath = "C:\\DevProjects\\TUKorea\\tukorea-study\\2026_2\\web-programming\\ws\\0614\\WebContents\\images";
	Connection conn = ConnectionProvider.getConnection();
	try {
		MultipartRequest multi = new MultipartRequest(request, uploadPath, 
				100*1024, "utf-8", new DefaultFileRenamePolicy());
		bookName = multi.getParameter("bookName");
		author = multi.getParameter("author");
		price = Integer.parseInt(multi.getParameter("price"));
		bYear = Integer.parseInt(multi.getParameter("bYear"));
		bMonth = Integer.parseInt(multi.getParameter("bMonth"));
		Calendar cal = Calendar.getInstance(); 
		cal.set(bYear, bMonth-1, 1);
		java.util.Date pDate = new java.util.Date(); 
		pDate.setTime(cal.getTimeInMillis());
		bookImage = multi.getFilesystemName("bookImage");
		BookDao dao = new BookDao(); 
		Book book = new Book(-1, bookName, author, price, pDate, bookImage);
		dao.insert(conn, book);
	} catch(Exception e){}
%>
도서명: <%= bookName %> <br>
저자: <%= author %> <br>
가격: <%= price %> <br>
도서이미지: <%= bookImage %> <br> 데이터베이스 입력이 완료되었습니다. 
</body>
</html>