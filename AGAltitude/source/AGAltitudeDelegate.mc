using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class AGAltitudeDelegate extends Ui.BehaviorDelegate {


	function onKey(evt) {
		var app = App.getApp();
		var key = evt.getKey();
		if (Ui.KEY_ENTER == key) {
			app.mainView.setBaseAlt();
		}
		if (Ui.KEY_DOWN == key) {
			app.mainView.unsetBaseAlt();
		}
	}
}