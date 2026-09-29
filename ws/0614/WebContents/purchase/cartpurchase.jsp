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
	request.setCharacterEncoding("utf-8");
	Integer bookCount = (Integer)session.getAttribute("bookCount");
	Connection conn = ConnectionProvider.getConnection();
	try {
		PurchaseDao dao = new PurchaseDao();
		for (int i=1; i <= bookCount.intValue(); i++) {
			Cart c = (Cart)session.getAttribute("book"+i);
			Purchase purchase = 
	new Purchase(-1, c.getCustomer(), c.getBookId(), c.getAmount(), c.getAmount()*c.getPrice(), 
			new java.util.Date()); 
			dao.insert(conn, purchase);
		}
	}catch (SQLException e){
		
	}finally { JdbcUtil.close(conn); }

	for (int i=1; i <= bookCount.intValue(); i++)
		session.removeAttribute("book"+i);   //카트에 있는 북정보 삭제
	session.removeAttribute("bookCount");
%>
카트 구매를 완료하였습니다. 
</body>
</html>









