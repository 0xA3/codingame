package viewer;

import Std.int;
import h2d.Anim;

class Life {
	
	public static inline var MAX = 999;
	static inline var FPS = 15;

	final anim:Anim;
	public var start = MAX;

	public function new( anim:Anim ) {
		this.anim = anim;
	}

	public function update( f:Float ) {
		final frame = int(( f - start ) * FPS );

		if( frame < 0 ) {
			anim.visible = true;
			anim.currentFrame = 0;
		} else if( frame < anim.frames.length ) {
			anim.visible = true;
			anim.currentFrame = frame;
		} else {
			anim.visible = false;
		}
	}
}