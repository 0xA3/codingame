import Std.int;
import haxe.ds.GenericStack;

function dec2bin( dec:Int ) {
	if( dec == 0 ) return [0];
	final stack = new GenericStack();

	var num = dec;
	while( num > 0 ) {
		stack.add( num % 2 );
		num = int( num / 2 );
	}

	var result = [];
	while( !stack.isEmpty()) {
		result.push( stack.pop());
	}
	
	return result;
}