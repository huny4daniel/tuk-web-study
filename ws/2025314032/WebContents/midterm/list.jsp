<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.io.*,java.sql.*,my.util.*,my.dao.*,my.model.*,java.util.*" %>
<%
	if (request.getContentType() != null && request.getContentType().startsWith("multipart/form-data")) {
		try {
			MultipartRequest multi = new MultipartRequest(request, application.getRealPath("/midterm/myimages"), 2*1024*1024, "utf-8", new DefaultFileRenamePolicy());

			String name = multi.getParameter("bookname");
			String author = multi.getParameter("author");
			String isbn = multi.getParameter("isbn");
			String publisher = multi.getParameter("publisher");
			int price = Integer.parseInt(multi.getParameter("price"));
			String image = multi.getFilesystemName("image");
			Book book = new Book(name, author, isbn, publisher, price, image);
			BookDao dao = new BookDao();
			dao.insert(ConnectionProvider.getConnection(), book);
		} catch (Exception e) {}
		response.sendRedirect("list.jsp");
		return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>도서 목록</title>
<link href="design.css" rel="stylesheet" type="text/css">
</head>

<body>
  <div class="page_subimg">
    <div class="subimgline"></div>
        <div class="subimg">
        	<div id="apDivSubimg"></div>
       </div>
     </div>

  <div class="page_content">
    	<div class="leftmenu">
   	    	<img src="images/left.png" width="229" height="533" alt="도서메뉴">
        </div>
    <div class="rightcon">
                <img src="images/inform2.png" width="820" height="180" alt="도서 목록">
                <div class="tablestyle">
				<%
					Connection conn = ConnectionProvider.getConnection();
					List<Book> list = null;

					try {
						BookDao dao = new BookDao();
						list = dao.selectList(conn);
					} catch (SQLException e) {}
				%>

				<c:set var="list" value="<%=list%>"/>
                  <table width="890" border="0" cellpadding="3" cellspacing="0" id="mylist">
                    <tr>
                      <th scope="col">아이디</th>
                      <th scope="col">도서명</th>
                      <th scope="col">저자</th>
                      <th scope="col">ISBN 번호</th>
                      <th scope="col">출판사</th>
                      <th scope="col">가격</th>
                      <th scope="col">이미지</th>
                    </tr>
                    <c:forEach var="book" items="${list}">
						<tr>
							<td>${book.bookId}</td>
							<td>${book.name}</td>
							<td>${book.author}</td>
							<td>${book.isbn}</td>
							<td>${book.publisher}</td>
							<td>${book.price}원</td>
							<td><img src="./myimages/${book.image}" width="50" height="75"></td>
						</tr>
					</c:forEach>
                  </table>
      </div>
    </div>
    </div>


</body>
</html>
