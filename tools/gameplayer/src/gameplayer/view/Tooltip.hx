package gameplayer.view;

import Std.int;
import h2d.Bitmap;
import h2d.Object;
import h2d.Text;
import hxd.Window;

class Tooltip {
	
	static inline var WIDTH = 70;

	final window:Window;
	final tooltipArrow:Bitmap;
	final tooltipContainer:Object;
	final tooltipText:Text;
	
	public function new(
		window:Window,
		tooltipArrow:Bitmap,
		tooltipContainer:Object,
		tooltipText:Text
	) {
		this.window = window;
		this.tooltipArrow = tooltipArrow;
		this.tooltipContainer = tooltipContainer;
		this.tooltipText = tooltipText;
		
		hide();
	}

	public function update( frame:Float, maxFrame:Int ) {
		tooltipText.text = '${int( frame )}/$maxFrame';
		final x = frame / maxFrame * window.width;
		tooltipArrow.x = x;
		tooltipContainer.x = Math.max( 0, Math.min( window.width - 70, x - 35 ));
	}

	public function show() {
		tooltipArrow.visible = true;
		tooltipContainer.visible = true;
	}
	
	public function hide() {
		tooltipArrow.visible = false;
		tooltipContainer.visible = false;
	}
}