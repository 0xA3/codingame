using Lambda;

class Main {
	
	static function main() {

		final inputs = CodinGame.readline().split(' ');

		final nbFloors = Std.parseInt(inputs[0]); // number of floors
		final width = Std.parseInt(inputs[1]); // width of the area
		final nbRounds = Std.parseInt(inputs[2]); // maximum number of rounds
		final exitFloor = Std.parseInt(inputs[3]); // floor on which the exit is found
		final exitPos = Std.parseInt(inputs[4]); // position of the exit on its floor
		final nbTotalClones = Std.parseInt(inputs[5]); // number of generated clones
		final nbAdditionalElevators = Std.parseInt(inputs[6]); // ignore (always zero)
		final nbElevators = Std.parseInt(inputs[7]); // number of elevators
		
		final elevators:Map<Int,Int> = [];
		for( i in 0...nbElevators ) {
			var inputs = CodinGame.readline().split(' ');
			final elevatorFloor = Std.parseInt(inputs[0]); // floor on which this elevator is found
			final elevatorPos = Std.parseInt(inputs[1]); // position of the elevator on its floor
			elevators.set( elevatorFloor, elevatorPos );
		}

		CodinGame.printErr( 'nbFloors $nbFloors' );
		CodinGame.printErr( 'width $width' );
		CodinGame.printErr( 'nbRounds $nbRounds' );
		CodinGame.printErr( 'exitFloor $exitFloor' );
		CodinGame.printErr( 'exitPos $exitPos' );
		CodinGame.printErr( 'nbTotalClones $nbTotalClones' );
		CodinGame.printErr( 'nbAdditionalElevators $nbAdditionalElevators' );
		CodinGame.printErr( 'nbElevators $nbElevators' );

		final drive = new InfiniteImprobabilityDrive( nbFloors, width, exitFloor, exitPos, elevators );
		final clone = new Clone( drive );

		// game loop
		while( true ) {
			clone.update( CodinGame.readline() );
			final action = clone.getAction();
			CodinGame.print( action );     // action: WAIT or BLOCK

		}

}

}

