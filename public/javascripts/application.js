var ale_houses = {};
var map;
var neighborhood_center;
var current_marker;

$(document).ready(function() {
  var convention_center = new google.maps.LatLng(39.285685,-76.616936);
	neighborhood_center = new google.maps.LatLng(39.283925,-76.597967);  	
	
  map = new google.maps.Map(document.getElementById("map_canvas"), {
    zoom: 14,
    center: neighborhood_center,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: false
  });

  var marker = new google.maps.Marker({
    position: convention_center,
    map: map,
    icon: 'images/red_flag_30.png',
    title: "Railsconf - at the Baltimore Convention Center"
  });

  var navLinks = $("#nav a"), listings = $('#ale_house_listing');

  navLinks.click(function(event) {
    var link = $(this);
    if (!link.hasClass('active')) {
      // Hide listings box
      listings.slideUp();

      // Un-select active links
      navLinks.removeClass('active');

      // Select active link and 
      link.addClass('active');

      // Clear any description currently shown
      $('#description_container p').text('');

      clearMarker();
      removeNeighborhoodMarkers();
			map.panTo(neighborhood_center);

      var neighborhood_id = this.id.split("/")[2]; 
      $.get(this.id, function(data) {
        listings.html(data).slideDown(function() {
          // TODO: Holy shit is this brittle
          dropMarkersForNeighborhood(neighborhood_id);
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

      // Move the map to the new selection
			map.panTo(current_position);
    }
  });

  function clearMarker() {
    if(typeof(current_marker) != 'undefined'){
      current_marker.setMap(null);
    } 
  }

  function dropMarkersForNeighborhood(neighborhood_id) {
    var hoodbars = ale_houses[neighborhood_id];
    $.each(hoodbars, function(data){
      var current = ale_houses[neighborhood_id][data];
      if(current['marker']) {
        current['marker'].setMap(map);
      } else {
        current['marker'] = dropMarkerForPosition(current['position']);
      }
    });
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

  function dropMarkerForPosition(position) {
    var marker = new google.maps.Marker({
      position: position,
      map: map,
      icon: '/images/red-dot.png'
    });
    return marker;
  }
});
