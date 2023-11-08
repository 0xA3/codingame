import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

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

var screen:Array<Array<String>>;
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

	screen = [[" "]];
	screenLeft = 0;
	screenRight = 1;
	screenTop = 0;
	screenBottom = 1;
	x = 0;
	y = 0;
	
	printScreen();

	final commands = lines.map( line -> line.split( ";" )).flatten();

	for( command in commands ) {
		trace( command );
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
		printScreen();
	}

	final output = screen.map( row -> row.join( "" ).rtrim()).filter( line -> line != "" ).join( "\n" );
	return output;
}

function clearScreen( s:String ) {
	backgroundSymbol = s;
	for( y in 0...screen.length ) for( x in 0...screen[y].length ) screen[y][x] = backgroundSymbol;
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
	if( y < screenTop ) {
		final row = [for( _ in screenLeft...screenRight ) backgroundSymbol];
		screen.unshift( row );
		screenTop--;
		trace( 'extend screen north  screenTop $screenTop' );
	}
}

function goWest() {
	if( isPenDown ) drawAtPosition();
	x -= 1;
	if( x < screenLeft ) {
		for( y in 0...screen.length ) screen[y].unshift( backgroundSymbol );
		screenLeft--;
		trace( 'extend screen west  screenLeft $screenLeft' );
	}
}

function goSouth() {
	if( isPenDown ) drawAtPosition();
	y += 1;
	if( y >= screenBottom ) {
		final row = [for( _ in screenLeft...screenRight) backgroundSymbol];
		screen.push( row );
		screenBottom++;
		trace( 'extend screen south  screenBottom $screenBottom' );
	}
}

function goEast() {
	if( isPenDown ) drawAtPosition();
	x += 1;
	if( x >= screenRight ) {
		for( y in 0...screen.length ) screen[y].push( backgroundSymbol );
		screenRight++;
		trace( 'extend screen east  screenRight $screenRight' );
	}
}

function drawAtPosition() {
	final screenX = x - screenLeft;
	final screenY = y - screenTop;
	trace( 'drawAtPosition $x:$y  coords $screenX:$screenY' );
	screen[screenY][screenX] = symbol;
}

function right( angle:Int ) {
	final steps = -int( angle / 90 );
	direction = ( directions.length + ( direction + steps )) % directions.length;
	trace( 'turn $angle° right. $steps New direction $direction ${directions[direction]}' );
}

function left( angle:Int ) {
	final steps = int( angle / 90 );
	direction = ( direction + steps ) % directions.length;
	trace( 'turn $angle° left. $steps New direction $direction ${directions[direction]}' );
}

function printScreen() {
	final output = screen.map( row -> row.map( s -> s.replace( " ", "·" )).join( "" )).join( "\n" );
	trace( "print screen\n[\n" + output + "\n]" );
}
