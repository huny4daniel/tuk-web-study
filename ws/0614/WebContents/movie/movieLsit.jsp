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
영화 리스트: <br><hr><br>
<%
	List<Movie> list=null; 
	Connection conn = ConnectionProvider.getConnection();
	try {
		MovieDao dao = new MovieDao();
		list = dao.selectList(conn); 
	}catch(SQLException e){}
	if (list != null) {
%>
<c:set var="list" value="<%=list%>"/> 
<table border="1" width="1000" cellpadding="10">
<tr>
<th>아이디</th><th>영화명</th><th>제작사</th><th>가격</th><th>개봉일</th><th>포스터</th>
</tr>

<c:forEach var="movie" items="${list}">
<tr>
    <td>${movie.movieId}</td><td>${movie.title}</td><td>${movie.maker}</td><td>${movie.price}</td>
    <td>${movie.openDate}</td>
    <td><a href="/0614/movie/detail.jsp?movieId=${movie.movieId}">
         <img src="/0614/images/${movie.poster}" width="50" height="70"></a></td>
</tr>
</c:forEach>

</table>
<% } %>
<br><br><a href="uploadForm.jsp">영화 등록하기</a>
</body>
</html>









