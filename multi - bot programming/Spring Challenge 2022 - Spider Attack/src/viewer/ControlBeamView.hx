package viewer;

import Std.int;
import h2d.Anim;
import h2d.Object;

class ControlBeamView {
	
	final object:Object;
	final anim:Anim;
	public final heroId:Int;
	final start:Int;

	public function new(
		object:Object,
		anim:Anim,
		heroId:Int,
		start:Int
	) {
		this.object = object;
		this.anim = anim;
		this.heroId = heroId;
		this.start = start;
	}

	public function update( frame:Float, intFrame:Int, subFrame:Float ) {
		if( frame < start )	object.visible = false;
		else if( frame < start + 1 ) {
			object.visible = true;
			anim.currentFrame = int( subFrame * anim.frames.length );
		} else( object.visible = false );
	}
	
	public function place( x:Float, y:Float ) {
		object.x = x;
		object.y = y;
	}
}