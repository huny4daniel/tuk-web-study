<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화정보 등록</title>
</head>
<body>
영화정보 등록: <br><hr><br>
<form action="upload.jsp" method="post" enctype="multipart/form-data">
영화제목: <input type="text" name="title" value="타이타닉">
제작사: <input type="text" name="maker" value="20세기 폭스">
가격: <input type="text" name="price" value="20000">
포스터: <input type="file" name="poster">
<input type="submit" value="입력">
</form>
</body>
</html>