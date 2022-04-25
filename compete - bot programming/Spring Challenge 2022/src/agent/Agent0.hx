package agent;

import CodinGame.print;
import CodinGame.printErr;

class Agent0 extends Agent {
	
	public function new() {
		super();
		agentId = "Agent0";
	}
	
	override function process():String {
		turn++;
		final dangerousMobs = [];
		for( mob in mobs ) {
			if( mob.threatFor == 1 ) dangerousMobs.push( mob );
		}
		if( dangerousMobs.length > 0 ) {
			dangerousMobs.sort(( a, b ) -> {
				final da = a.position.distance( me.basePosition );
				final db = b.position.distance( me.basePosition );
				if( da < db ) return -1;
				if( da > db ) return 1;
				return 0;
			});
			// for( mob in dangerousMobs ) printErr( 'dangerous mob ${mob.id} distance ${mob.position.distance( me.basePosition )}' );
			for( i in 0...me.heros.length ) actions[i] = 'MOVE ${dangerousMobs[0].position.toIntString()}';	
		} else {
			for( i in 0...me.heros.length ) actions[i] = 'WAIT';
		}
		return actions.join( "\n" );
	}
}