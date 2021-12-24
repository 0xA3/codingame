import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.floor;
import Std.int;
import Std.parseInt;
import ai.Simple;
import data.FrameDataset;
import data.Vec2;

using Lambda;

function main() {
	
	final ai = new Simple();

	while( true ) {
		final inputs = readline().split(' ');
	
		final x = parseInt( inputs[0] );
		final y = parseInt( inputs[1] );
		final ash:Vec2 = { x: x, y: y };
		final humanCount = parseInt( readline() );
		final humans = [for( i in 0...humanCount ) {
			final inputs = readline().split(' ');
			final id = parseInt( inputs[0] );
			final x = parseInt( inputs[1] );
			final y = parseInt( inputs[2] );
			final position:Vec2 = { x: x, y: y };
			{ id: id, isAlive: true, position: position };
		}];
		
		final zombieCount = parseInt(readline());
		final zombies = [for ( i in 0...zombieCount ) {
			final inputs = readline().split(' ');
			final id = parseInt( inputs[0] );
			final x = parseInt( inputs[1] );
			final y = parseInt( inputs[2] );
			final position:Vec2 = { x: x, y: y };
			final xNext = parseInt( inputs[3] );
			final yNext = parseInt( inputs[4] );
			final positionNext:Vec2 = { x: xNext, y: yNext };
			{ id: id, isExisting: true, position: position, positionNext: positionNext };
		}];

		final frameDataset:FrameDataset = { ash: ash, humans: humans, zombies: zombies };
		
		// final ip = '$x $y\n$humanCount\n'
		// + [for( human in humans ) '${human.id} ${human.position.x} ${human.position.y}'].join( "\n" )
		// + '\n$zombieCount\n'
		// + [for( zombie in zombies ) '${zombie.id} ${zombie.position.x} ${zombie.position.y} ${zombie.positionNext.x} ${zombie.positionNext.y}'].join( "\n" );
		// printErr( ip );

		final result = ai.process( frameDataset );
		print( result );
	}
}
