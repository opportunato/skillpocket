$(function() {

var carousel = new Carousel(".carousel"),
	$ul = $('.carousel ul');

setTimeout(function() {
	return $("#typed").typed({
		strings: ["Meet experts near you"],
		typeSpeed: 20
	}, 300);
});

carousel.init();

$ul.on("mousemove", function(e) {
	e.preventDefault();
	$ul.removeClass("animation-start");
});

});
