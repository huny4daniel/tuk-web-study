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
<%
	int bookId = Integer.parseInt(request.getParameter("bookId"));
	Connection conn = ConnectionProvider.getConnection();
	try {
		BookDao dao = new BookDao();
		dao.deleteById(conn, bookId);
	}catch(SQLException e){}
%>
${param.bookId}가 삭제되었습니다. <br><br>

<a href="bookList.jsp">도서리스트 보기</a> 
</body>
</html>