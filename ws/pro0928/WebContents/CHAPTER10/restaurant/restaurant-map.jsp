<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/restaurant-config.jspf" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>우리 동네 맛집 지도</title>
    <link rel="stylesheet" href="restaurant.css">
</head>
<body>
<h1>우리 동네 맛집 지도</h1>
<p><a href="restaurant-new.jsp">맛집 등록하기</a></p>
<p id="map-status" role="status"></p>
<div id="map"></div>
<template id="restaurants">
<%
    String sql = "SELECT name, review, latitude, longitude, photo_name FROM restaurants ORDER BY id DESC";
    try (Connection db = openRestaurantDb();
         PreparedStatement query = db.prepareStatement(sql);
         ResultSet rows = query.executeQuery()) {
        while (rows.next()) {
%>
    <article class="photo-card" data-lat="<%= rows.getDouble("latitude") %>"
             data-lng="<%= rows.getDouble("longitude") %>">
        <strong><%= html(rows.getString("name")) %></strong>
        <p><%= html(rows.getString("review")) %></p>
        <img loading="lazy" src="../myimages/<%= java.net.URLEncoder.encode(rows.getString("photo_name"), "UTF-8").replace("+", "%20") %>" alt="등록한 맛집 사진">
    </article>
<%
        }
    } catch (SQLException | ClassNotFoundException e) {
        application.log("맛집 조회 실패", e);
        throw new ServletException("맛집 목록을 불러오지 못했습니다.", e);
    }
%>
</template>
<script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=<%= html(KAKAO_JS_KEY) %>"></script>
<script>
    const cards = document.querySelector('#restaurants').content.querySelectorAll('article');
    const mapStatus = document.querySelector('#map-status');
    if (window.kakao && kakao.maps && kakao.maps.Map) {
        const map = new kakao.maps.Map(document.querySelector('#map'), {
            center: new kakao.maps.LatLng(37.3403, 126.7336), level: 4
        });
        const popup = new kakao.maps.InfoWindow({removable: true});
        const bounds = new kakao.maps.LatLngBounds();
        cards.forEach(function (card) {
            const position = new kakao.maps.LatLng(Number(card.dataset.lat), Number(card.dataset.lng));
            const marker = new kakao.maps.Marker({map: map, position: position});
            bounds.extend(position);
            kakao.maps.event.addListener(marker, 'click', function () {
                popup.close();
                popup.setContent(card.cloneNode(true));
                popup.open(map, marker);
            });
        });
        if (cards.length > 0) {
            map.setCenter(new kakao.maps.LatLng(Number(cards[0].dataset.lat), Number(cards[0].dataset.lng)));
            const hasDistinctPositions = Array.from(cards).some(function (card) {
                return card.dataset.lat !== cards[0].dataset.lat || card.dataset.lng !== cards[0].dataset.lng;
            });
            if (hasDistinctPositions) map.setBounds(bounds);
            mapStatus.textContent = '마커를 누르면 사진과 리뷰가 표시됩니다.';
        } else {
            mapStatus.textContent = '등록된 맛집이 없습니다.';
        }
        kakao.maps.event.addListener(map, 'click', function () { popup.close(); });
    } else {
        mapStatus.textContent = '카카오 지도를 불러오지 못했습니다. JavaScript 키와 SDK 도메인을 확인하세요.';
    }
</script>
</body>
</html>
