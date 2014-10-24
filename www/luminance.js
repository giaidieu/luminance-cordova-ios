cordova.define("luminance", function(require, exports, module) {
	var exec = require('cordova/exec');

	function Luminance(){};

	Luminance.prototype.startCapture = function(on_frame, on_error) {
		cordova.exec(
			on_frame,
			on_error,
			"Luminance",
			"startCapture",
			[]
		);
	};

	Luminance.prototype.stopCapture = function() {
		cordova.exec(
			function(winParam) {},
			function(err) {},
			"Luminance",
			"endCapture",
			[]
		);
	};

	module.exports = new Luminance();
});
