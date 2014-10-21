$(function() {
	var	$menuButton = $('.menu-button'),
			$navMain = $('nav.main'),
			$overlay = $('.overlay'),
			$discoverTab = $('li.discover'),
			$discoverScreenshot = $('.screenshot.discover'),
			$connectTab = $('li.connect'),
			$connectScreenshot = $('.screenshot.connect'),
			$hireTab = $('li.hire'),
			$hireScreenshot = $('.screenshot.hire');

	$menuButton.on('click', function(e) {
		e.preventDefault();
		e.stopPropagation();
		$navMain.addClass('active');
	});

	$overlay.on('click', function(e) {
		e.preventDefault();
		e.stopPropagation();
		$navMain.removeClass('active');
	});

	$discoverTab.on('click', function(e) {
		$discoverScreenshot.addClass('active');
		$discoverTab.addClass('active');
		$connectScreenshot.removeClass('active');
		$hireScreenshot.removeClass('active');
		$connectTab.removeClass('active');
		$hireTab.removeClass('active');
	});

	$connectTab.on('click', function(e) {
		$connectScreenshot.addClass('active');
		$connectTab.addClass('active');
		$discoverScreenshot.removeClass('active');
		$hireScreenshot.removeClass('active');
		$discoverTab.removeClass('active');
		$hireTab.removeClass('active');
	});

	$hireTab.on('click', function(e) {
		$hireScreenshot.addClass('active');
		$hireTab.addClass('active');
		$connectScreenshot.removeClass('active');
		$discoverScreenshot.removeClass('active');
		$connectTab.removeClass('active');
		$discoverTab.removeClass('active');
	});

});
