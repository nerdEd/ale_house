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

      clearMarker();
			map.panTo(neighborhood_center);

      $.get(this.id, function(data) {
        listings.html(data).slideDown(function() {
          $('dl dt:first a').click();
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
      $('#description_container p').text(ale_houses[this.id]['description'])

      clearMarker();

      // Create a marker for the current selection
			var current_position = ale_houses[this.id]['position'];
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
});
