$(function() {
  'use strict';

  if ($('.main').length > 0) {
    var carousel = new Carousel(".carousel"),
        $ul = $('.carousel ul');

    setTimeout(function() {
      return $("#typed").typed({
        strings: ["Meet experts near you"],
        typeSpeed: 20
      }, 300);
    });

    carousel.init();

    $('a.button').on("click", function(e) {
      e.preventDefault();
    });

    $ul.on("mousemove", function(e) {
      e.preventDefault();
      $ul.removeClass("animation-start");
    });

    $ul.on("touchmove", function(e) {
      e.preventDefault();
      $ul.removeClass("animation-start");
    });
  }
});
