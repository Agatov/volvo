/*Google Maps*/
function initialize() {
    var map = new google.maps.Map(document.getElementById('map-block'),
        mapOptions);
    var featureOpts = [ { "stylers": [ { "saturation": -100 } ] } ];
    var styledMap = new google.maps.StyledMapType(featureOpts,{name: "Styled Map"});

    var mapOptions = {
        zoom: 16,
        center: new google.maps.LatLng(55.686898, 37.528109),
        disableDefaultUI: true,
        scrollwheel: false,
        zoomControl: true,
        zoomControlOptions: {
            style: google.maps.ZoomControlStyle.SMALL,
            position: google.maps.ControlPosition.RIGHT_CENTER
        },
        mapTypeControlOptions: {
            mapTypeIds: [google.maps.MapTypeId.ROADMAP, 'map_style']
        }
    };
    var map = new google.maps.Map(document.getElementById('map-block'),
        mapOptions);


    var Marker = new google.maps.Marker({
        position: new google.maps.LatLng(55.686898, 37.528109),
        map: map,
        icon: {
            url: 'assets/marker.png',
            size: new google.maps.Size(67,98),
            origin: new google.maps.Point(0,0),
            anchor: new google.maps.Point(35, 95)
        }
    });
    map.mapTypes.set('map_style', styledMap);
    map.setMapTypeId('map_style');

}

google.maps.event.addDomListener(window, 'load', initialize);