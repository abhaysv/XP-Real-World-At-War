

$(document).ready(function(){


	if($("#slides-container").length > 0)
	{
		$("#myController").jFlow({
			slides: "#slides",
			controller: ".jFlowControl", // must be class, use . sign
			slideWrapper : "#jFlowSlide", // must be id, use # sign
			selectedWrapper: "jFlowSelected",  // just pure text, no sign
			easing: "swing",
			width: "820px",
			auto: true,
			height: "225px",
			duration: 600,
			prev: ".jFlowPrev", // must be class, use . sign
			next: ".jFlowNext" // must be class, use . sign
		});
	}

	$('ul.dropdown').superfish({
		autoArrows: false 
	});  

});