$(function() {
	var	$menuButton = $('.menu-button'),
			$navMain = $('nav.main'),
			$overlay = $('.overlay'),
			$discoverTab = $('li.discover'),
			$discoverScreenshot = $('.screenshot.discover'),
			$connectTab = $('li.connect'),
			$connectScreenshot = $('.screenshot.connect'),
			$hireTab = $('li.hire'),
			$hireScreenshot = $('.screenshot.hire'),
			$addSocial = $('.add-social'),
			$socialNetworks = $('.social-networks');

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

	$("#typed").typed({
    strings: ["designers ^1000 ", "engineers ^1000 ", "marketeers ^1000 ", "investors ^1000 ", "copy writers ^1000 ", "producers ^1000 ", "photographers ^1000 ", "analysts ^1000 ", "creatives ^1000 ", "PR specialists ^1000 "]
  });

  $addSocial.on('click', function(e) {
		e.preventDefault();
		e.stopPropagation();
		$socialNetworks.addClass('active');
		$(this).remove();
	});

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function(e) {
        $(input).parent('.image_upload').css('backgroundImage', "url(" + e.target.result + ")");
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $(".image_upload input[type=file]").change(function(){
    readURL(this);
  });
});
