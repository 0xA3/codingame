import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

using Main;
/**
Args:
	- n (Int): The size of the image
	- target_image (Array<String>): The rows of the desired image, from top to bottom
*/
@:native("solve")
@:keep function solve( n:Int, targetImage:Array<String> ) {
    final pairs:Array<Pair> = [for (i in 0...n) { i:i, line: targetImage[i]}];
    pairs.sort(( a, b ) -> b.line.count("#") - a.line.count("#"));
    
	var notDone = [for (i in 0...n) i => true];
    var order = [];
	for( pair in pairs ) {
		notDone.remove( pair.i );
        order.push( 'R ${pair.i}' );
        for( i in 0...pair.line.length ) {
            if( pair.line.charAt( i ) == '#' ) order.push('C $i');
        }
        for( x in notDone.keys() ) order.push( 'R $x' );
    }

    return order;
}

function count( s:String, char:String ) {
	return s.split( "" ).filter( x -> x == char ).length;
}

typedef Pair = {
	final i:Int;
	final line:String;
}