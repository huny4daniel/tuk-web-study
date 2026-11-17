<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/restaurant-config.jspf" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>맛집 등록</title>
    <link rel="stylesheet" href="restaurant.css">
</head>
<body>
<h1>맛집 등록</h1>
<p><a href="restaurant-map.jsp">맛집 지도 보기</a></p>
<form action="restaurant-save.jsp" method="post" enctype="multipart/form-data">
    <label>가게 이름 <input name="name" required maxlength="100"></label>
    <label>한 줄 리뷰<br><textarea name="review" required maxlength="500" rows="3"></textarea></label>
    <label>사진 <input type="file" name="photo" required accept="image/jpeg,image/png"></label>
    <p id="location-status" role="status">지도에서 가게 위치를 클릭하세요.</p>
    <div id="map"></div>
    <input type="hidden" name="latitude" id="latitude">
    <input type="hidden" name="longitude" id="longitude">
    <p><button id="save-button" disabled>등록</button></p>
</form>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=<%= html(KAKAO_JS_KEY) %>"></script>
<script>
    const locationStatus = document.querySelector('#location-status');
    if (window.kakao && kakao.maps && kakao.maps.Map) {
        const map = new kakao.maps.Map(document.querySelector('#map'), {
            center: new kakao.maps.LatLng(37.3403, 126.7336), level: 4
        });
        const marker = new kakao.maps.Marker();
        kakao.maps.event.addListener(map, 'click', function (event) {
            const position = event.latLng;
            marker.setPosition(position);
            marker.setMap(map);
            document.querySelector('#latitude').value = position.getLat();
            document.querySelector('#longitude').value = position.getLng();
            locationStatus.textContent = '선택한 위치 ' + position.getLat().toFixed(6) + ', ' + position.getLng().toFixed(6);
            document.querySelector('#save-button').disabled = false;
        });
    } else {
        locationStatus.textContent = '카카오 지도를 불러오지 못했습니다. JavaScript 키와 SDK 도메인을 확인하세요.';
    }
</script>
</body>
</html>
