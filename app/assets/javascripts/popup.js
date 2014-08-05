$(function() {
	'use strict';

	if ($('.popup').length > 0) {
		var $popup = $('.popup'),
			$cancel = $('a.cancel');

		$cancel.on("click", function(e) {
			e.preventDefault();
			$popup.removeClass("opened");
		});
	}

});
