$(function() {
  'use strict';

  if ($('.intro').length > 0) {
    var carousel = new Carousel(".carousel"),
        $ul = $('.carousel ul'),
        $fullHeight = $('.full-height'),
        $b = $('body'),
        $w = $(window),
        windowHeight = $w.height(),
        current_pane = 0,
        panes = $('.carousel li.pane'),
        pane_count = panes.length,
        nextCarousel,
        previousCarousel;



//typed
    setTimeout(function() {
      return $("#typed").typed({
        strings: ["Meet experts near you"],
        typeSpeed: 20
      }, 300);
    });



//ui
    $('a.button').on("click", function(e) {
      e.preventDefault();
    });

    $ul.on("mousemove", function(e) {
      e.preventDefault();
      $ul.removeClass("animation-start");
    });

    $ul.on("touchmove", function(e) {
      $ul.removeClass("animation-start");
    });

    $fullHeight.height(windowHeight);

    $w.resize(function() {
      windowHeight = $w.height();
      if (windowHeight > 500) {
        $fullHeight.height(windowHeight);
      } else {
        $fullHeight.height(500);
      }
    });

    $w.trigger("resize");


//carousel
    carousel.init();

    nextCarousel = function() {
      var nextCarousel;
      nextCarousel = new Carousel(".carousel");
      nextCarousel.init();
      nextCarousel.showPane(current_pane + 1, true);
      if (current_pane < pane_count - 1) {
        current_pane += 1;
      }
    }

    previousCarousel = function() {

      var previousCarousel;
      previousCarousel = new Carousel(".carousel");
      previousCarousel.init();
      previousCarousel.showPane(current_pane - 1, true);
      if (current_pane > 0) {
        current_pane -= 1;
      }

    }
  }
});
