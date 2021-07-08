let map
let url

const display = document.getElementById('display')
const display2 = document.getElementById('display2')
const btn = document.getElementById("btn")
    //btn.setAttribute("disabled", true);


function initMap() {
    geocoder = new google.maps.Geocoder();

    map = new google.maps.Map(document.getElementById('map'), {
        center: { lat: 35.71065, lng: 139.8106170933 },
        zoom: 12,
        disableDefaultUI: true,
        zoomControl: true,

    })


    map.addListener('click', function(e) {

        display2.style.color = "royalblue";
        display2.innerHTML = "このスポットでメモリーを作成";

        document.getElementById('spot_address').value = e.latLng.lat() + ',' + e.latLng.lng();

        //btn.setAttribute("disabled", false);

        var marker = new google.maps.Marker({
            position: e.latLng,
            map: map,
            icon: {
                url: "https://maps.google.com/mapfiles/ms/micons/blue-dot.png",
                scaledSize: new google.maps.Size(45, 40)
            },
            animation: google.maps.Animation.DROP
        })

        var infoWindow = new google.maps.InfoWindow({
            position: e.latLng,
            content: "この場所でメモリーを作成する場合は<br>左の [ここで作成] ボタンを押してください",
            title: e.latLng.toString(),
            disableAutoPan: false,
            animation: google.maps.Animation.DROP
        })
        infoWindow.open(map, marker);

        map.addListener('click', function(m) {
            marker.setMap(null);
            display2.innerHTML = "このスポットでメモリーを作成";
            display2.style.color = "royalblue";
            //btn.setAttribute("disabled", false);
        })

    });

}