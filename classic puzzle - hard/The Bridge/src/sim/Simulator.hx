package sim;

import data.Motorbike;
import data.State;

class Simulator {
	
	public final bikes:Int;
	public final minSurvivingBikes:Int;
	public final xFinish:Int;
	
	final lanes:Array<Array<Bool>>;
	
	public function new( inputLanes:Array<Array<Bool>>, bikes:Int, minSurvivingBikes:Int ) {
		final addon = [for( _ in 0...30 ) true];
		lanes = inputLanes.map( a -> a.concat( addon.copy() ));
		
		this.bikes = bikes;
		this.minSurvivingBikes = minSurvivingBikes;
		this.xFinish = inputLanes[0].length;
		// trace( 'xFinish $xFinish' );
	}

	public function finished( x:Int ) return x >= xFinish;

	public function execute( state:State, actionId:Int ) {
		switch actionId {
			case 0: return move( state, state.speed ); // WAIT
			case 1: return move( state, state.speed + 1 ); // SPEED
			case 2: return move( state, state.speed - 1 ); // SLOW
			case 3: return jump( state ); // JUMP
			case 4: return moveUp( state ); // UP
			case 5: return moveDown( state ); // DOWN
			default: throw 'Error: action $actionId is not defined';
		}
	}

	function move( inputState:State, inputSpeed:Int, dy = 0 ):State {
		final speed = inputSpeed < 0 ? 0 : inputSpeed;
		if( speed == 0 ) return State.NO_STATE;
		
		var x = inputState.x;
		var alive = inputState.alive;
		final motorbikes = inputState.motorbikes;
		
		final movedMotorbikes = [];
		for( i in 0...motorbikes.length ) {
			final motorbike = motorbikes[i];
			if( motorbike.a == false ) movedMotorbikes.push( motorbike );
			else {
				final movedMotorbike = moveMotorbike( motorbike.x, motorbike.y, speed, dy );
				movedMotorbikes.push( movedMotorbike );
				if( !movedMotorbike.a ) alive--;
				if( x < movedMotorbike.x ) x = movedMotorbike.x;
			}
		}
		if( alive == 0 ) return State.NO_STATE;
		
		return { speed: speed, x: x, alive: alive, motorbikes: movedMotorbikes }
	}

	function jump( inputState:State ):State {
		if( inputState.speed == 0 ) return State.NO_STATE;
		
		var x = inputState.x;
		var alive = inputState.alive;
		final motorbikes = inputState.motorbikes;
		
		final movedMotorbikes = [];
		for( i in 0...motorbikes.length ) {
			final motorbike = motorbikes[i];
			if( motorbike.a == false ) movedMotorbikes.push( motorbike );
			else {
				final movedMotorbike = jumpMotorbike( motorbike.x, motorbike.y, inputState.speed );
				movedMotorbikes.push( movedMotorbike );
				if( !movedMotorbike.a ) alive--;
				if( x < movedMotorbike.x ) x = movedMotorbike.x;
			}
		}
		if( alive == 0 ) return State.NO_STATE;
		
		return { speed: inputState.speed, x: x, alive: alive, motorbikes: movedMotorbikes }
	}

	function moveUp( state:State ):State {
		var minY = state.motorbikes.length;
		for( motorbike in state.motorbikes ) {
			if( motorbike.a && motorbike.y < minY ) minY = motorbike.y;
		}

		final dy = minY >= 1 ? -1 : 0;
		if( dy == 0 ) return State.NO_STATE;

		return move( state, state.speed, dy );
	}

	function moveDown( state:State ):State {
		var maxY = 0;
		for( motorbike in state.motorbikes ) {
			if( motorbike.a && motorbike.y > maxY ) maxY = motorbike.y;
		}

		final dy = maxY < lanes.length - 1 ? 1 : 0;
		if( dy == 0 ) return State.NO_STATE;
		
		return move( state, state.speed, dy );
	}

	function moveMotorbike( x:Int, y:Int, dx:Int, dy:Int ):Motorbike {
		var nextX = 0;
		var nextA = true;
		if( dy != 0 ) {
			for( i in 1...dx ) {
				nextX = x + i;
				if( !lanes[y][nextX] ) {
					nextA = false;
					break;
				}
			}
		}
		if( nextA ) {
			final nextY = y + dy;
			for( i in 1...dx + 1 ) {
				nextX = x + i;
				if( !lanes[nextY][nextX] ) {
					nextA = false;
					break;
				}
			}
		}
	
		return { x: nextX, y: y + dy, a: nextA }
	}

	function jumpMotorbike( x:Int, y:Int, dx:Int ):Motorbike {
		final nextX = x + dx;
		final nextA = lanes[y][nextX];
		return { x: nextX, y: y, a: nextA }
	}
}