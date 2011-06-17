// -------------------------------------------------------------------------------------------
// kwicks navigation
// -------------------------------------------------------------------------------------------

$().ready(function() {
    $('.kwicks').kwicks({
        max : 138,
        spacing : 6,
        duration: 230
    });
});

$(document).ready(function(){
	$("#slider").easySlider({
		auto: true,
		continuous: true,
                pause: 2000,
                speed: 500,
                controlsShow: false

	});
});

 $(function(){
    $('.img1').corner("round 8px")
 });

// -------------------------------------------------------------------------------------------
// Fancybox
// -------------------------------------------------------------------------------------------

$(document).ready(function() {
	$("a#inline").fancybox({
		'hideOnContentClick': true
	});

	$("a.fancybox-img").fancybox({
		'transitionIn'	:	'elastic',
		'transitionOut'	:	'elastic',
                'easingIn'      :       'easeOutBack',
		'easingOut'     :       'easeInBack',
		'speedIn'	:	400,
		'speedOut'	:	200,
		'overlayShow'	:	true
	});

});

