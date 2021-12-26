import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.floor;
import Std.int;
import Std.parseInt;
import ai.Simple;
import data.FrameDataset;

using Lambda;

function main() {
	
	final ai = new Simple();
	
	var currentFrame = 0;
	while( true ) {
		final inputs = readline().split(' ');
	
		final x = parseInt( inputs[0] );
		final y = parseInt( inputs[1] );
		final humanCount = parseInt( readline() );
		final humans = [for( i in 0...humanCount ) {
			final inputs = readline().split(' ');
			final id = parseInt( inputs[0] );
			final x = parseInt( inputs[1] );
			final y = parseInt( inputs[2] );
			{ id: id, isAlive: true, x: x, y: y };
		}];
		
		final zombieCount = parseInt(readline());
		final zombies = [for ( i in 0...zombieCount ) {
			final inputs = readline().split(' ');
			final id = parseInt( inputs[0] );
			final x = parseInt( inputs[1] );
			final y = parseInt( inputs[2] );
			final xNext = parseInt( inputs[3] );
			final yNext = parseInt( inputs[4] );
			{ id: id, isUndead: true, x: x, y: y, xNext: xNext, yNext: yNext };
		}];

		final frameDataset:FrameDataset = { ashX: x, ashY: y, humans: humans, zombies: zombies };
		
		final zombiePositions = [for( z in zombies ) 'id: ${z.id} pos ${z.x}:${z.y} next ${z.xNext}:${z.yNext}' ].join( "\n" );
		printErr( 'frame $currentFrame ash $x:$y zombies\n$zombiePositions' );
		// final ip = '$x $y\n$humanCount\n'
		// + [for( human in humans ) '${human.id} ${human.x} ${human.y}'].join( "\n" )
		// + '\n$zombieCount\n'
		// + [for( zombie in zombies ) '${zombie.id} ${zombie.x} ${zombie.y} ${zombie.xNext} ${zombie.yNext}'].join( "\n" );
		// printErr( ip );

		final result = ai.process( frameDataset );
		print( result );
		
		currentFrame++;
	}
}
