$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){

			var item = event.data;
			if (item !== undefined && item.type === "Volde_startdisplay") {

				if (item.display === true) {
					$('#Volde_startdisplay').delay(200).fadeIn( "slow" );
				} else if (item.display === false) {
					$('#Volde_startdisplay').fadeOut( "slow" );
				}
			}
		});
	};
});