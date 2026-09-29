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
<jsp:useBean id="user" class="my.model.User" />
<jsp:setProperty property="*" name="user"/>
<%
	user.setLoginTime(new java.util.Date());
	Connection conn = ConnectionProvider.getConnection();
	boolean loginCheck = false;
	try {
		UserDao dao = new UserDao();
		loginCheck = dao.checkPassword(conn, user.getUserId(), user.getPassword());
		if (loginCheck) {
			session.setAttribute("LOGINID", user.getUserId());
			if (user.getUserId().equals("admin")){
				response.sendRedirect("/0614/book/uploadForm.jsp");
			} else {
				response.sendRedirect("/0614/book/bookList.jsp");
			}
		} else {
%>
	<script type="text/javascript">
		alert("아이디와 패스워드 체크 필요");
		history.go(-1);
	</script>
<% 			
		}
	} catch(SQLException e){
		e.printStackTrace();
	}
%>

</body>
</html>