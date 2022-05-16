package viewer;

import Std.int;
import h2d.Anim;
import h2d.Object;

class MobView extends CharacterView {
	
	public static final HEALTH_BAR_Y = -44;
	public static final HEALTH_BAR_WIDTH = 48;
	public static final HEALTH_BAR_HEIGHT = 8;
	public static final FPS = 15;
	
	public final anim:Anim;
	final healthBar:Object;
	final fullHealth:Int;
	final phase:Float;

	public function new( container:Object, infoContainer:Object, object:Object, direction:TDirection, anim:Anim, healthBar:Object, fullHealth:Int ) {
		super( container, infoContainer, object, direction );
		this.anim = anim;
		this.healthBar = healthBar;
		this.fullHealth = fullHealth;
		phase = Math.random();
	}

	public function setHealth( health:Int ) {
		if( health == fullHealth || health <= 0 ) infoContainer.visible = false;
		else {
			healthBar.scaleX = health / fullHealth;
			infoContainer.visible = true;
		}
	}
	
	public function animate( frame:Float ) {
		anim.currentFrame = int( phase * anim.frames.length + frame * FPS ) % anim.frames.length;
	}
}