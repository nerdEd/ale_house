$.jQTouch({
  cacheGetRequests: true,
  fixedViewport: true,
  fullscreen: true,
  icon: 'jqtouch.png'
});

// $(document).ready(function() {
  // var navLinks = $("#nav a"), listings = $('#ale_house_listing').css('overflow', 'hidden');
  // 
  // navLinks.click(function(event) {
  //   event.preventDefault();
  //   var link = $(this);
  //   if (!link.hasClass('active')) {
  //     // Hide listings box
  //     listings.slideUp();
  //     // Un-select active links
  //     navLinks.removeClass('selected');
  //     // Select active link and 
  //     link.addClass('selected');
  //     $.get(this.href, function(data) {
  //       listings.html(data).slideDown(function() {
  //         $('dl dt:first a').click();
  //       });
  //     });
  //   }
  // });
  // 
  // navLinks.filter(':first').click();
  // 
  // $('dl dt a').live('click', function(event) {
  //   event.preventDefault();
  //   var link = $(this);
  //   if (!link.hasClass('active')) {
  //     $('dl a').removeClass('active');
  //     link.addClass('active');
  //     $('dl dd.active').removeClass('active').animate({height: 0, padding: 0}, function() {
  //       $(this).css('display', '').css({height: '', padding: ''});
  //     });
  //     link.parents('dt').next().addClass('active').slideDown();
  //   }
  // });
  // 
// });