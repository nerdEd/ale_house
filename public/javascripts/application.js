var ale_house_markers = {};
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

  var navLinks = $("#nav a"), listings = $('#ale_house_listing').css('overflow', 'hidden');

  navLinks.click(function(event) {
    event.preventDefault();
    var link = $(this);
    if (!link.hasClass('active')) {
      // Hide listings box
      listings.slideUp();
      // Un-select active links
      navLinks.removeClass('selected');
      // Select active link and 
      link.addClass('selected');
			
      $.get(this.href, function(data) {
        listings.html(data).slideDown(function() {
          $('dl dt:first a').click();
        });
      });
    }
  });

  navLinks.filter(':first').click();

  $('dl dt a').live('click', function(event) {
    event.preventDefault();
    var link = $(this);
    if (!link.hasClass('active')) {
      $('dl a').removeClass('active');
      link.addClass('active');
      $('dl dd.active').removeClass('active').animate({height: 0, padding: 0}, function() {
        $(this).css('display', '').css({height: '', padding: ''});
      });			
			if(typeof(current_marker) != 'undefined'){
				current_marker.setMap(null);
			}
			var current_position = ale_house_markers[this.id];
			current_marker = new google.maps.Marker({
		    position: current_position,
		    map: map,
		    icon: 'http://chart.apis.google.com/chart?chst=d_map_pin_icon&chld=bar|8fb220',
		    title: "Railsconf - at the Baltimore Convention Center"
		  });
			map.panTo(current_position);
      link.parents('dt').next().addClass('active').slideDown();
    }
  });
});
