import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import MathUtils.dist;
import Math.min;
import Math.max;
import Math.round;

using Lambda;
using StringUtils;

inline var WIDTH = 19;
inline var HEIGHT = 25;

function main() {
		
	final instructions = readline();
	
	final result = process( instructions );
	print( result );
}

function process( instructions:String ) {
	final field = [for( _ in 0...HEIGHT ) [for( _ in 0...WIDTH ) 1]];
	
	for( iString in instructions.split(" ")) {
		final instruction = parseInstruction( iString );

		final left = round( max( instruction.x - instruction.r, 0 ));
		final right = round( min( instruction.x + instruction.r, WIDTH ));
		final top = round( max( instruction.y - instruction.r, 0 ));
		final bottom = round( min( instruction.y + instruction.r, HEIGHT ));

		for( y in top...bottom ) {
			for( x in left...right ) {
				if( dist( x, y, instruction.x, instruction.y ) <= instruction.r ) {
					switch instruction.action {
						case Mow:		field[y][x] = 0;
						case Plant:		field[y][x] = 1;
						case PlantMow:	field[y][x] = 1 - field[y][x];
					}
				}
			}
		}
	}

	final output = field.map( row -> row.map( cell -> cell == 1 ? "{}" : "  " ).join( "" )).join( "\n" );
	printErr( output );
	return output;
}

function parseInstruction( iString:String ) {
	var action:Action;
	var i2:String;
	if( iString.contains( "PLANTMOW" )) {
		action = PlantMow;
		i2 = iString.substr( 8 );
	} else if( iString.contains( "PLANT" )) {
		action = Plant;
		i2 = iString.substr( 5 );
	} else {
		action = Mow;
		i2 = iString;
	}

	final x = i2.charCodeAt( 0 ) - 97;
	final y = i2.charCodeAt( 1 ) - 97;
	final r = parseInt( i2.substr( 2 )) / 2;

	final instruction:Instruction = { action: action, x: x, y: y, r: r }
	return instruction;
}

typedef Instruction = {
	final action:Action;
	final x:Int;
	final y:Int;
	final r:Float;
}

enum Action {
	Mow;
	Plant;
	PlantMow;
}