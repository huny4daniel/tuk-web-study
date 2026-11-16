<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
request.setCharacterEncoding("UTF-8");

String zipcode =
    request.getParameter("zipcode");

String address =
    request.getParameter("address");

String detailAddress =
    request.getParameter("detailAddress");
%>
zipcode = <%= zipcode %> <br>
address = <%= address %> <br>
detailAddress = <%= detailAddress %> <br>
</body>
</html>