<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>도서정보 등록</title>
<link href="design.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
function check() {
	if (document.form1.bookname.value == "") {
		alert("도서명을 입력해주세요");
		document.form1.bookname.focus();
		return false;
	}
	if (document.form1.author.value == "") {
		alert("저자를 입력해주세요");
		document.form1.author.focus();
		return false;
	}
	if (document.form1.isbn.value == "") {
		alert("ISBN 번호를 입력해주세요");
		document.form1.isbn.focus();
		return false;
	}
	if (document.form1.publisher.value == "") {
		alert("출판사를 입력해주세요");
		document.form1.publisher.focus();
		return false;
	}
	var pattern = /^[0-9]+$/;
	if (!pattern.test(document.form1.price.value)) {
		alert("가격은 0 이상의 정수로 입력해주세요");
		document.form1.price.focus();
		return false;
	}
	if (document.form1.image.value != "") {
		var pattern2 = /\.(jpg|jpeg|png|webp)$/i;
		if (!pattern2.test(document.form1.image.value)) {
			alert("이미지는 JPG, PNG, WEBP 파일만 가능합니다");
			document.form1.image.focus();
			return false;
		}
		if (document.form1.image.files[0].size > 2*1024*1024) {
			alert("이미지는 최대 2MB까지 가능합니다");
			document.form1.image.focus();
			return false;
		}
	}
	return true;
}
</script>
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
                <img src="images/inform1.png" width="611" height="113" alt="도서정보 등록">
                <div class="tablestyle">
                  <form action="list.jsp" method="post" enctype="multipart/form-data" name="form1" onsubmit="return check()">
                    <table width="890" border="0" cellpadding="0" cellspacing="0" id="registerform">
                      <tr>
                        <th><label for="bookname">도서명 *</label></th>
                        <td><input type="text" name="bookname" id="bookname"></td>
                      </tr>
                      <tr>
                        <th><label for="author">저자 *</label></th>
                        <td><input type="text" name="author" id="author"></td>
                      </tr>
                      <tr>
                        <th><label for="isbn">ISBN 번호 *</label></th>
                        <td><input type="text" name="isbn" id="isbn"></td>
                      </tr>
                      <tr>
                        <th><label for="publisher">출판사 *</label></th>
                        <td><input type="text" name="publisher" id="publisher"></td>
                      </tr>
                      <tr>
                        <th><label for="price">가격 (원) *</label></th>
                        <td><input type="text" name="price" id="price"></td>
                      </tr>
                      <tr>
                        <th><label for="image">표지 이미지</label></th>
                        <td><input type="file" name="image" id="image" accept=".jpg,.jpeg,.png,.webp"><br>
                        JPG, PNG, WEBP · 최대 2MB</td>
                      </tr>
                      <tr>
                        <td height="30" colspan="2" align="center" class="btnstyle"><input type="image" name="cancel" id="cancel" src="images/button1.png" onclick="document.form1.reset(); return false;">
                        <input type="image" name="ok" id="ok" src="images/button2.png"></td>
                      </tr>
                    </table>
                  </form>
                </div>
    </div>
    </div>


</body>
</html>
