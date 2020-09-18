$(function() {
			 window.onkeydown = function() {
					var kcode = event.keyCode;
					if(kcode == 116) {
						history.replaceState({}, null, location.pathname);
					}
				}
})