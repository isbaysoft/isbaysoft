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
