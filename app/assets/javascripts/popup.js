$(function() {
	'use strict';

	if ($('.popup').length > 0) {
		var $b = $('body'),
				$cancel = $('a.cancel');

		$cancel.on("click", function(e) {
			e.preventDefault();
			$b.removeClass("popup-opened");
		});
	}

});
