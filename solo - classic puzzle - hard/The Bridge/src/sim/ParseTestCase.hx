package sim;

import Std.parseInt;
import data.Motorbike;
import data.State;
import data.TestCase;

using StringTools;
using xa3.StringUtils;

function parse( input:String ) {
	final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
	
	final m = parseInt( lines[0] ); // the amount of motorbikes to control
	final v = parseInt( lines[1] ); // the minimum amount of motorbikes that must survive
	// final lanes = [for( i in 0...4 ) '${lines[i + 2]}${".".repeat( 20 )}'.split( "" ).map( s -> s == ".")]; //lanes of the road. A dot character . represents a safe space, a zero 0 represents a hole in the road.
	final lanes = [for( i in 0...4 ) '${lines[i + 2]}'.split( "" ).map( s -> s == ".")]; //lanes of the road. A dot character . represents a safe space, a zero 0 represents a hole in the road.
	
	final s = parseInt( lines[6] );

	var motorbikes:Array<Motorbike> = [];
	for( i in 0...m ) {
		final inputs = lines[i + 7].split(" ");
		final x = parseInt( inputs[0] ); // x coordinate of the motorbike
		final y = parseInt( inputs[1] ); // y coordinate of the motorbike
		final a = inputs[2] == "1"; // indicates whether the motorbike is activated "1" or destroyed "0"
		// if( a == 1 ) printErr( 'pos $x:$y' );
		motorbikes.push({ x: x, y: y, a: a });
	}
	
	final initialState:State = {
		speed: s,
		x: motorbikes[0].x,
		alive: motorbikes.length,
		motorbikes: motorbikes
	}

	final testCase:TestCase = { m: m, v: v, lanes:lanes, initialState: initialState }

	return testCase;
}
