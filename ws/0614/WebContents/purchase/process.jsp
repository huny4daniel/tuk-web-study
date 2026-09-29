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
<%  request.setCharacterEncoding("utf-8");   %>
<jsp:useBean id="purchase" class="my.model.Purchase"/>
<jsp:setProperty property="*" name="purchase"/>
<%
	int price = Integer.parseInt(request.getParameter("price"));
	purchase.setTotal(purchase.getAmount()*price); 
	purchase.setPdate(new java.util.Date());
	Connection conn = ConnectionProvider.getConnection();
	try {
		PurchaseDao dao = new PurchaseDao();
		dao.insert(conn, purchase);
	}catch(SQLException e){}
%>
구매자: ${param.customer} <br>
가격: ${param.price} <br>
수량: ${param.amount} <br>
총액: ${param.amount * param.price}
구매가 완료되었습니다. 
</body>
</html>


