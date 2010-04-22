$(document).ready(function() {
  var convention_center = new google.maps.LatLng(39.285685,-76.616936);
  var neighborhood_center = new google.maps.LatLng(39.283925,-76.597967);

  var map = new google.maps.Map(document.getElementById("map_canvas"), {
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
      link.parents('dt').next().addClass('active').slideDown();
    }
  });
});
