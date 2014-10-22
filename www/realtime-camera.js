cordova.define("realtimecamera", function(require, exports, module) {
	var exec = require('cordova/exec');

	function RealtimeCamera(){};

	/**
	 * Begin a camera capture session
	 * @param resolution One of the following strings: [ "352x288", "640x480", "1280x720", "1920x1080" ]
	 * @param on_frame Callback which is invoked
	 */
	RealtimeCamera.prototype.startCapture = function(resolution, on_frame, on_error) {
		cordova.exec(
			on_frame,
			on_error,
			"RealtimeCamera",
			"startCapture",
			[ resolution ]
		);
	};

	/**
	 * Stop a running camera capture session. This results in the on_frame callback firing one more time with null as the param.
	 */
	RealtimeCamera.prototype.stopCapture = function() {
		cordova.exec(
			function(winParam) {},
			function(err) {},
			"RealtimeCamera",
			"endCapture",
			[]
		);
	};

	/**
	 * Take a single frame snapshot.
	 */
	RealtimeCamera.prototype.changeResolution = function(resolution) {
		cordova.exec(
			function(winParam) {},
			function(err) {},
			"RealtimeCamera",
			"changeResolution",
			[ resolution ]
		);
	};
	

	module.exports = new RealtimeCamera();
});