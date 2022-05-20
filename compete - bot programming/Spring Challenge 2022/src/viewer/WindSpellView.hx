package viewer;

import Std.int;
import h2d.Anim;
import h2d.Object;

class WindSpellView {
	
	static inline var FPS = 15;

	final object:Object;
	final anim:Anim;
	final start:Int;
	final end:Float;

	public function new( object:Object, anim:Anim, start:Int ) {
		this.object = object;
		this.anim = anim;
		this.start = start;
		this.end = start + anim.frames.length / FPS;
	}

	public function update( frame:Float ) {
		if( frame < start || frame > end ) {
			anim.visible = false;
			return;
		}

		anim.currentFrame = int(( frame - start ) * FPS );
		anim.visible = true;
	}

	public function place( x:Float, y:Float ) {
		object.x = x;
		object.y = y;
	}
}