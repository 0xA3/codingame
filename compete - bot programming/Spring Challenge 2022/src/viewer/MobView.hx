package viewer;

import Std.int;
import h2d.Anim;
import h2d.Object;

class MobView extends CharacterView {
	
	public static final HEALTH_BAR_Y = -44;
	public static final HEALTH_BAR_WIDTH = 48;
	public static final HEALTH_BAR_HEIGHT = 8;
	static inline var FPS = 15;
	
	final anim:Anim;
	final deathAnim:Anim;
	final healthBar:Object;
	final fullHealth:Int;
	final phase:Float;
	final startFrame:Int;
	public var endFrame( default, null ) = -1;
	var deathEndFrame:Float;

	public function new(
		container:Object,
		infoContainer:Object,
		object:Object,
		direction:TDirection,
		anim:Anim,
		deathAnim:Anim,
		healthBar:Object,
		fullHealth:Int,
		startFrame:Int
	) {
		super( container, infoContainer, object, direction );
		this.anim = anim;
		this.deathAnim = deathAnim;
		this.healthBar = healthBar;
		this.fullHealth = fullHealth;
		this.startFrame = startFrame;
		phase = Math.random();
	}

	public function setEndFrame( endFrame:Int, isDying:Bool ) {
		this.endFrame = endFrame;
		deathEndFrame = isDying ? endFrame + deathAnim.frames.length / FPS : endFrame;
	}

	public function setHealth( health:Int ) {
		if( health < fullHealth && health >= 0 ) {
			healthBar.scaleX = health / fullHealth;
			infoContainer.visible = true;
		}
	}
	
	public function update( frame:Float ) {
		if( frame < startFrame ) {
			infoContainer.visible = false;
			anim.visible = false;
			deathAnim.visible = false;
			return;
		}
		
		if( frame < endFrame ) {
			anim.currentFrame = int( phase * anim.frames.length + frame * FPS ) % anim.frames.length;
			deathAnim.visible = false;
			anim.visible = true;
			return;
		}
		
		if( frame >= endFrame ) {
			infoContainer.visible = false;
			anim.visible = false;
		}

		if( frame < deathEndFrame ) {
			deathAnim.currentFrame = int(( frame - endFrame ) * FPS );
			deathAnim.visible = true;
		} else {
			deathAnim.visible = false;
		}
	}
}