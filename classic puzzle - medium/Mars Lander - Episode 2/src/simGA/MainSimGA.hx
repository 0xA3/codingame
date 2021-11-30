package simGA;

import js.Browser;
import js.html.ButtonElement;
import js.html.CanvasElement;
import js.html.SelectElement;

// Simulation Generic Algorithm version

class MainSimGA {

	public static var canvas:CanvasElement;
	public static var select:SelectElement;
	public static var sim:ButtonElement;
	public static var play:ButtonElement;

	static var app:AppGA;

	static function main() {
		hxd.Res.initEmbed();
		app = new AppGA();
		
		canvas = cast( Browser.document.getElementById( "webgl" ), CanvasElement );
		select = cast( Browser.document.getElementById( "select" ), SelectElement );
		sim = cast( Browser.document.getElementById( "sim" ), ButtonElement );
		play = cast( Browser.document.getElementById( "play" ), ButtonElement );

		select.addEventListener( "click", e -> {
			e.preventDefault();
			app.select( select.selectedIndex );
			play.disabled = true;
		});
		sim.addEventListener( "click", e -> app.simClick());
		play.addEventListener( "click", e -> app.playClick());

		Browser.window.addEventListener( "resize", e -> {
			canvas.width = Browser.window.innerWidth;
			canvas.height = Browser.window.innerHeight;
			canvas.style.width = '${canvas.width}px';
			canvas.style.height = '${canvas.height}px';
			app.resize();
		});

	}

	public static function simulationStarted() {
		sim.innerHTML = "Pause";
		play.innerHTML = "Play";
		play.disabled = true;
	}
	public static function simulationPaused() sim.innerHTML = "Resume";
	public static function simulationFinished() {
		sim.innerHTML = "New Simulation";
		play.disabled = false;
	}
	public static function playStarted() play.innerHTML = "Pause";
	public static function playPaused() play.innerHTML = "Resume";
	public static function playFinished() play.innerHTML = "Play";

	public static function initMouseMove( app:AppGA ) Browser.document.body.addEventListener( "mousemove", e -> { app.onMouseMove( e.clientX ); });
}
