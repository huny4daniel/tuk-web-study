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
도서 리스트: <br><hr><br>
<%
	List<Book> list=null; 
	Connection conn = ConnectionProvider.getConnection();
	try {
		BookDao dao = new BookDao();
		list = dao.selectList(conn); 
	}catch(SQLException e){}
	if (list != null) {
%>
<c:set var="list" value="<%=list%>"/> 
<table border="1" width="1000" cellpadding="10">
<tr>
<th>도서아이디</th><th>도서명</th><th>저자</th><th>가격</th><th>출판일</th><th>이미지</th><th>수정</th><th>삭제</th>
</tr>

<c:forEach var="book" items="${list}">
<tr>
    <td>${book.bookId}</td><td>${book.bookName}</td><td>${book.author}</td><td>${book.price}</td>
    <td>${book.publishDate}</td>
    <td><a href="/0614/purchase/purchase.jsp?bookId=${book.bookId}">
         <img src="/0614/images/${book.bookImage}" width="60" height="70"></a></td>
<td><button onclick="location.href='updateForm.jsp?bookId=${book.bookId}'">수정</button></td> 
<td><button onclick="location.href='delete.jsp?bookId=${book.bookId}'">삭제</button></td>         
</tr>
</c:forEach>

</table>
<% } %>
<br><br><a href="uploadForm.jsp">도서 등록하기</a>
</body>
</html>









