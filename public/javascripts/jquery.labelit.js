/*
 * jQuery labelit 1.1
 *
 * Copyright (c) 2010 Richard Biffin
 * Licensed under the MIT (MIT-LICENSE.txt) 
 *
 */
(function ($) {
	/*
	 * plugin for displaying semantic form labels
	 * inline and with nice animation effects
	*/
	$.fn.labelit = function (options) {
				
		var opts = $.extend({}, $.fn.labelit.defaults, options);
	 	
		return this.each(function () {
		
			var label = $(this).prev();
			var input = $(this);
			
			// set default css styling on li, label and input tags
			// adds position relative to the li			
			label.parent().css("position", "relative");
			
			var inputCss = {
				'position' : 'relative',
				'z-index': '10',
				'background' : 'none'
			};
						
			label.next().css(inputCss);
			
			var labelCss = {
				'position' : 'absolute',
				'z-index': '0',
				'top' : '0',
				'left' : '0',
				'display' : 'inline-block'
			};
			
			label.css(labelCss);			
	   	
	   	 var o = $.meta ? $.extend({}, opts, input.data()) : opts;
			
			input.focus( function(){
		
					switch(o.fx)
					{
 					case "fade":
					  $.fn.labelit.fade(input, o.time, o.max_opacity, o.min_opacity);
					  break;
					case "slide":
					  $.fn.labelit.slide(input, o.time, o.direction, o.distance);
					  break;
					}									
			}).keyup( function(){
					switch(o.fx)
					{
					case "fade":
					  $.fn.labelit.fade(input, o.time, o.max_opacity, o.min_opacity);
					  break;					
					}
			}).blur( function(){
			 		switch(o.fx)
			 		{
			 		case "fade":
			 		  $.fn.labelit.fade(input, o.time, o.min_opacity, o.max_opacity);
			 		  break;
			 		case "slide":
			 		  $.fn.labelit.slide(input, o.time, o.direction, 0);
			 		  break;
			 		}
			});
		});
	};
	
	// plugin defaults
	$.fn.labelit.defaults = {
		fx: 'fade',
		time: 500,		
		direction: 'left',
		distance: 100,
		min_opacity: 0.5,
		max_opacity: 1
	};
	
	$.fn.labelit.fade = function (obj, time, max_opacity, min_opacity){
		  if(obj.val() === ""){						
		 	  obj.prev().fadeTo(time, min_opacity);
		  }else{
		 	  obj.prev().fadeTo(time, 0);
		  }
	    return obj;
		};
		
	$.fn.labelit.slide = function (obj, time, direction, distance) {
			obj.prev().animate({"left":distance}, time);
			return obj;
		};
	
})(jQuery);
