import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.floor;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {
	
	while( true ) {
		final inputs = readline().split(' ');
	
		final x = parseInt( inputs[0] );
		final y = parseInt( inputs[1] );
		final player:Player = { x: x, y: y };
		final humanCount = parseInt( readline() );
		final humans = [for( i in 0...humanCount ) {
			final inputs = readline().split(' ');
			final humanId = parseInt(inputs[0]);
			final humanX = parseInt(inputs[1]);
			final humanY = parseInt(inputs[2]);
			final human = { id: humanId, x: humanX, y: humanY };
			human;
		}];
		
		final zombieCount = parseInt(readline());
		final zombies = [for ( i in 0...zombieCount ) {
			final inputs = readline().split(' ');
			final zombieId = parseInt(inputs[0]);
			final zombieX = parseInt(inputs[1]);
			final zombieY = parseInt(inputs[2]);
			final zombieXNext = parseInt(inputs[3]);
			final zombieYNext = parseInt(inputs[4]);
			final zombie:Zombie = { id: zombieId, x: zombieX, y: zombieY, xNext: zombieXNext, yNext: zombieYNext };
			zombie;
		}];
		final result = process( player, humans, zombies );
		print( result );
	}
}	

function process( player:Player, humans:Array<Human>, zombies:Array<Zombie> ) {
	if( zombies.length == 0 ) return "0 0";

	final target = zombies[0];
	return '${target.xNext} ${target.yNext}';
}

function getDistance2( player:Player, zombie:Zombie ) {
	
}

typedef Player = {
	final x:Int;
	final y:Int;
}

typedef Human = {
	final id:Int;
	final x:Int;
	final y:Int;
}

typedef Zombie = {
	final id:Int;
	final x:Int;
	final y:Int;
	final xNext:Int;
	final yNext:Int;
}

