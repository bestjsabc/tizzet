$(document).ready( function() {
	
	$('#ticket_guarantee img').mouseover(function(){
		$(this).stop().animate({paddingTop:"0" }, 500, "swing");
	}).mouseout(function(){
		$(this).stop().animate({paddingTop:"15px" }, 500, "swing");
	});	
	
	// Form label animation
	$("#search_form input:text, #mailing_list input:text, #login_form input:text, #login_form input:password").labelit({
		time: 50
	});
	
	// Show Hide Login Box
	$("#log_in").click(function () {
    $("#login_form").slideToggle("fast");
	});
	
	//show featured	
	$("#banner").mouseover(function () {
		$("#featured").stop().animate({right: "0"}, 700);
	}).mouseout(function(){
		$("#featured").stop().animate({right: "-219px"}, 700);
	});
	
	getTwitters('tweet', { 
	  id: 'tizzet', 
	  count: 1, 
	  enableLinks: true, 
	  ignoreReplies: true, 
	  clearContents: true,
		newwindow: true,
		template: '"%text%" <a href="http://twitter.com/%user_screen_name%/statuses/%id%/">%time%</a>'
	});
	
	$('#hosts').cycle();
	
	function round_number(num, dec) {
		var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
		return result;
	}
	
	$('#seating_info').hide();
	
	show_seating();
	
	$('#product_seating_type').change(function(){
		show_seating();
	})
	
	
	$('.ticket_quantity').change(function(){
		
		var ticket_total = "";
		var price = $("#purchase_price").val();
		var line_total = "";
		var pnp = "";
		
		$('.ticket_quantity option:selected').each(function(){
			ticket_total = (round_number($(this).text() * price, 2));
		})
		
		pnp = round_number(ticket_total / 100, 2) * 10;
		line_total = (ticket_total + pnp);
		
		$("#cost_of_tickets").text("$" + ticket_total.toFixed(2));
		$("#pandp").text("$" + pnp.toFixed(2));
		$("#total").text("$" + round_number(line_total, 2).toFixed(2));
		
	});
	$('a[rel="external"]').click( function() {
      this.target = "_blank";
  });
});

function show_seating(){
	if ($("#product_seating_type").val() == "Seated"){
		$('#seating_info').show();
	}
	else {
		$('#seating_info').hide();
	}
}