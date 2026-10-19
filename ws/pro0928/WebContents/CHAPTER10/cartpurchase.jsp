<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*,java.sql.*,my.util.*,my.dao.*,my.model.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>고객등록 신청서</title>
<link href="design.css" rel="stylesheet" type="text/css">
</head>

<body>
	<div class="page_header">
		<div class="toplogo">
			<a href="#"><img src="images/top_logo.jpg" width="276" height="40" alt="beautifullife"></a>
		</div>
		<div class="topnav">
			<ul>
				<li><a href="#"><img src="images/top_menu1.jpg" width="72" height="24" alt="ArtStory"></a></li>
				<li><a href="#"><img src="images/top_menu2.jpg" width="76" height="24" alt="ArtStory"></a></li>
				<li><a href="#"><img src="images/top_menu3.jpg" width="64" height="24" alt="ArtStory"></a></li>
				<li><a href="#"><img src="images/top_menu4.jpg" width="134" height="24" alt="ArtStory"></a></li>
				<li><a href="#"><img src="images/top_menu5.jpg" width="99" height="24" alt="ArtStory"></a></li>
				<li><a href="#"><img src="images/top_menu6.jpg" width="52" height="24" alt="ArtStory"></a></li>
			</ul>
		</div>
	</div>

	<div class="page_subimg">
		<div class="subimgline"></div>
		<div class="subimg">
			<div id="apDivSubimg"></div>
		</div>
	</div>

	<div class="page_content">
		<div class="leftmenu">
			<img src="images/left_title.jpg" width="152" height="24" alt="membership">
			<ul>
				<li></li>
				<li><a href="#">회원가입</a></li>
				<li><a href="#">아이디찾기</a></li>
				<li><a href="#">비번찾기</a></li>
				<li><a href="#">마이페이지</a></li>
				<li><a href="#">1:1문의하기</a></li>
				<li><a href="#">질문내역</a></li>
				<li><a href="#">후기내역</a></li>
				<li><a href="#">쿠폰내격</a></li>
				<li><a href="#">적립금내역</a></li>
			</ul>
		</div>

		<div class="rightcon">
			<% request.setCharacterEncoding("utf-8"); %>
			<img src="images/title1.jpg" width="464" height="58" alt="고객등록">
			<div class="tablestyle">
				<%
					Integer movieCount = (Integer)session.getAttribute("movieCount");
					List<Movie> movies = new ArrayList<Movie>();

					if (movieCount != null) {
						MovieDao dao = new MovieDao();
						PurchaseDao pDao = new PurchaseDao();
						for (int i = 1; i <= movieCount.intValue(); i++) {
							Cart cart = (Cart)session.getAttribute("movie" + i);
							if (cart == null) continue;
							Connection conn = null;
							Connection conn2 = null;
							try {
								// selectById와 insert는 커넥션을 닫지 않으므로 finally에서 직접 닫음
								conn = ConnectionProvider.getConnection();
								Movie movie = dao.selectById(conn, cart.getMovieId());
								Purchase purchase = new Purchase(cart.getCustomer(), cart.getMovieId(), cart.getAmount(), movie.getPrice()*cart.getAmount(), new java.util.Date());
								conn2 = ConnectionProvider.getConnection();
								pDao.insert(conn2, purchase);
								movies.add(movie);
							}
							catch (SQLException e) {
							}
							finally {
								JdbcUtil.close(conn);
								JdbcUtil.close(conn2);
							}
						}
							for (int i = 1; i <= movieCount; i++) {
								session.removeAttribute("movie" + i);
							}
						session.removeAttribute("movieCount");
					}
				%>
				<c:set var="movies" value="<%=movies%>"/>

				<c:forEach var="movie" items="${movies}">
					<div class="catalogitem">
						<img src="./myimages/${movie.poster}" width="150" height="200">
						<p>${movie.title}</p>
					</div>
				</c:forEach>
				<div class="desc">
					구매가 완료되었습니다. 감사합니다.
				</div>
			</div>
		</div>
	</div>
</body>
</html>
