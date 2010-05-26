var ale_houses = {};
var map;
var neighborhood_center;
var current_marker;
var currentWindow, currentWindowContent;
var dummyImage = 'http://dummyimage.com/48x48/eee.gif&text=woof...';
var image_cache = {};

$(document).ready(function() {
  var convention_center = new google.maps.LatLng(39.285685,-76.616936);
	neighborhood_center = new google.maps.LatLng(39.283925,-76.597967);  	
	
  map = new google.maps.Map(document.getElementById("map_canvas"), {
    zoom: 14,
    center: neighborhood_center,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: false
  });

  var conf_size = new google.maps.Size(38, 21);
  var conf_offset = new google.maps.Point(20, 5);
  var conf_icon = new google.maps.MarkerImage('/images/railsconf.png', conf_size, null, conf_offset);
  
  var conf_shadow_size = new google.maps.Size(49, 21);
  var conf_shadow_icon = new google.maps.MarkerImage('/images/railsconf-shadow.png', conf_shadow_size, null, conf_offset);

  var conf_marker = new google.maps.Marker({
    position: convention_center,
    map: map,
    icon: conf_icon,
    shadow: conf_shadow_icon,
    title: "Railsconf - at the Baltimore Convention Center"
  });

  // var ignite_latlng = new google.maps.LatLng(39.284772, -76.613181);
  // var ignite_marker = new google.maps.Marker({
  //   map: map,
  //   position: ignite_latlng
  // });

  var navLinks = $("#nav a"), listings = $('#ale_house_listing');

  navLinks.click(function(event) {
    var link = $(this);
    if (!link.hasClass('active')) {
      // Un-select active links
      navLinks.removeClass('active');

      // Select active link and 
      link.addClass('active');

      // Clear any description currently shown
      $('#description_container p').text('');

      clearMarker();
      removeNeighborhoodMarkers();

      var neighborhood_id = this.id.split("/")[2]; 

      panToNeighborhood(neighborhood_id);

      var id = this.id;
      listings.fadeOut(function() {
        $.get(id, function(data) {
          listings.html(data).fadeOut(function() {
            // Hide listings box
            dropMarkersForNeighborhood(neighborhood_id);
            listings.fadeIn();
          });
        });
      });
    }
  });

	var activeNeighborhoodLink = window.location.hash ? $('a[href$="' + window.location.hash + '"]') : navLinks.filter(':first');
	activeNeighborhoodLink.click();
  activeNeighborhoodLink.addClass('active');


  $('.locations a.ale_house').live('click', function(event) {
    event.preventDefault();
    var link = $(this);
    if (!link.hasClass('active')) {

      // Remove the active class from everyone but the current selection
      $('ul.locations a.active').removeClass('active');
      link.addClass('active');

      // Add the description for this ale house to the page
      var id_parts = this.id.split("-");
      var neighborhood_id = id_parts[0];
      var ale_house_id = id_parts[1];

      $('#description_container p').text(ale_houses[neighborhood_id][ale_house_id]['description']);

      clearMarker();

      // Create a marker for the current selection
			var current_position = ale_houses[neighborhood_id][ale_house_id]['position'];
			current_marker = new google.maps.Marker({
		    position: current_position,
		    map: map,
		    icon: 'http://chart.apis.google.com/chart?chst=d_map_pin_icon&chld=bar|8fb220',
		    title: link.text() 
		  });
      
      var ale_house = ale_houses[neighborhood_id][ale_house_id], image_src;
      if (image_cache[ale_house['created_by']]) {
        image_src = image_cache[ale_house['created_by']];
      } else {
        image_src = dummyImage;
        $.getScript('http://twitter.com/users/show.json?callback=setTwitterIcon&screen_name=' + ale_house['created_by']);
      }
      var image = '<img alt="via ' + ale_house['created_by'] + '" src="' + image_src + '" style="float:left; margin:0 5px 0 0;" width="48" height="48" />';
      currentWindowContent = image + '<p style="margin-top:5px;">' + ale_house['description'] + '</p>';
      currentWindow = new google.maps.InfoWindow({
        content: currentWindowContent,
        maxWidth: 300
      });
      currentWindow.open(map, current_marker);

      // Move the map to the new selection
			map.panTo(current_position);
    }
  });

  function panToNeighborhood(neighborhood_id) {
      $.getJSON(
        '/neighborhoods/' + neighborhood_id,
        null,
        function(json) {
                neighborhood_center = new google.maps.LatLng(json.neighborhood.lat,json.neighborhood.long);
                map.panTo(neighborhood_center);
        }
    );
  }

  function clearMarker() {
    if(typeof(current_marker) != 'undefined'){
      current_marker.setMap(null);
      currentWindow.close();
    } 
  }

  function dropMarkersForNeighborhood(neighborhood_id) {
    var hoodbars;
    if (hoodbars = ale_houses[neighborhood_id]) {
      $.each(hoodbars, function(data){
        var current = ale_houses[neighborhood_id][data];
        if (current['marker']) {
          current['marker'].setMap(map);
        } else {
          current['marker'] = dropMarkerForPosition(neighborhood_id, data, current['position']);
        }
      });
    }
  }

  function removeNeighborhoodMarkers() {
    $.each(ale_houses, function(data) {
      removeMarkersForNeighborhood(data);
    });
  }

  function removeMarkersForNeighborhood(neighborhood_id) {
    var hoodbars = ale_houses[neighborhood_id];
    $.each(hoodbars, function(data){
      var current = ale_houses[neighborhood_id][data];
      if(current['marker']) {
        current['marker'].setMap(null);
      }
    });
  }

  function dropMarkerForPosition(neighborhood_id, ale_house_id, position, description) {
    var marker = new google.maps.Marker({
      position: position,
      map: map,
      icon: '/images/red-dot.png'
    });

    google.maps.event.addListener(marker, 'click', function() {
      $('#' + neighborhood_id + '-' + ale_house_id).click();
    });
    return marker;
  }
});

function setTwitterIcon(data) {
  var icon = data['profile_image_url'];
  if (currentWindow) {
    image_cache[data['screen_name']] = icon;
    currentWindow.setContent(currentWindowContent.replace('src="' + dummyImage + '"', 'src="' + icon + '"'));
  }
}
