$(function() {
  'use strict';

  if ($('.main.web-app').length > 0) {
    var carousel = new Carousel(".carousel"),
        $ul = $('.carousel ul'),
        $fullHeight = $('.full-height'),
        $b = $('body'),
        $webApp = $('.main.web-app'),
        $w = $(window),
        $tagsFilter = $('.tags-filter'),
        $filters = $('a.filter'),
        $popup = $('.popup'),
        $cancel = $('a.cancel'),
        $nav = $('nav'),
        windowHeight = $w.height(),
        nexthammertime,
        previoushammertime,
        current_pane = 0,
        previousPost = $('.previous'),
        nextPost = $('.next'),
        panes = $('.carousel li.pane'),
        $experts = $('.carousel li.expert'),
        $expertsInMemory = $('.carousel li.expert').clone(),
        $form = $('.popup form'),
        pane_count = panes.length,
        nextCarousel,
        previousCarousel;

    var toggleFilterList = function() {
      $webApp.toggleClass("opened");

      var navHeight = $nav.height();

      if (Modernizr.csstransforms) {
        if ($webApp.hasClass("opened")) {
          $('.carousel').css("transform", "translateY("+ navHeight + "px)");
        } else {
          $('.carousel').css("transform", "translateY(0px)");
        }
      }
    }

    var filterExperts = function(categoryId) {
      $experts.remove();

      $experts = $expertsInMemory.filter(function(index, expert) {
        var $expert = $(expert),
            categories = $expert.data('categories').toString().split(',');

        return categories.indexOf(categoryId) !== -1;

      });

      $ul.append($experts);

      carousel.refresh();
      $('.full-height').height(windowHeight);
      $w.trigger('resize');
    }

    $tagsFilter.on("click", function(e) {
      e.preventDefault();

      toggleFilterList();
    });

    $nav.on("click", "a.filter", function(e) {
      e.preventDefault();

      var $filter = $(e.target),
          categoryId = $filter.data('id').toString();

      $filters.removeClass('active');
      $filter.addClass('active');
      $tagsFilter.find('.title').text($filter.text());

      toggleFilterList();
      filterExperts(categoryId);
    });

    $('.full-height').height(windowHeight);

    $w.resize(function() {
      windowHeight = $w.height();
      if (windowHeight > 500) {
        $('.full-height').height(windowHeight);
      } else {
        $('.full-height').height(500);
      }
    });

    $w.trigger("resize");

//carousel
    carousel.init();

    var nextCarousel = function() {
      var nextCarousel;
      nextCarousel = new Carousel(".carousel");
      nextCarousel.init();
      nextCarousel.showPane(current_pane + 1, true);
      if (current_pane < pane_count - 1) {
        current_pane += 1;
      }
    }

    var previousCarousel = function() {

      var previousCarousel;
      previousCarousel = new Carousel(".carousel");
      previousCarousel.init();
      previousCarousel.showPane(current_pane - 1, true);
      if (current_pane > 0) {
        current_pane -= 1;
      }

    }

    var changeLink = function(direction) {
      history.pushState({direction: direction}, "", "/berlin/" + $('.current').data('slug'));
    }


    var previoushammertime = Hammer(previousPost[0]).on("click", function(event) {
      event.preventDefault();

      previousCarousel();
      changeLink("left");
    });

    var nexthammertime = Hammer(nextPost[0]).on("click", function(event) {
      event.preventDefault();

      nextCarousel();
      changeLink("right");
    });

    $b.keydown(function(event) {

      if (event.keyCode == 37) { // left
        previousCarousel();
        changeLink("left");
      } else if (event.keyCode == 39) { // right
        nextCarousel();
        changeLink("right");
      }
    });

    $w.on("popstate", function(e) {
      var state = e.originalEvent.state || {}

      if (state.direction) {
        var direction = state.direction

        if (direction == "right") {
          previousCarousel();
        } else if (direction == "left") {
          nextCarousel();
        }
      }
    });

    $cancel.on("click", function(e) {
      e.preventDefault();
      $b.removeClass("popup-opened");
    });

    var getToken = function() {
      return document.querySelector('input[name="authenticity_token"]').value
    };

    $form.submit(function(e) {
      e.preventDefault();

      var data = $form.serialize();

      $.ajax({
        type: "POST",
        url: $form.attr('action'),
        headers: {
          "X-CSRF-TOKEN": getToken(),
          "X-Requested-With": 'XMLHttpRequest'
        },
        data: data,
        dataType: 'json'        
      });
    });

    $('.main.web-app').on("click tap", 'a.button', function(e) {
        e.preventDefault();

        var $expert = $(e.currentTarget).parents('.expert');

        $b.addClass("popup-opened");
        $popup.find('#connect_expert_id').val($expert.data('id'));
    });
  }
});
