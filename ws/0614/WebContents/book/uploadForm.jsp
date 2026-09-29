<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
도서정보입력: <br><hr><br>
<form action="upload.jsp" method="post" enctype="multipart/form-data">
도서명: <input type="text" name="bookName" value="대한민국"><br>
저자: <input type="text" name="author" value="강길동"><br>
가격: <input type="text" name="price" value="23000"><br>
출판년도: <select name="bYear">
			<option value="2018">2018</option>
			<option value="2019">2019</option>
			<option value="2020">2020</option>
			<option value="2021">2021</option>
		</select>년
        <select name="bMonth">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
		</select>월 <br>
이미지: <input type="file" name="bookImage" ><br>
<input type="submit" value="입력"><br>
</form>
</body>
</html>