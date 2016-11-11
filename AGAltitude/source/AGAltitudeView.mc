//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Math as Math;

var baseAlt;
var settingBaseAlt;
var unsettingBaseAlt;
var baseAltSet;

class AGAltitudeView extends Ui.View {

    var posnInfo = null;

    //! Load your resources here
    function onLayout(dc) {
	    baseAlt = 0;
	    settingBaseAlt = false;
	    unsettingBaseAlt = false;
	    baseAltSet = false;
    }

    function onHide() {
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        var string;

        // Set background color
        dc.setColor( Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        var devicesettings = Sys.getDeviceSettings();
        
        if (settingBaseAlt == true) {
        	dc.drawText( (dc.getWidth() / 2), 65, Gfx.FONT_MEDIUM, "Press select to \nconfirm setting \nthis as base", Gfx.TEXT_JUSTIFY_CENTER );
        }
        else if (unsettingBaseAlt == true) {
        	dc.drawText( (dc.getWidth() / 2), 65, Gfx.FONT_MEDIUM, "Press down to \nconfirm setting \nbase alt to MSL", Gfx.TEXT_JUSTIFY_CENTER );
        }
        else{
	        if (devicesettings.elevationUnits == true){
		        if( posnInfo != null ) {
		            string = posnInfo.altitude.toNumber() - baseAlt;
		            dc.drawText((dc.getWidth() / 2), 20, Gfx.FONT_SMALL, "GPS", Gfx.TEXT_JUSTIFY_CENTER);
		            dc.drawText((dc.getWidth() / 2), 50, Gfx.FONT_SYSTEM_NUMBER_THAI_HOT, string, Gfx.TEXT_JUSTIFY_CENTER );
		            if (baseAltSet == false) {
		            	dc.drawText((dc.getWidth() / 2), 150, Gfx.FONT_SMALL, "feet", Gfx.TEXT_JUSTIFY_CENTER);
		            }
		            else {
		           		dc.drawText((dc.getWidth() / 2), 150, Gfx.FONT_SMALL, "feet AGL", Gfx.TEXT_JUSTIFY_CENTER);
		            }
		        }
		        else if (posnInfo != null && posnInfo.accuracy != 0){
		        	string = posnInfo.altitude.toNumber() - baseAlt;
		        	dc.drawText((dc.getWidth() / 2), 30, Gfx.FONT_SMALL, "No GPS", Gfx.TEXT_JUSTIFY_CENTER);
		            dc.drawText( (dc.getWidth() / 2), 50, Gfx.FONT_SYSTEM_NUMBER_THAI_HOT, string, Gfx.TEXT_JUSTIFY_CENTER );
		            if (baseAltSet == false) {
		            	dc.drawText((dc.getWidth() / 2), 150, Gfx.FONT_SMALL, "feet", Gfx.TEXT_JUSTIFY_CENTER);
		            }
		            else {
		           		dc.drawText((dc.getWidth() / 2), 150, Gfx.FONT_SMALL, "feet AGL", Gfx.TEXT_JUSTIFY_CENTER);
		            }
		        }
		        else {
		            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Gfx.FONT_SMALL, "No position info", Gfx.TEXT_JUSTIFY_CENTER );
		        }
		     }
		     else {
		    	 dc.drawText( (dc.getWidth() / 2), 80, Gfx.FONT_MEDIUM, "Please change units \nto feet", Gfx.TEXT_JUSTIFY_CENTER );
		     }
	    }
    }

    function setPosition(info) {
        posnInfo = info;
        Ui.requestUpdate();
    }

	function setBaseAlt() {
		if (settingBaseAlt == false) {
			settingBaseAlt = true;
			Ui.requestUpdate();
		}
		else {
			baseAlt = posnInfo.altitude.toNumber();
			settingBaseAlt = false;
			baseAltSet = true;
			Ui.requestUpdate();
		}

	}
	
	function unsetBaseAlt() {
		if (unsettingBaseAlt == false) {
			unsettingBaseAlt = true;
			Ui.requestUpdate();
		}
		else {
			baseAlt = 0;
			unsettingBaseAlt = false;
			baseAltSet = false; 
			Ui.requestUpdate();
		}
	}

}
