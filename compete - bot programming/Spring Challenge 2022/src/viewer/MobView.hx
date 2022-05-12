package viewer;

import h2d.Object;

class MobView extends CharacterView {
	
	public static final HEALTH_BAR_Y = -44;
	public static final HEALTH_BAR_WIDTH = 48;
	public static final HEALTH_BAR_HEIGHT = 8;
	
	final healthBar:Object;
	final fullHealth:Int;

	public function new( container:Object, infoContainer:Object, object:Object, direction:TDirection, healthBar:Object, fullHealth:Int ) {
		super( container, infoContainer, object, direction );
		this.healthBar = healthBar;
		this.fullHealth = fullHealth;
	}

	public function setHealth( health:Int ) {
		if( health == fullHealth || health <= 0 ) infoContainer.visible = false;
		else {
			healthBar.scaleX = health / fullHealth;
			infoContainer.visible = true;
		}
	}

}