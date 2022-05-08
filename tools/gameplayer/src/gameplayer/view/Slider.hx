package gameplayer.view;

import h2d.Bitmap;
import h2d.Interactive;
import h2d.Object;
import h2d.Text;
import hxd.Event;
import hxd.Window;

/*
sliderContainer y -44
	barHeightContainer scaleY
		backgroundContainer	
			rectangle
		barContainer
			rectangle
	handleContainer
		handle
	barInteractiveContainer
		barInteractive
*/

class Slider {

	static inline var HEIGHT_CONTRACTED = 3;
	static inline var HEIGHT_EXPANDED = 8;

	final window:Window;
	final barHeightContainer:Object;
	final backgroundContainer:Object;
	final barContainer:Object;
	final barInteractiveContainer:Object;
	final handle:Bitmap;
	final barInteractive:Interactive;

	var isDragging = false;
	public var dragFraction = 0.0;

	public function new(
		window:Window,
		barHeightContainer:Object,
		backgroundContainer:Object,
		barContainer:Object,
		barInteractiveContainer:Object,
		handle:Bitmap,
		barInteractive:Interactive
	 ) {
		this.window = window;
		this.barHeightContainer = barHeightContainer;
		this.backgroundContainer = backgroundContainer;
		this.barContainer = barContainer;
		this.barInteractiveContainer = barInteractiveContainer;
		this.handle = handle;
		this.barInteractive = barInteractive;

		barInteractive.onOver = e -> expand();
		barInteractive.onOut = e -> { if( !isDragging ) contract(); }
		barInteractive.onPush = e -> {
			isDragging = true;
			onPush();
			onSlide();
			window.addEventTarget( onMove );
		}
		
		barInteractive.onRelease = e -> {
			isDragging = false;
			window.removeEventTarget( onMove );
			onRelease();
		}

		barInteractive.onReleaseOutside = e -> contract();

		contract();
	}

	function onMove( e:hxd.Event ) {
		switch e.kind {
			case EMove: onSlide();
			default: // no-op
		}
	}

	function onSlide() {
		final mouseX = window.mouseX;	
		handle.x = mouseX;
		dragFraction = mouseX / window.width;
		barContainer.scaleX = backgroundContainer.scaleX * dragFraction;
		onChange();
	}

	public function update( frame:Float, maxFrame:Int ) {
		dragFraction = frame / maxFrame;
		final x = dragFraction * window.width;
		barContainer.scaleX = backgroundContainer.scaleX * dragFraction;
		handle.x = x;
	}

	function contract() {
		barHeightContainer.scaleY = HEIGHT_CONTRACTED / HEIGHT_EXPANDED;
		handle.y = -HEIGHT_CONTRACTED / 2;
		handle.scaleX = handle.scaleY = 0.1;
	}

	function expand() {
		barHeightContainer.scaleY = 1;
		handle.y = -HEIGHT_EXPANDED / 2;
		handle.scaleX = handle.scaleY = 1;
	}

	public function resize( scaleX:Float ) {
		backgroundContainer.scaleX = scaleX;
		barInteractiveContainer.scaleX = scaleX;
		barContainer.scaleX = scaleX * dragFraction;
		handle.x = dragFraction * window.width;
	}

	public dynamic function onChange() { }
	public dynamic function onPush() { }
	public dynamic function onRelease() { }
}
