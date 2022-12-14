package viewer;

import Math.ceil;
import Std.int;
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

	public final states:Array<THeroState> = [Idle];
	public final stateDurations:Array<Int> = [0];

	var state:THeroState;

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

		changeStateTo( Idle );
	}

	public function setFrameState( frame:Int, state:THeroState ) {
		states[frame] = state;
		if( frame > 0 ) {
			final prevState = states[frame - 1];
			stateDurations[frame] = prevState == state ? stateDurations[frame - 1] + 1 : 1;
		}
	}

	public function setMessage( message:String ) {
		if( message == "" ) {
			infoContainer.visible = false;
		}
		textField.text = message;
		infoContainer.visible = true;
	}

	override public function update( frame:Float, intFrame:Int, subFrame:Float ) {
		super.update( frame, intFrame, subFrame );
		changeStateTo( states[ceil( frame )] );
		
		final deltaAniTime = stateDurations[intFrame] + subFrame;
		switch state {
			case Run: runAnim.currentFrame = int( deltaAniTime * FPS ) % runAnim.frames.length;
			case Combat: combatAnim.currentFrame = int( deltaAniTime * FPS ) % combatAnim.frames.length;
			default: // no-op
		}
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