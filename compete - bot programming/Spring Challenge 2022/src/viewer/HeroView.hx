package viewer;

import h2d.Anim;
import h2d.Object;
import h2d.Text;

class HeroView extends CharacterView {

	static inline var FPS = 15;
	
	final textField:Text;
	final runAnim:Anim;
	final combatAnim:Anim;
	final idleAnim:Anim;
	final castAnim:Anim;

	final anims:Array<Anim>;
	public final states:Array<THeroState> = [];
	public final stateStarts:Array<Int> = [];

	public function new(
		container:Object,
		infoContainer:Object,
		object:Object,
		runAnim:Anim,
		combatAnim:Anim,
		idleAnim:Anim,
		castAnim:Anim,
		direction:TDirection,
		textField:Text
	) {
		super( container, infoContainer, object, direction );
		this.runAnim = runAnim;
		this.combatAnim = combatAnim;
		this.idleAnim = idleAnim;
		this.castAnim = castAnim;
		this.textField = textField;

		anims = [runAnim, combatAnim, idleAnim, castAnim];
	}

	public function setMessage( message:String ) {
		if( message == "" ) {
			infoContainer.visible = false;
		}
		textField.text = message;
		infoContainer.visible = true;
	}

	public function update( frame:Float, heroState:THeroState ) {
		final currentAnim = switch heroState {
			case Run: runAnim;
			case Combat: combatAnim;
			case Idle: idleAnim;
			case Cast: castAnim;
		}

		for( anim in anims ) anim.visible = anim == currentAnim;
	}
}