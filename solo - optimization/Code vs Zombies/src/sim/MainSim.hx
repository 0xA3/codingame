package sim;

import js.Browser;
import js.html.ButtonElement;
import js.html.CanvasElement;
import js.html.SelectElement;

class MainSim {
	
	public static var canvas:CanvasElement;
	public static var select:SelectElement;
	public static var play:ButtonElement;
	
	static var app:sim.App;

	static function main() {
		hxd.Res.initEmbed();
		app = new sim.App();
		app.setDimensions( Browser.window.innerWidth, Browser.window.innerHeight );

		canvas = cast( Browser.document.getElementById( "webgl" ), CanvasElement );
		select = cast( Browser.document.getElementById( "select" ), SelectElement );
		play = cast( Browser.document.getElementById( "play" ), ButtonElement );
		
		select.addEventListener( "click", e -> {
			e.preventDefault();
			app.select( select.selectedIndex );
		});
		play.addEventListener( "click", e -> app.playClick());
		
		Browser.window.addEventListener( "resize", e -> {
			canvas.width = Browser.window.innerWidth;
			canvas.height = Browser.window.innerHeight;
			canvas.style.width = '${canvas.width}px';
			canvas.style.height = '${canvas.height}px';
			app.setDimensions( canvas.width, canvas.height );
			app.resize();
		});

	}

	public static function playStarted() play.innerHTML = "Pause";
	public static function playPaused() play.innerHTML = "Resume";
	public static function playFinished() play.innerHTML = "Play";

}