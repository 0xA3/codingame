import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;
import shape.Circle;
import shape.Shape;
import shape.Square;

using Lambda;

function main() {

	var inputs = readline().split(' ');
	final s = parseInt( inputs[0] );
	final p = parseInt( inputs[1] );
	final shapes = [for( _ in 0...s ) readline()];

	final points = [for( _ in 0...p ) {
		var inputs = readline().split(' ');
		final point:Point = { x: parseInt( inputs[0] ), y: parseInt( inputs[1] ) }
		point;
	}];
		
	final result = process( shapes, points );
	print( result );
}

function process( shapeLines:Array<String>, points:Array<Point> ) {

	final shapes:Array<Shape> = [];
	for( s in shapeLines ) {
		final parts = s.split(" ");
		final color:Color = {
			r: parseInt( parts[4] ),
			g: parseInt( parts[5] ),
			b: parseInt( parts[6] )
		}
		final x = parseInt( parts[1] );
		final y = parseInt( parts[2] );
		final s = parseInt( parts[3] );
		
		if( parts[0] == "SQUARE" ) {
			shapes.push( new Square( x, y, s, color ));
		} else {
			shapes.push( new Circle( x, y, s, color ));
		}
	}
	
	final colors:Array<Color> = [];
	for( point in points ) {
		// trace( point );
		final shapesOnBorder = shapes.filter( shape -> shape.pointIsOnBorder( point ));
		// trace( 'shapesOnBorder ${shapesOnBorder.length}' );
		if( shapesOnBorder.length > 0 ) colors.push({ r: 0, g: 0, b: 0 });
		else {
			final shapesInside = shapes.filter( shape -> shape.pointIsInside( point ));

			// for( shape in shapesInside ) trace( shape );
			final shapeColors = shapesInside.map( shape -> shape.color );
			colors.push( mixColors( shapeColors ));
		}
	}

	final outputs = colors.map( color -> '(${color.r}, ${color.g}, ${color.b})' );
	return outputs.join( "\n" );
}

function mixColors( colors:Array<Color> ):Color {
	if( colors.length == 0 ) return { r: 255, g: 255, b: 255 }
	
	var r = 0;
	var g = 0;
	var b = 0;
	for( color in colors ) {
		r += color.r;
		g += color.g;
		b += color.b;
	}
	// trace( r, g, b );

	return {
		r: int( r / colors.length + 0.5 ),
		g: int( g / colors.length + 0.5 ),
		b: int( b / colors.length + 0.5 )
	}
}
