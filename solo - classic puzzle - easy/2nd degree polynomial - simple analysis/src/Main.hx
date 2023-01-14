import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseFloat;
import Math.sqrt;

using Lambda;
using StringTools;
using xa3.format.NumberFormat;

function main() {

	final inputs = readline().split(' ');
	final a = parseFloat( inputs[0] );
	final b = parseFloat( inputs[1] );
	final c = parseFloat( inputs[2] );

	final result = process( a, b, c );
	print( result );
}

function process( a:Float, b:Float, c:Float ) {
	
	if( a == 0 && b == 0 && c == 0 ) return "(0,0)";
	if( a == 0 && b == 0 ) return '(0,${c.round( 2 )})';

	final points:Array<Point> = [{ x: 0, y: c }];

	if( a == 0 ) points.push({ x: -c / b, y: 0 });
	else {
		final delta = ( b * b ) - 4 * a * c;

		if( delta == 0 ) points.push({ x: -b / ( 2 * a ), y: 0 });
		else if( delta > 0 ) {
			points.push({ x: ( -b + sqrt( delta )) / ( 2 * a ), y: 0 });
			points.push({ x: ( -b - sqrt( delta )) / ( 2 * a ), y: 0 });
		}
	}

	points.sort(( a, b ) -> a.x < b.x ? -1 : 1 );
	#if lua
	return points.map( point -> '$point'.replace( ".0", "" ) ).join( "," );
	#else
	return points.map( point -> '$point' ).join( "," );
	#end
}

@:structInit class Point {
	public final x:Float;
	public final y:Float;

	public function toString() {
		return '(${x.round( 2 )},${y.round( 2 )})';
	}
}