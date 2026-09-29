<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.dao.*,my.util.*,my.model.*,java.sql.*,java.util.*" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
도서 정보: <br><hr><br>
<%
	int bookId = Integer.parseInt(request.getParameter("bookId"));
	Connection conn = ConnectionProvider.getConnection();
	Book book = null;
	String userId = (String)session.getAttribute("LOGINID");
	try {
		BookDao dao = new BookDao();
		book = dao.selectById(conn, bookId);
	}catch(SQLException e){}
	if (book != null) {
%>
<c:set var="book" value="<%=book%>"/>
<img alt="도서" src="/0614/images/${book.bookImage}" width="200" height="250">
<br><br>구매정보 입력: <br><hr><br>
<form method="post"> 
구매자명: <input type="text" name="customer" value="<%=userId%>"> <br>
도서 아이디: <input type="text" name="bookId" value="${book.bookId}"> <br> 
가격: <input type="text" name="price" value="${book.price}"><br>
수량: <input type="text" name="amount" value="1"><br>
<input type="submit" value="구매" formaction="process.jsp">
<input type="submit" value="카트담기" formaction="cart2.jsp">
</form> 

<% } %>
</body>
</html>


