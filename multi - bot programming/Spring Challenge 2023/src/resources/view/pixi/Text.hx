package resources.view.pixi;

import h2d.Font;

class Text extends h2d.Text {
	
	public final anchor:TextAnchor;
	public final tscale:TextScale;
	public final position:TextPosition;

	public var zIndex = 0;

	public function new( font:Font, ?parent:h2d.Object ) {
		super( font, parent );
		anchor = new TextAnchor();
		tscale = new TextScale();
		position = new TextPosition( this, anchor, tscale );
	}
}

class TextAnchor {
	
	public var x = 0.0;
	public var y = 0.0;

	public function new() { }
	
	public function set( x:Float, ?y:Float ) {
		this.x = x;
		this.y = y == null ? x : y;
	}
}

class TextPosition {
	
	final anchor:TextAnchor;
	final scale:TextScale;
	final text:h2d.Text;

	public function new( text:h2d.Text, anchor:TextAnchor, scale:TextScale ) {
		this.text = text;
		this.anchor = anchor;
		this.scale = scale;
	}
	
	public function set( x:Float, y:Float ) {
		text.setPosition( x - anchor.x * text.textWidth * scale.x, y - anchor.y * text.textHeight * scale.y );
	}
}

class TextScale {

	public var x = 1.0;
	public var y = 1.0;

	public function new() {	}

	public function set( x:Float, ?y:Float ) {
		this.x = x;
		this.y = y == null ? x : y;
	}
}