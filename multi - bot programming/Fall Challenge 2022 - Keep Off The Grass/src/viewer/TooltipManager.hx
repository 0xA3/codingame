package viewer;

import h2d.Font;
import h2d.Object;
import h2d.Text;

class TooltipManager {
	
	static final PADDING = 5;
	static final CURSOR_WIDTH = 20;

	final container:Object;
	final font:Font;

	public function new( container:Object, font:Font ) {
		this.container = container;
		this.font = font;
	}

	function generateText( text:String, size:Int, color:Int, align:String ) {
		final textEl = new Text( font, container );
		textEl.text = text;
		textEl.textAlign = align == "right" ? Right : align == "center" ? Center : Left;
		// textEl.color = color;

		return textEl;
	}

	public function updateGlobalText() {
		
	}

}