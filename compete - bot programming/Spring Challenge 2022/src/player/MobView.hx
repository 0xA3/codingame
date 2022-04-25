package player;

import h2d.Object;

class MobView extends CharacterView {
	
	public static final HEALTH_BAR_WIDTH = 32;
	public static final HEALTH_BAR_HEIGHT = 7;
	
	final healthBarContainer:Object;
	final healthBar:Object;
	final fullHealth:Int;

	public function new( container:Object, object:Object, healthBarContainer:Object, healthBar:Object, fullHealth:Int ) {
		super( container, object );
		this.healthBarContainer = healthBarContainer;
		this.healthBar = healthBar;
		this.fullHealth = fullHealth;
	}

	public function setHealth( health:Int ) {
		if( health == fullHealth || health <= 0 ) healthBarContainer.visible = false;
		else {
			healthBar.scaleX = health / fullHealth;
			healthBarContainer.visible = true;
		}
	}

}