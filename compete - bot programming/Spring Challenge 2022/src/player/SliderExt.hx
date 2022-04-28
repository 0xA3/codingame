package player;

import hxd.Event;

class SliderExt extends h2d.Slider {
	
	public var overValue = 0.0;

	public function new(?width:Int = 50, ?height:Int = 10, ?parent) {
		super( width, height, parent );
	}

	override function handleEvent(e:hxd.Event) {
		super.handleEvent(e);
		if( e.cancel ) return;
		switch( e.kind ) {
		case EOver, EMove:
			var dx = getDx();
		   	handleDX = e.relX - dx;

			// If clicking the slider outside the handle, drag the handle
			// by the center of it.
			if (handleDX - cursorTile.dx < 0 || handleDX - cursorTile.dx > cursorTile.width) {
			  handleDX = cursorTile.width * 0.5;
			}

			overValue = getValue( e.relX );
			
			onOverValue();
		default:
		}
	}
	
	public dynamic function onOverValue() { }

}