var rtc = cordova.require("realtimecamera");

rtc.startCapture(
	"352x288", 
	function(fuu) { console.log('win!', fuu);  }, 
	function(err) { console.log('fail!', err); }
);