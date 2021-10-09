import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Math.PI;
import MathTools.cbrt;
import Std.parseFloat;
import Std.parseInt;

using Lambda;
using StringTools;

inline var ALICE = "Alice";

function main() {

	final n = parseInt( readline() );
	final planets:Array<Planet> = [for( i in 0...n ) createPlanet( readline() )];

	final result = process( planets );
	print( result );
}

function createPlanet( s:String ) {
	final inputs = s.split(' ');
	final name = inputs[0];
	final r = parseFloat( inputs[1] );
	final m = parseFloat( inputs[2] );
	final c = parseFloat( inputs[3] );
	
	final planet:Planet = {
		name: name,
		radius: r,
		mass: m,
		distance: c
	}
	
	return planet;
}

function process( planets:Array<Planet> ) {
	
	planets.sort(( a, b ) -> {
		if( a.distance < b.distance ) return -1;
		if( a.distance > b.distance ) return 1;
		return 0;
	});
	
	final alice = planets.shift();
	final densityAlice = getDensity( alice );
	
	for( planet in planets ) {
		final limit = alice.radius * cbrt( 2 * densityAlice / getDensity( planet ));
		if( planet.distance > limit ) return planet.name;
	}

	return "";
}

function getDensity( p:Planet ) return p.mass / getVolume( p.radius );
function getVolume( radius:Float ) return 4/3 * PI * Math.pow( radius, 3 );

typedef Planet = {
	final name:String;
	final radius:Float;
	final mass:Float;
	final distance:Float;
}
