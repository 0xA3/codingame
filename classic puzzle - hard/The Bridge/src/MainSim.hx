import CodinGame.printErr;
import ai.Ai;
import data.Motorbike;
import data.State;
import data.TestCase;
import haxe.Timer;
import sim.ParseTestCase.parse;
import sim.Simulator;

using xa3.StringUtils;

class MainSim {
	
	static function main() {
		trace( '-- START --' );
		// final testCase = parse( TestCases.straight );
		// final testCase = parse( TestCases.moveDown );
		final testCase = parse( TestCases.oneLonelyHole );
		// final testCase = parse( TestCases.chainedJumpsOfIncreasingLength );
		// final testCase = parse( TestCases.chainedJumpsOfDecreasingLength );
		// final testCase = parse( TestCases.chainedJumpsOfEqualLength );
		// final testCase = parse( TestCases.diagonalColumnsOfHolesPlus3HoleRow );
		// final testCase = parse( TestCases.scatteredPits );
		// final testCase = parse( TestCases.bigJumpChainedWithHoleColumns );
		// final testCase = parse( TestCases.diagonalColumnsOfHolesPlus4HoleRowWithMandatorySacrifice );
		// final testCase = parse( TestCases.obstacleCourseFor1Bike );
		// final testCase = parse( TestCases.obstacleCourseFor2Bikes );
		// final testCase = parse( TestCases.mandatorySacrifices );
		// final testCase = parse( TestCases.wellWornRoad );
		
		printState( testCase, testCase.initialState );
		
		final ai = new Ai( new Simulator( testCase.lanes, testCase.v ));
		
		final simulator = new Simulator( testCase.lanes, testCase.v );

		var state = testCase.initialState;
		final destination = testCase.lanes[0].length;
		
		var x = getBikeX( testCase.initialState.motorbikes );
		var turn = 0;
		while( turn++ < 50 && state.alive > 0 && state.x < destination ) {
			final startTime = Timer.stamp();
			final action = ai.process( state );
			// if( Timer.stamp() - startTime > 0.15 )
			trace( 'turn $turn  $action  ${Timer.stamp() - startTime}ms' );
			
			final actionId = parseAction( action );
			state = simulator.execute( state, actionId );
			// trace( state );
			printState( testCase, state );
		}
	}
	
	static function getBikeX( motorbikes:Array<Motorbike> ) {
		for( m in motorbikes ) if( m.a ) return m.x;
		return 0;
	}

	static function parseAction( action:String ) {
		final actionId = Ai.actions.indexOf( action );
		if( actionId == -1 ) throw 'Error: action "$action" not found in list';
		return actionId;
	}

	static function printState( testCase:TestCase, state:State ) {
		final lanesOutputs = testCase.lanes.map( a -> a.map( v -> v ? "." : "O" ).join( "" ));
		for( motorbike in state.motorbikes ) {
			final icon = motorbike.a ? "🏍" : "☠️";
			lanesOutputs[motorbike.y] = lanesOutputs[motorbike.y].replaceAt( motorbike.x, icon, 1 );
		}
		printErr( lanesOutputs.join( "\n" ));
	}
}