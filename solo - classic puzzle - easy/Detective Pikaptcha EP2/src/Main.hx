
import Pikapcha;

class Main {
	
	static function main() {
		
		final inputs = CodinGame.readline().split(' ');
		final width = Std.parseInt( inputs[0] );
		final height = Std.parseInt( inputs[1] );
		final lines = [for( i in 0...height) CodinGame.readline()];
		final followDirection = CodinGame.readline() == "L" ? -1 : 1;

		CodinGame.printErr( 'width $width  height $height' );
		for( line in lines ) CodinGame.printErr( line );
		CodinGame.printErr( 'follow $followDirection' );

		final maze = new Maze( width, height, lines );
		final initialPosition = maze.getInitialPosition();
		final pikapcha = new Pikapcha( maze, followDirection, initialPosition );

		final result = play( pikapcha, maze, initialPosition );
		for( line in result )	CodinGame.print( line );

	}

	static function play( pikapcha:Pikapcha, maze:Maze, initialPosition:Position ) {
		
		while( true ) {
			final position = pikapcha.getNextPosition();
			pikapcha.move( position );
			if( position != Pikapcha.invalidPosition ) maze.increment( position );
			if( position == Pikapcha.invalidPosition || ( position.x == initialPosition.x && position.y == initialPosition.y )) break;
		}
		
		return maze.plot();
	}

}
