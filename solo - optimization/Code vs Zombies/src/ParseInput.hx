import Std.parseInt;
import data.FrameDataset;
import data.HumanDataset;
import data.ZombieDataset;

using StringTools;

function parseInput( testCase:String ) {
	final lines = testCase.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
	final inputs = lines[0].split(' ');

	final x = parseInt( inputs[0] );
	final y = parseInt( inputs[1] );
	final humanCount = parseInt( lines[1] );
	final humans = [for( i in 0...humanCount ) {
		final inputs = lines[2 + i ].split(' ');
		final humanId = parseInt(inputs[0]);
		final humanX = parseInt(inputs[1]);
		final humanY = parseInt(inputs[2]);
		final human:HumanDataset = { id: humanId, isAlive: true, x: humanX, y: humanY };
		human;
	}];
	
	final zombieCount = parseInt(lines[2 + humanCount]);
	final zombies = [for ( i in 0...zombieCount ) {
		final inputs = lines[2 + humanCount + 1 + i].split(' ');
		final zombieId = parseInt(inputs[0]);
		final zombieX = parseInt(inputs[1]);
		final zombieY = parseInt(inputs[2]);
		final zombieXNext = parseInt(inputs[3]);
		final zombieYNext = parseInt(inputs[4]);
		final zombie:ZombieDataset = { id: zombieId, isUndead: true, x: zombieX, y: zombieY, xNext: zombieXNext, yNext: zombieYNext };
		zombie;
	}];

	final frameDataset:FrameDataset = { ashX: x, ashY: y, humans: humans, zombies: zombies };

	return frameDataset;
}
