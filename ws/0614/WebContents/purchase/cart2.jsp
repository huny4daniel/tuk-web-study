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
	if (bookCount == null) {
		bookCount = new Integer(0);
	}
	int bookId = Integer.parseInt(request.getParameter("bookId"));
	int price = Integer.parseInt(request.getParameter("price"));
	int amount = Integer.parseInt(request.getParameter("amount"));
	String customer = request.getParameter("customer");
	Cart cart = new Cart(customer,bookId, price, amount);
	bookCount = new Integer(bookCount.intValue()+1);
	session.setAttribute("book"+bookCount, cart);
	session.setAttribute("bookCount", bookCount);
	 
%>
지금까지 카트에 담은 책 목록:   <br><hr><br>
<%
	Connection conn = ConnectionProvider.getConnection();
	try {
		BookDao dao = new BookDao(); 
		for (int i=1; i <= bookCount.intValue(); i++) {
			Cart c = (Cart)session.getAttribute("book"+i);
			Book book = dao.selectById(conn, c.getBookId());
			out.println(book.getBookName()+"<br>");
		}
	}catch (SQLException e){
		
	}finally { JdbcUtil.close(conn); }

%>
<a href="cartpurchase.jsp">카트에 있는 책 다 구매하기</a>
</body>
</html>



