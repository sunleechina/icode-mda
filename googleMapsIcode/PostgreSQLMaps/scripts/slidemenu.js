var slideDuration = 500;

$(document).ready(function(){   
   var $leftpanel = $('#panel_left');
   var $leftwidth = $leftpanel.width();
   var $mapcanvas = $('#map_canvas');
   var $mapwidth = $mapcanvas.width();
   var $showpanelbutton = $('#showpanel');

   //Prevent clicks in checkboxes from triggering DIV slide menu event
   $('.checkbox').click( function(e) {
      e.stopPropagation();
   });
   $('.checkboxtype').click( function(e) {
      e.stopPropagation();
   });
   $('.checkboxallships').click( function(e) {
      e.stopPropagation();
   });
   $('.link').click( function(e) {
      e.stopPropagation();
   });
   $('.inputfilebutton').click( function(e) {
      e.stopPropagation();
   });
   $('.vessellist').click( function(e) {
      e.stopPropagation();
   });


   $leftpanel.click(function() {
      togglePanel();
   });
   $showpanelbutton.click(function() {
      togglePanel();
   });

   function togglePanel() {
      $leftpanel.animate({
         left: parseInt($leftpanel.css('left'),10) == 0 ? -($leftwidth-10) : 0
      },
      {duration: slideDuration, complete: function(){
         $showpanelbutton.css('visibility',parseInt($leftpanel.css('left'),10) == 0 ? 'hidden' : 'visible');}
      });

      $mapcanvas.animate({
         left: parseInt($mapcanvas.css('left'),10) == 0 ? -($leftwidth-10) : 0,
         width: parseInt($mapcanvas.css('width'),10) == $mapwidth ? $mapwidth+($leftwidth-10) : $mapwidth
         }, 
         {duration: slideDuration, complete: function() {
             map.setZoom( map.getZoom()+1 );
             map.setZoom( map.getZoom()-1 );
         }
      });

      $('#container').css('width', $mapwidth+500);
   }

   //setTimeout(function() { togglePanel(); }, 3000);
});


