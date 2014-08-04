$(function() {
	'use strict';

	if ($('.main').length > 0) {
		var carousel = new Carousel(".carousel"),
				$ul = $('.carousel ul'),
				$fullHeight = $('.full-height'),
				$b = $('body'),
				$w = $(window),
				windowHeight = $w.height();

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

		$fullHeight.height(windowHeight);

		$w.resize(function() {
			windowHeight = $w.height();
			$fullHeight.height(windowHeight);
		});

		$w.trigger("resize");
	}
});
