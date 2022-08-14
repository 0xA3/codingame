import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.PI;
import Math.atan2;
import Math.round;
import Std.parseInt;

using Lambda;

inline var MAX_TURNS = 350;
inline var POOL_RADIUS = 500;
inline var WIN_DISTANCE = 80;
inline var MOUSE_SPEED = 10;

var catSpeed:Int;
var innerRadius:Float;

var state = Navigate;
var escapePosition:Vec2 = { x: 0, y: 0 }

function main() {

	catSpeed = parseInt( readline() );

	innerRadius = MOUSE_SPEED / catSpeed * POOL_RADIUS;
	// printErr( 'catSpeed $catSpeed  innerRadius $innerRadius' );

	var turn = 0;
	while( turn++ <= MAX_TURNS ) {
		final inputs = readline().split(' ');
		final mouseX = parseInt( inputs[0] );
		final mouseY = parseInt( inputs[1] );
		final catX = parseInt( inputs[2] );
		final catY = parseInt( inputs[3] );
	
		final result = process({ x: mouseX, y: mouseY }, {x: catX, y: catY });
		print( '$result $state' );
	}
}

function process( mousePos:Vec2, catPos:Vec2 ) {
	return switch state {
		case Navigate: navigate( mousePos, catPos );
		case HaulAss: escapePosition.toIntString();
	}
}

function navigate( mousePos:Vec2, catPos:Vec2 ) {
	
	final nCat = catPos.normalize();
	final nMouse = nCat.multiply( -1 );
	escapePosition = nMouse.multiply( innerRadius );
	
	final angleRad = mousePos.angleTo( catPos );
	final angleDeg = angleRad * 180 / PI;
	// printErr( 'angle $angleDeg  mouse ${mousePos.length()}  innerRadius $innerRadius' );
	if( angleDeg > 170 && mousePos.length() > innerRadius * 0.95 ){
		escapePosition = catPos.multiply( - 1.1 );
		state = HaulAss;
	}
	
	return escapePosition.toIntString();
}


enum TState {
	Navigate;
	HaulAss;
}