import js.Syntax;

using Lambda;

final wait = 'WAIT';
final block = 'BLOCK';

var parseInt = ( v:String ) -> Syntax.code("parseInt({0})", v);
var readlineSplit = () -> CodinGame.readline().split(" ");

function main() {

	final inputs = readlineSplit();

	// final nbFloors = parseInt(inputs[0]); // number of floors
	// final width = parseInt(inputs[1]); // width of the area
	// final nbRounds = parseInt(inputs[2]); // maximum number of rounds
	// final exitFloor = parseInt(inputs[3]); // floor on which the exit is found
	final exitPos = parseInt(inputs[4]); // position of the exit on its floor
	// final nbTotalClones = parseInt(inputs[5]); // number of generated clones
	// final nbAdditionalElevators = parseInt(inputs[6]); // ignore (always zero)
	final nbElevators = parseInt(inputs[7]); // number of elevators
	
	final elevators = [];
	for( _ in 0...nbElevators ) {
		var inputs = readlineSplit();
		elevators[parseInt( inputs[0] )] = parseInt( inputs[1] );
	};
	elevators[nbElevators] = exitPos;

	// game loop
	while( true ) {

		final inputs = readlineSplit();
		final floor = parseInt( inputs[0] ); // floor of the leading clone
		final pos = parseInt( inputs[1] ); // position of the leading clone on its floor
		final direction = inputs[2].charAt( 0 ); // direction of the leading clone: NONE, LEFT or RIGHT
		
		// final targetPosition = elevators[floor] == null ? exitPos : elevators[floor];
		final action = { if( direction == 'L' ) elevators[floor] > pos ? block : wait;
		else if( direction == 'R' ) elevators[floor] < pos ? block : wait;
		else wait; }// action: WAIT or BLOCK
		
		js.Syntax.code('print({0})', action);
	}
}
