package gameplayer.view;

import h2d.Interactive;
import h2d.Object;

class ScrollBar {

	static inline var HEIGHT_CONTRACTED = 3;
	static inline var HEIGHT_EXPANDED = 8;

	final interactive:Interactive;
	final container:Object;
	final barContainer:Object;
	final bar:Object;
	
	public var isDragged = false;

	public function new( interactive:Interactive, container:Object, barContainer:Object, bar:Object ) {
		this.interactive = interactive;
		this.container = container;
		this.barContainer = barContainer;
		this.bar = bar;

		interactive.onOver = e -> expand();
		interactive.onOut = e -> if( !isDragged ) contract();

		contract();
	}

	public function update( frame:Float, maxFrame:Int ) {
		if( maxFrame == 0 ) bar.scaleX = 1;
		bar.scaleX = frame / maxFrame;
	}

	public function contract() {
		barContainer.scaleY = HEIGHT_CONTRACTED / HEIGHT_EXPANDED;
	}

	public function expand() {
		barContainer.scaleY = 1;
	}

	public function resize( scaleX:Float ) {
		container.scaleX = scaleX;
	}
}