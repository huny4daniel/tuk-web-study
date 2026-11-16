
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>우편번호 검색</title>

<!-- 카카오 우편번호 API -->
<script src="https://t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
function searchPostcode() {

    new kakao.Postcode({
        oncomplete: function(data) {

            // 우편번호
            document.getElementById("zipcode").value =
                data.zonecode;

            // 도로명 또는 지번 주소
            var address = data.userSelectedType === 'R'
                ? data.roadAddress
                : data.jibunAddress;

            document.getElementById("address").value =
                address;

            // 상세주소에 커서 이동
            document.getElementById("detailAddress").focus();
        }
    }).open();
}
</script>
</head>

<body>

<h2>회원 주소 등록</h2>

<form action="addressSave.jsp" method="post">

    우편번호:
    <input type="text" id="zipcode"
           name="zipcode" readonly>

    <input type="button"
           value="우편번호 검색"
           onclick="searchPostcode()">

    <br><br>

    기본주소:
    <input type="text" id="address"
           name="address" size="55" readonly>

    <br><br>

    상세주소:
    <input type="text" id="detailAddress"
           name="detailAddress" size="55">

    <br><br>

    <input type="submit" value="주소 저장">

</form>

</body>
</html>
