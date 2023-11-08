import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

typedef Char = {
	final x:Int;
	final y:Int;
	final symbol:String;
}

enum Direction {
	North;
	West;
	South;
	East;
}

final directions = [North, West, South, East];
var direction:Int;
var symbol:String;
var backgroundSymbol:String;
var isPenDown:Bool;

var screen:Array<Char>;
var screenLeft:Int;
var screenRight:Int;
var screenTop:Int;
var screenBottom:Int;
var x:Int;
var y:Int;

function main() {
	final n = parseInt( readline());
	final lines = [for( _ in 0...n ) readline()];
	
	final result = process( lines );
	print( result );
}

function process( lines:Array<String> ) {
	direction = 0;
	symbol = "#";
	backgroundSymbol = " ";
	isPenDown = true;

	screen = [];
	screenLeft = 0;
	screenRight = 1;
	screenTop = 0;
	screenBottom = 1;
	x = 0;
	y = 0;
	
	// trace( "[\n" + getOutput().replace( " ", "·" ) + "\n]" );

	final commands = lines.map( line -> line.split( ";" )).flatten();

	for( command in commands ) {
		// trace( command );
		final parts = command.split(" ");
		final method = parts[0].toUpperCase();

		switch method {
			case "CS": clearScreen( parts[1] );
			case "FD": forward( parseInt( parts[1] ));
			case "RT": right( parseInt( parts[1] ));
			case "LT": left( parseInt( parts[1] ));
			case "PU": isPenDown = false;
			case "PD": isPenDown = true;
			case "SETPC": symbol = parts[1];
		}
		// trace( "[\n" + getOutput().replace( " ", "·" ) + "\n]" );
	}

	return getOutput();
}

function clearScreen( s:String ) {
	backgroundSymbol = s;
}

function forward( times:Int ) {
	final func = switch directions[direction] {
		case North: goNorth;
		case West: goWest;
		case South: goSouth;
		case East: goEast;
	}
	for( _ in 0...times ) func();
}

function goNorth() {
	if( isPenDown ) drawAtPosition();
	y -= 1;
}

function goWest() {
	if( isPenDown ) drawAtPosition();
	x -= 1;
}

function goSouth() {
	if( isPenDown ) drawAtPosition();
	y += 1;
}

function goEast() {
	if( isPenDown ) drawAtPosition();
	x += 1;
}

function drawAtPosition() {
	screenTop = min( screenTop, y );
	screenLeft = min( screenLeft, x );
	screenBottom = max( screenBottom, y + 1 );
	screenRight = max( screenRight, x + 1 );
	screen.push({ x: x, y: y, symbol: symbol });
}

function right( angle:Int ) {
	final steps = -int( angle / 90 );
	direction = ( directions.length + ( direction + steps )) % directions.length;
	// trace( 'turn $angle° right. $steps New direction ${directions[direction]}' );
}

function left( angle:Int ) {
	final steps = int( angle / 90 );
	direction = ( direction + steps ) % directions.length;
	// trace( 'turn $angle° left. $steps New direction ${directions[direction]}' );
}

function getOutput() {
	final screen2d = [for( y in screenTop...screenBottom ) [for( x in screenLeft...screenRight ) backgroundSymbol]];
	for( char in screen ) {
		final indexX = char.x - screenLeft;
		final indexY = char.y - screenTop;
		// trace( 'width ${screen2d[0].length}  height ${screen2d.length} indexX $indexX  indexY $indexY' );
		screen2d[indexY][indexX] = char.symbol;
	}
	
	return screen2d.map( row -> row.join( "" ).rtrim()).join( "\n" );
}

function max( v1:Int, v2:Int ) return v1 > v2 ? v1 : v2;
function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;