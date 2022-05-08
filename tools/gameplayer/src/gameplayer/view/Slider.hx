package gameplayer.view;

import h2d.Interactive;
import h2d.Object;
import hxd.Event;
import hxd.Window;

/*
sliderContainer y -44
	barHeightContainer scaleY
		backgroundContainer	
			rectangle
		barContainer
			rectangle
	barInteractiveContainer
		barInteractive
	handleContainer
		handle
*/

class Slider {

	static inline var HEIGHT_CONTRACTED = 3;
	static inline var HEIGHT_EXPANDED = 8;

	final window:Window;
	final barHeightContainer:Object;
	final backgroundContainer:Object;
	final barContainer:Object;
	final barInteractiveContainer:Object;
	final handleContainer:Object;

	final barInteractive:Interactive;

	var isDragging = false;
	public var dragFraction = 0.0;

	public function new(
		window:Window,
		barHeightContainer:Object,
		backgroundContainer:Object,
		barContainer:Object,
		barInteractiveContainer:Object,
		handleContainer:Object,
		barInteractive:Interactive
	 ) {
		this.window = window;
		this.barHeightContainer = barHeightContainer;
		this.backgroundContainer = backgroundContainer;
		this.barContainer = barContainer;
		this.barInteractiveContainer = barInteractiveContainer;
		this.handleContainer = handleContainer;
		this.barInteractive = barInteractive;

		barInteractive.onOver = e -> expand();
		barInteractive.onOut = e -> { if( !isDragging ) contract(); }
		barInteractive.onPush = e -> {
			isDragging = true;
			slide();
			window.addEventTarget( onMove );
		}
		
		barInteractive.onRelease = e -> {
			isDragging = false;
			window.removeEventTarget( onMove );
		}

		barInteractive.onReleaseOutside = e -> contract();

		contract();
	}

	function onMove( e:hxd.Event ) {
		switch e.kind {
			case EMove: slide();
			default: // no-op
		}
	}

	function slide() {
		final mouseX = window.mouseX;	
		handleContainer.x = mouseX;
		dragFraction = mouseX / window.width;
		barContainer.scaleX = backgroundContainer.scaleX * dragFraction;
		onChange();
	}

	public function update( fraction:Float ) {
		dragFraction = fraction;
		final x = fraction * window.width;
		barContainer.scaleX = backgroundContainer.scaleX * dragFraction;
		handleContainer.x = x;
	}

	public dynamic function onChange() { }

	function contract() {
		barHeightContainer.scaleY = HEIGHT_CONTRACTED / HEIGHT_EXPANDED;
		handleContainer.y = -HEIGHT_CONTRACTED / 2;
		handleContainer.scaleX = handleContainer.scaleY = 0.1;
	}

	function expand() {
		barHeightContainer.scaleY = 1;
		handleContainer.y = -HEIGHT_EXPANDED / 2;
		handleContainer.scaleX = handleContainer.scaleY = 1;
	}

	public function resize( scaleX:Float ) {
		backgroundContainer.scaleX = scaleX;
		barInteractiveContainer.scaleX = scaleX;
		barContainer.scaleX = scaleX * dragFraction;
		handleContainer.x = dragFraction * window.width;
	}
}
