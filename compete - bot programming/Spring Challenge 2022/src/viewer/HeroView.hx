package viewer;

import h2d.Anim;
import h2d.Object;
import h2d.Text;
import viewer.THeroState;

class HeroView extends CharacterView {

	static inline var FPS = 15;
	
	final textField:Text;
	final runAnim:Anim;
	final combatAnim:Anim;
	final idleAnim:Anim;
	final castAnim:Anim;

	public final states:Array<THeroState> = [];
	public final stateDurations:Array<Int> = [];

	var state = Idle;

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
	}

	public function setMessage( message:String ) {
		if( message == "" ) {
			infoContainer.visible = false;
		}
		textField.text = message;
		infoContainer.visible = true;
	}

	override public function update( frame:Float ) {
		super.update( frame );

		if( nextPos.isEqual( currentPos )) changeStateTo( Idle );
		else changeStateTo( Run );
	}

	function changeStateTo( nextState:THeroState ) {
		if( state == nextState ) return;
		switch nextState {
			case Run:
				runAnim.visible = true;
				combatAnim.visible = false;
				idleAnim.visible = false;
				castAnim.visible = false;
			case Combat:
				runAnim.visible = false;
				combatAnim.visible = true;
				idleAnim.visible = false;
				castAnim.visible = false;
			case Idle:
				runAnim.visible = false;
				combatAnim.visible = false;
				idleAnim.visible = true;
				castAnim.visible = false;
			case Cast:
				runAnim.visible = false;
				combatAnim.visible = false;
				idleAnim.visible = false;
				castAnim.visible = true;
		}
		state = nextState;
	}
}