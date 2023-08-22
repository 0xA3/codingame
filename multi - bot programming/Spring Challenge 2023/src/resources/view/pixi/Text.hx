package resources.view.pixi;

import h2d.Font;

class Text extends h2d.Text {
	
	public final anchor:TextAnchor;
	public final tscale:TextScale;
	public final position:TextPosition;

	public var zIndex = 0;

	public function new( font:Font, ?parent:h2d.Object ) {
		super( font, parent );
		anchor = new TextAnchor( this );
		tscale = new TextScale( this );
		position = new TextPosition( this, anchor, tscale );
	}
}

class TextAnchor {
	
	final text:Text;

	public var x(default, set) = 0.0;
	public function set_x( x:Float ) {
		this.x = x;
		text.position.update();
		return x;
	}
	public var y(default, set) = 0.0;
	public function set_y( y:Float ) {
		this.y = y;
		text.position.update();
		return y;
	}


	public function new( text:Text ) {
		this.text = text;
	}
	
	public function set( x:Float, ?y:Float ) {
		this.x = x;
		this.y = y == null ? x : y;
		text.position.update();
	}
}

class TextPosition {
	
	final anchor:TextAnchor;
	final scale:TextScale;
	final text:h2d.Text;

	public var x:Float;
	public var y:Float;

	public function new( text:h2d.Text, anchor:TextAnchor, scale:TextScale ) {
		this.text = text;
		this.anchor = anchor;
		this.scale = scale;
		x = text.x;
		y = text.y;
	}
	
	public function update() {
		// trace( 'update ${text.text}' );
		set( this.x, this.y );
	}

	public function set( x:Float, y:Float ) {
		final textX = x - anchor.x * text.textWidth * scale.x;
		final textY = y - anchor.y * text.textHeight * scale.y;
		text.setPosition( textX, textY );
		this.x = x;
		this.y = y;
	}
}

class TextScale {

	final text:Text;
	
	public var x = 1.0;
	public var y = 1.0;

	public function new( text:Text ) {
		this.text = text;
	}

	public function set( x:Float, ?y:Float ) {
		this.x = x;
		this.y = y == null ? x : y;
		text.position.update();
	}
}