<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.dao.*,my.util.*,my.model.*,java.sql.*,java.util.*" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>     
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서정보 수정</title>
</head>
<body>
도서정보 수정  <br><hr><br>
<%
	int bookId = Integer.parseInt(request.getParameter("bookId"));
	Book book = null;
	Connection conn = ConnectionProvider.getConnection();
	try {
		BookDao dao = new BookDao();
		book = dao.selectById(conn, bookId);
	}catch(SQLException e){}
	if (book != null) {
%>
<c:set var="book" value="<%=book%>"/>
<form action="update.jsp" method="post" enctype="multipart/form-data">
아이디: <input type="text" name="bookId" value="${book.bookId}">
도서명 <input type="text" name="bookName" value="${book.bookName}">
저자: <input type="text" name="author" value="${book.author}">
가격: <input type="text" name="price" value="${book.price}">
이미지: <input type="file" name="bookImage">
<input type="submit" value="수정">
<% } %>
</form>
</body>
</html>




