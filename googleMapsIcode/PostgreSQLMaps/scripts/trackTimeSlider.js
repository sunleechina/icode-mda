// TrackTime slider control --------------------------------------------------------------
// Source: https://github.com/gavinharriss/google-maps-v3-trackTime-control
/*******************************************************************************
  Copyright (c) 2010-2012. Gavin Harriss
  Site: http://www.gavinharriss.com/
  Originally developed for: http://www.topomap.co.nz/

  Licences: Creative Commons Attribution 3.0 New Zealand License
  http://creativecommons.org/licenses/by/3.0/nz/
 ******************************************************************************/
function createTrackTimeControl(map, initial, track, trackIcons) {
   var sliderImageUrl = "icons/trackTime-slider.png";

   // Create main div to hold the control.
   var trackTimeDiv = document.createElement('DIV');
   trackTimeDiv.setAttribute("style", "margin:5px;overflow-x:hidden;overflow-y:hidden;background:url(" + sliderImageUrl + ") no-repeat;width:265px;height:21px;cursor:pointer;");
   trackTimeDiv.setAttribute("title","Change transparency of image overlay")

      // Create knob
      var trackTimeKnobDiv = document.createElement('DIV');
   trackTimeKnobDiv.setAttribute("style", "padding:0;margin:0;overflow-x:hidden;overflow-y:hidden;background:url(" + sliderImageUrl + ") no-repeat -265px 0;width:14px;height:21px;");
   trackTimeDiv.appendChild(trackTimeKnobDiv);

   var trackTimeCtrlKnob = new ExtDraggableObject(trackTimeKnobDiv, {
      restrictY: true,
       container: trackTimeDiv
   });

   google.maps.event.addListener(trackTimeCtrlKnob, "drag", function () {
      setTrackTime(trackTimeCtrlKnob.valueX(), track, trackIcons);
   });

   google.maps.event.addDomListener(trackTimeDiv, "click", function (e) {
      var left = findPosLeft(this);
      var x = e.pageX - left - 5; // - 5 as we're using a margin of 5px on the div
      trackTimeCtrlKnob.setValueX(x);
      setTrackTime(x, track, trackIcons);
   });

   map.controls[google.maps.ControlPosition.BOTTOM_CENTER].push(trackTimeDiv);

   // Set initial value
   var initialValue = initial;
   trackTimeCtrlKnob.setValueX(initialValue);
   setTrackTime(initialValue, track, trackIcons);
}

function setTrackTime(pixelX, track, trackIcons) {
   var MAX_X_VALUE = 251;  //change this if slider image is changed
   //console.log('Slider x value: ' + pixelX);

   var minTime = parseInt(track[track.length-1].datetime);
   var maxTime = parseInt(track[0].datetime);

   var timeDiff = maxTime - minTime;
   
   var scale = timeDiff / MAX_X_VALUE;

   //console.log(minTime);
   //console.log(maxTime);
   //console.log(scale);
   //console.log(pixelX);
   //console.log('Current slider value: ' + Math.round(minTime + pixelX*scale));
   //console.log(trackIcons.length);

   var closest = null;
   var goal = Math.round(minTime + pixelX*scale);
   var closest_index;
   for (var i=0; i < track.length; i++) {
      //console.log(i + ' : ' + track[i].datetime);
      if (closest == null || Math.abs(parseInt(track[i].datetime) - goal) < Math.abs(closest - goal)) {
         closest = parseInt(track[i].datetime);
         closest_index = i;
      }
      trackIcons[i].setIcon(tracklineIconsOptions);
   }

   //console.log('Closest node time: ' + closest);
   //console.log('Closest node index: ' + closest_index);

   //Update the closest icon
   trackIcons[closest_index].setIcon({
                     path:        'M 0,8 4,8 0,-8 -4,8 z',
                     strokeColor: '#505050',
                     fillColor:   '#505050',
                     fillOpacity: 0.6,
                     rotation:    track[closest_index].true_heading
                  });
}

function findPosLeft(obj) {
   var curleft = 0;
   if (obj.offsetParent) {
      do {
         curleft += obj.offsetLeft;
      } while (obj = obj.offsetParent);
      return curleft;
   }
   return undefined;
}
