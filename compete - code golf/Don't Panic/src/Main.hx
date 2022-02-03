import js.Syntax;
import CodinGame.printErr;

using Lambda;

var parseInt = ( v:String ) -> Syntax.code("parseInt({0})", v);
var readlineSplit = () -> CodinGame.readline().split(" ");

function main() {

	final inputs = readlineSplit();

	// final nbFloors = parseInt(inputs[0]); // number of floors
	// final width = parseInt(inputs[1]); // width of the area
	// final nbRounds = parseInt(inputs[2]); // maximum number of rounds
	// final exitFloor = parseInt(inputs[3]); // floor on which the exit is found
	// final exitPos = parseInt(inputs[4]); // position of the exit on its floor
	// final nbTotalClones = parseInt(inputs[5]); // number of generated clones
	// final nbAdditionalElevators = parseInt(inputs[6]); // ignore (always zero)
	final nbElevators = parseInt(inputs[7]); // number of elevators
	
	final elevators = [];
	for( i in 0...nbElevators ) {
		var inputs = readlineSplit();
		// printErr( inputs.join(" ") );
		elevators[parseInt( inputs[0] )] = parseInt( inputs[1] );
		// printErr( 'elevators[${inputs[0]}] = ${inputs[1]}' );
	};
	elevators[nbElevators] = parseInt(inputs[4]);

	// game loop
	while( true ) {

		final inputs = readlineSplit();
		final floor = parseInt( inputs[0] ); // floor of the leading clone
		final pos = parseInt( inputs[1] ); // position of the leading clone on its floor
		final direction = inputs[2].charAt( 0 ); // direction of the leading clone: NONE, LEFT or RIGHT
		// printErr( inputs.join(" "));

		final elevatorOfFloor = elevators[parseInt( floor )];
		js.Syntax.code('print{0}', direction == 'L' && elevatorOfFloor > pos || direction == 'R' && elevatorOfFloor < pos ? 'BLOCK' : 'WAIT');
	}
}
