# [Luminance](http://github.com/casoninabox/luminance-cordova-ios)
### for iOS PhoneGap / Cordova
***

Realtime brightness values from the camera. Cordova plugin for iOS.

It uses *AVCaptureVideoDataOutput* to create a capture session. Each frame's luminance is analyzed and passed back.

### How to Install
***

cordova plugin add http://github.com/casoninabox/luminance-cordova-ios.git


### How to Remove
***

cordova plugin rm com.casonclagg.luminance


### How to Use
***

#### General Usage

    <script>
    		document.addEventListener("deviceready", function() {
        		var rtc = cordova.require("luminance");

				rtc.startCapture(
					function(luminance) { 
						//Do Stuff
				}, 
				function(error) { 
					// That sucks
				}
			);
    	});
    </script>

#### Angular/Ionic Usage

	<script>
	    $ionicPlatform.ready(function() {
	       var rtc = cordova.require("luminance");
			rtc.startCapture(
				function(luminance) { 
					//Do Stuff
				}, 
				function(error) { 
					// That sucks
				}
			);
	    });
	</script>


### Known Issues & Roadmap/TODO
***

* WORKS PERFECTLY NOW ON IOS 9 AND 10.
* Add option for setting FPS


### Author & Contributions
***

Cason Clagg <cason@cason.cc>

Fork it. Critique it. Contribute.

### License
***

MIT
