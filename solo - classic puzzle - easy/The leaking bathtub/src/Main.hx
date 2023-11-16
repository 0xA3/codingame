import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

typedef Leak = {
	final height:Int;
	final flow:Int;
}

function main() {
	final s = parseInt( readline() );
	final h = parseInt( readline() );
	final flow = parseInt( readline() ) * 1000; // cm³
	final n = parseInt( readline() );
	final leaks = [for( _ in 0...n ) {
		final inputs = readline().split(" ");
		{ height: parseInt( inputs[0] ), flow: parseInt( inputs[1] ) * 1000 } // cm³
	}];

	final result = process( s, h, flow, leaks );
	print( result );
}

function process( surface:Int, height:Int, flow:Int, leaks:Array<Leak> ) {
	leaks.sort(( a, b ) -> {
		if( a.height < b.height ) return -1;
		if( a.height > b.height ) return 1;

		if( a.flow < b.flow ) return -1;
		if( a.flow > b.flow ) return 1;
	
		return 0;
	});

	var time = 0.0;
	var filled = 0;
	var remainingFlow = flow;
	for( leak in leaks ) {
		time += 60 * surface * ( leak.height - filled ) / remainingFlow;
		filled = leak.height;
		remainingFlow -= leak.flow;
		if( remainingFlow <= 0 ) return 'Impossible, $filled cm.';
	}

	time += 60 * surface * ( height - filled ) / remainingFlow;
	
	final seconds = int( time % 60 );
	final minutes = int(( time / 60 ) % 60 ) ;
	final hours = int( time / 3600 );

	return '${double( hours )}:${double( minutes )}:${double( seconds )}';
}

function double( v:Int ) {
	return v < 10 ? '0$v' : '$v';
}