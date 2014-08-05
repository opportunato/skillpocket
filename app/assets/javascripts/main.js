$(function() {
	'use strict';

	if ($('.main').length > 0) {
		var carousel = new Carousel(".carousel"),
				$ul = $('.carousel ul'),
				$fullHeight = $('.full-height'),
				$b = $('body'),
				$webApp = $('.main.web-app'),
				$w = $(window),
				$tagsFilter = $('.tags-filter'),
				windowHeight = $w.height(),
				nexthammertime,
				previoushammertime,
				current_pane = 0,
				previousPost = $('.previous'),
				nextPost = $('.next'),
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

		$tagsFilter.on("click", function(e) {
			e.preventDefault();

			if ($webApp.hasClass("opened")) {
				$ul.height('auto');
			}	else {
				$ul.height($('nav').innerHeight());
			}

			setTimeout(function() {
				$webApp.toggleClass("opened");
			}, 100);
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

		nexthammertime = Hammer(nextPost[0]).on("tap", function(event) {
			event.preventDefault();
			nextCarousel();
		});

		previoushammertime = Hammer(previousPost[0]).on("tap", function(event) {
			event.preventDefault();
			previousCarousel();
		});

		$b.keydown(function(e) {

			if(e.keyCode == 37) { // left

				previousCarousel();
			}

			else if(e.keyCode == 39) { // right

				nextCarousel();
			}
		});
	}
});
