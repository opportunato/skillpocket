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

    var trackEvent = function(eventName, data, isTimed) {
      data = data || {};
      isTimed = isTimed || false;

      if (!$.cookie(eventName) || !isTimed) {
        $.cookie(eventName, true, {expires: 1, path: '/berlin'});
        mixpanel.track(eventName, data);
      }
    }

    var toggleFilterList = function() {

      $b.toggleClass("opened");

      var navHeight = $nav.height();

      $nav.height(windowHeight-60);

      if (Modernizr.csstransforms) {
        if ($b.hasClass("opened")) {
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
            categories;

        if ($expert.data('id') === "start" || $expert.data('id') === "apply") {
          return true;
        } else {
          categories = $expert.data('categories').toString().split(',');

          return categories.indexOf(categoryId) !== -1;
        }
      });

      $ul.append($experts);

      carousel.refresh(1);
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

      $nav.height(windowHeight-60);
      if (windowHeight > 500) {
        $('.full-height').height(windowHeight);
      } else {
        $('.full-height').height(500);
      }
    });

    $w.trigger("resize");

    carousel.init(1);

    var nextCarousel = function() {
      carousel.next();
    }

    var previousCarousel = function() {
      carousel.prev();
    }

    var changeLink = function() {
      history.pushState({id: $('.current').data('id'), title: $('.current').data('title')}, "", "/berlin/" + $('.current').data('slug'));
      changeTitle();
    }

    var changeTitle = function() {
      document.title = $('.current').data('title');
    }

    var previoushammertime = Hammer(previousPost[0]).on("click", function(event) {
      event.preventDefault();

      previousCarousel();
      changeLink();
    });

    var nexthammertime = Hammer(nextPost[0]).on("click", function(event) {
      event.preventDefault();

      nextCarousel();
      changeLink();
    });

    $b.keydown(function(event) {

      if (event.keyCode == 37) { // left
        previousCarousel();
        changeLink();
      } else if (event.keyCode == 39) { // right
        nextCarousel();
        changeLink();
      }
    });

    $w.on("popstate", function(e) {
      var state = e.originalEvent.state || {}
      var $expert = $('.current');

      if (state.id) {
        var id = state.id;

        if ($expert.prev().data('id') == id) {
          previousCarousel();
        } else if ($expert.next().data('id') == id) {
          nextCarousel();
        }        
      }

      changeTitle();
    });

    var showPopup = function(page) {
      $popup.find('.wrapper').hide();
      $popup.find('.wrapper.' + page).show();

      $b.addClass("popup-opened"); 
    };

    $('.main.web-app').on("click tap", '.skill-user a.button', function(e) {
      e.preventDefault();

      var $expert = $(e.currentTarget).parents('.expert');

      showPopup('form');
      $popup.find('#berlin_connect_expert_id').val($expert.data('id'));
  
      trackEvent('Connect Initiated', { name: $expert.data('name') });
    });

    $cancel.on("click", function(e) {
      e.preventDefault();
      $b.removeClass("popup-opened");

      trackEvent('Connect Canceled');
    });

    trackEvent('Prelaunch Landed', {}, true);

    $('.introduction a.button').on('click', function(e) {
      e.preventDefault();

      carousel.next();
    });

    var getToken = function() {
      return document.querySelector('input[name="authenticity_token"]').value;
    };

    $.validate({
      form: "#connect",
      errorMessagePosition: 'top',
      validateOnBlur: false,
      onSuccess: function() {
        var data = $form.serialize();
        var $expert = $('#expert_' + $popup.find('#berlin_connect_expert_id').val())

        $.ajax({
          type: "POST",
          url: $form.attr('action'),
          headers: {
            "X-CSRF-TOKEN": getToken(),
            "X-Requested-With": 'XMLHttpRequest'
          },
          data: data,
          dataType: 'json',
          success: function(data) {
            if (data.success) {
              showPopup('success');
              trackEvent('Connect Succeeded', { name: $expert.data('name') });
            } else {
              showPopup('error');
              trackEvent('Connect Failed', { client: false, name: $expert.data('name') });
            }
          },
          error: function() {
            showPopup('error');
            trackEvent('Connect Failed', { client: false, name: $expert.data('name') });            
          }        
        });
        return false;
      },
      onError: function() {
        trackEvent('Connect Failed', { client: true });
      }
    });
  }
});
