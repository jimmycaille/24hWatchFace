using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Application;

class hWatchFaceView extends WatchUi.WatchFace {
	
	var isAlreadySeen;
    function initialize() {
        WatchFace.initialize();
        isAlreadySeen = false;
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        // Get the current time and format it correctly
        var clockTime = System.getClockTime();
		var h = clockTime.hour;
		var m = clockTime.min;
		var s = clockTime.sec;
		
		//update only every two minutes
		if(s == 0 && m%2==0 || !isAlreadySeen){
			isAlreadySeen = true;
	
	        // Call the parent onUpdate function to redraw the layout
	        View.onUpdate(dc);
	        
	        //ticks
	        var c=120;
	        dc.setColor(dc.COLOR_WHITE,dc.COLOR_TRANSPARENT);
			for(var i=0.0;i<360.0;i+=3.75){
				var ticCircle1;
				var ticCircle2;
				var ticWidth;
				if(i.toNumber()%15==0){
					//hour
					ticCircle1 = 100;
					ticCircle2 = 88;
					ticWidth  = 3;
					//dc.setColor(Application.getApp().getProperty("BigTicksColor"),Application.getApp().getProperty("BigTicksColor"));
				}else{
					//quarter
					ticCircle1 = 100;
					ticCircle2 = 88;
					ticWidth  = 1;
					//dc.setColor(Application.getApp().getProperty("SmallTicksColor"),Application.getApp().getProperty("SmallTicksColor"));
				}
				var outerPointx = c + ticCircle1 * Math.sin(Math.toRadians(i));
				var outerPointy = c + ticCircle1 * Math.cos(Math.toRadians(i));
				var innerPointx = c + ticCircle2 * Math.sin(Math.toRadians(i));
				var innerPointy = c + ticCircle2 * Math.cos(Math.toRadians(i));
				dc.setPenWidth(ticWidth);
				dc.drawLine(innerPointx, innerPointy, outerPointx, outerPointy);
				
				if(i.toNumber()%15==0){
					var nbCirc = 112;
					var nbPtx = c + nbCirc * Math.sin(Math.toRadians(i));
					var nbPty = c + nbCirc * Math.cos(Math.toRadians(i));
					dc.drawText(nbPtx, nbPty, dc.FONT_XTINY, (24-(i/15).toNumber()+12)%24, dc.TEXT_JUSTIFY_CENTER|dc.TEXT_JUSTIFY_VCENTER);
				}
			}
			
			
			var hrCircle   = 100; //74
			var hrCircle2  = 19;
			var hrDeg      = 10;
			
			//hand
			var hdeg =  -(h*360.0/24 + 15*m/60) - 180;
			var hx1 = c + hrCircle * Math.sin(Math.toRadians(hdeg));
			var hy1 = c + hrCircle * Math.cos(Math.toRadians(hdeg));
			var hx2 = c + hrCircle2 * Math.sin(Math.toRadians(hdeg+180-hrDeg));
			var hy2 = c + hrCircle2 * Math.cos(Math.toRadians(hdeg+180-hrDeg));
			var hx3 = c + hrCircle2 * Math.sin(Math.toRadians(hdeg+180+hrDeg));
			var hy3 = c + hrCircle2 * Math.cos(Math.toRadians(hdeg+180+hrDeg));
			var hpts = [[hx1,hy1],[hx2,hy2],[hx3,hy3]];
			//dc.setColor(Application.getApp().getProperty("HandsColor"),Application.getApp().getProperty("HandsColor"));
			dc.fillPolygon(hpts);
	        
	        //center circle
	        dc.fillCircle(c,c,9);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
