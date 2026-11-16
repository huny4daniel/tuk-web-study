<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>내 주변 약국</title>
</head>
<body>
    <h1>내 주변 약국</h1>
    <button id="search" type="button">현재 위치로 약국 찾기</button>
    <p id="status" role="status"></p>
    <div id="map" style="width: 100%; height: 420px;"></div>
    <ol id="results"></ol>

    <script src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=6ee560a86c1b43a4626c134569c436be&amp;libraries=services"></script>
    <script>
        const button = document.getElementById("search");
        const status = document.getElementById("status");
        const results = document.getElementById("results");

        if (!window.kakao || !kakao.maps || !kakao.maps.services) {
            status.textContent = "지도를 불러오지 못했습니다. JavaScript 키와 도메인 설정을 확인하세요.";
            button.disabled = true;
        } else {
            const map = new kakao.maps.Map(document.getElementById("map"), {
                center: new kakao.maps.LatLng(37.5665, 126.9780),
                level: 5
            });
            const places = new kakao.maps.services.Places();
            const markers = [];

            function finish(message) {
                status.textContent = message;
                button.disabled = false;
            }

            button.addEventListener("click", () => {
                if (!navigator.geolocation) {
                    finish("현재 위치를 사용할 수 없습니다. 접속 주소를 확인하세요.");
                    return;
                }

                button.disabled = true;
                status.textContent = "현재 위치를 확인하는 중입니다.";

                navigator.geolocation.getCurrentPosition(({ coords }) => {
                    const here = new kakao.maps.LatLng(coords.latitude, coords.longitude);
                    markers.forEach(marker => marker.setMap(null));
                    markers.length = 0;
                    results.replaceChildren();

                    map.setCenter(here);
                    markers.push(new kakao.maps.Marker({
                        map, position: here, title: "내 위치", zIndex: 2
                    }));

                    places.categorySearch("PM9", (items, code) => {
                        if (code === kakao.maps.services.Status.ZERO_RESULT) {
                            finish("반경 1km 안에서 약국을 찾지 못했습니다.");
                            return;
                        }
                        if (code !== kakao.maps.services.Status.OK) {
                            finish("약국 검색에 실패했습니다.");
                            return;
                        }

                        const bounds = new kakao.maps.LatLngBounds();
                        bounds.extend(here);

                        items.forEach(item => {
                            const position = new kakao.maps.LatLng(
                                Number(item.y), Number(item.x)
                            );
                            bounds.extend(position);
                            markers.push(new kakao.maps.Marker({
                                map, position, title: item.place_name
                            }));

                            const row = document.createElement("li");
                            const link = document.createElement("a");
                            link.href = item.place_url;
                            link.textContent = item.place_name;
                            row.append(link, " · 직선거리 " + item.distance + "m");
                            results.append(row);
                        });

                        map.setBounds(bounds);
                        finish("반경 1km 내 검색 결과 " + items.length + "곳을 표시했습니다.");
                    }, {
                        location: here,
                        radius: 1000,
                        sort: kakao.maps.services.SortBy.DISTANCE
                    });
                }, () => {
                    finish("현재 위치를 가져오지 못했습니다. 브라우저의 위치 권한을 확인하세요.");
                }, { timeout: 10000 });
            });
        }
    </script>
</body>
</html>
