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
	Integer bookCount = (Integer)session.getAttribute("bookCount");
	if (bookCount == null) {
		bookCount = new Integer(0);
	}
	String bookId = request.getParameter("bookId");
	bookCount = new Integer(bookCount.intValue()+1);
	session.setAttribute("book"+bookCount, bookId);
	session.setAttribute("bookCount", bookCount);
	 
%>
지금까지 카트에 담은 책 목록:   <br><hr><br>
<%
	Connection conn = ConnectionProvider.getConnection();
	try {
		BookDao dao = new BookDao(); 
		for (int i=1; i <= bookCount.intValue(); i++) {
			int bId = Integer.parseInt((String)session.getAttribute("book"+i));
			Book book = dao.selectById(conn, bId);
			out.println(book.getBookName()+"<br>");
		}
	}catch (SQLException e){
		
	}finally { JdbcUtil.close(conn); }

%>
</body>
</html>



