import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.PI;
import Math.pow;
import Math.round;
import Std.parseInt;
import Vec2.angle;

function main() {
	
	final n = parseInt(readline());
	
	final triangles:Array<Triangle> = [for( _ in 0...n ) {
		var inputs = readline().split(' ');
		final a = inputs[0];
		final xA = parseInt( inputs[1] );
		final yA = parseInt( inputs[2] );
		final b = inputs[3];
		final xB = parseInt( inputs[4] );
		final yB = parseInt( inputs[5] );
		final c = inputs[6];
		final xC = parseInt( inputs[7] );
		final yC = parseInt( inputs[8] );
		{ a: a, xA: xA, yA: yA, b: b, xB: xB, yB: yB, c: c, xC: xC, yC: yC }
	}];
	
	final result = process( triangles );
	print( result );
}	

function process( triangles:Array<Triangle> ) {

	final results = triangles.map( triangle -> processTriangle( triangle ));
	return results.join( "\n" );
}

function processTriangle( t:Triangle ) {
	final name = t.a + t.b + t.c;
	final sideNature = getSideNature( t );
	final angleNature = getAngleNature( t );

	final natures = [];
	if( sideNature != "" ) natures.push( sideNature );
	if( angleNature != "" ) natures.push( angleNature );
	
	return '$name is ${natures.join(" and ")} triangle.';
}

function getSideNature( t:Triangle ) {
	
	final lenghts = [
		getLength2( t.xA, t.yA, t.xB, t.yB ),
		getLength2( t.xB, t.yB, t.xC, t.yC ),
		getLength2( t.xC, t.yC, t.xA, t.yA ),
	];

	final sameLengths = [];
	if( lenghts[0] == lenghts[1] ) sameLengths.push( 1 );
	if( lenghts[1] == lenghts[2] ) sameLengths.push( 2 );
	if( lenghts[2] == lenghts[0] ) sameLengths.push( 3 );

	if( sameLengths.length == 0 ) return "a scalene";
	
	if( sameLengths.length == 1 ) {
		final vertex = switch sameLengths[0] {
			case 1: t.b;
			case 2: t.c;
			case 3: t.a;
			default: throw 'Error: sameLength can only be 1, 2 or 3, not ${sameLengths[0]}';
		}
		return 'an isosceles in $vertex';
	}
	return "";
}

function getAngleNature( t:Triangle ) {
	
	final ab = new Vec2( t.xB - t.xA, t.yB - t.yA );
	final ac = new Vec2( t.xC - t.xA, t.yC - t.yA );
	final alpha = deg( angle( ab, ac ));

	final ba = new Vec2( t.xA - t.xB, t.yA - t.yB );
	final bc = new Vec2( t.xC - t.xB, t.yC - t.yB );
	final beta = deg( angle( ba, bc ));

	final ca = new Vec2( t.xA - t.xC, t.yA - t.yC );
	final cb = new Vec2( t.xB - t.xC, t.yB - t.yC );
	final gamma = deg( angle( ca, cb ));

	final angles = [alpha, beta, gamma];
	
	final acuteAngles = angles.filter( angle -> angle < 90 );
	if( acuteAngles.length == 3 ) return "an acute";
	
	final rightIndex = angles.indexOf( 90 );
	if( rightIndex != -1 ) {
		return 'a right in ${[t.a, t.b, t.c][rightIndex]}';
	}

	final obtuseAngles = angles.filter( angle -> angle > 90 );
	if( obtuseAngles.length > 0 ) {
		return 'an obtuse in ${[t.a, t.b, t.c][angles.indexOf( obtuseAngles[0])]} (${round( obtuseAngles[0] )}°)';
	}

	return "";
}

function getLength2( x1:Int, y1:Int, x2:Int, y2:Int ) return pow( x2 - x1, 2 ) + pow( y2 - y1, 2 );
function deg( rad:Float ) return rad / PI * 180;

typedef Triangle = {
	final a:String;
	final xA:Int;
	final yA:Int;
	final b:String;
	final xB:Int;
	final yB:Int;
	final c:String;
	final xC:Int;
	final yC:Int;
}