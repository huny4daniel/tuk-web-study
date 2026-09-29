<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.dao.*,my.model.*,my.util.*,java.sql.*,java.util.*" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="my.model.User" />
<jsp:setProperty property="*" name="user"/>
<%
	user.setLoginTime(new java.util.Date());
	Connection conn = ConnectionProvider.getConnection();
	try {
		UserDao dao = new UserDao();
		dao.insert(conn, user);
	} catch(SQLException e){
		e.printStackTrace();
	}
%>
회원 가입을 축하합니다.!!
</body>
</html>