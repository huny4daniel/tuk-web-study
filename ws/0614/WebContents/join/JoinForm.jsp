<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
</head>
<body>
회원정보 입력: <br><hr><br>
<form action="join.jsp" method="post">
아이디: <input type="text" name="userId" size="10">
패스워드: <input type="password" name="password" size="10">
이름: <input type="text" name="name" size="10">
<input type="submit" value="회원가입">
</form>
</body>
</html>