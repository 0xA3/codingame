package test;

import haxe.Int64;
import Main;
import Std.parseInt;
import Std.parseFloat;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
			describe( "Test process", {
			
			it( "Rectangle", { Main.process( rectangle ).should.be( "Rectangle" ); });
			it( "Square", { Main.process( square ).should.be( "Rectangle" ); });
			it( "Touching Top Isosceles", { Main.process( touchingTopIsosceles ).should.be( "Triangle" ); });
			it( "Touching Bottom Non-Isosceles", { Main.process( touchingBottomNonIsosceles ).should.be( "Triangle" ); });
			it( "Touching Left Only 'X' and '.'", { Main.process( touchingLeftOnlyXAndPoint ).should.be( "Triangle" ); });
			it( "Touching Right Top - Right Angle", { Main.process( touchingRightTopRightAngle ).should.be( "Triangle" ); });
			it( "Circle Small", { Main.process( circleSmall ).should.be( "Ellipse" ); });
			it( "Circle Big", { Main.process( circleSmall ).should.be( "Ellipse" ); });
			it( "Ellipse 1", { Main.process( ellipse1 ).should.be( "Ellipse" ); });
			it( "Ellipse 2", { Main.process( ellipse2 ).should.be( "Ellipse" ); });
			it( "Ellipse 3", { Main.process( ellipse3 ).should.be( "Ellipse" ); });
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final inputs = lines[0].split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		final rows = [for( i in 0...h ) lines[i + 1]];
		return rows;
	}

	final rectangle = parseInput(
		"4 3
		XXXX
		XXXX
		XXXX" );
	
	final square = parseInput(
		"3 3
		XXX
		XXX
		XXX" );
	
	final touchingTopIsosceles = parseInput(
		"6 3
		\\XXXX/
		.\\XX/.
		..\\/.." );
	
	final touchingBottomNonIsosceles = parseInput(
		"8 3
		..../\\..
		../XXX\\.
		/XXXXXX\\" );
	
	final touchingLeftOnlyXAndPoint = parseInput(
		"4 3
		X...
		XXXX
		X..." );
	
	final touchingRightTopRightAngle = parseInput(
		"4 4
		|XXX
		.\\XX
		..\\X
		...-" );
	
	final circleSmall = parseInput(
		"3 3
		/X\\
		XXX
		\\X/" );
	
	final circleBig = parseInput(
		"10 10
		...XXXX...
		./XXXXXX\\.
		.XXXXXXXX.
		XXXXXXXXXX
		XXXXXXXXXX
		XXXXXXXXXX
		XXXXXXXXXX
		.XXXXXXXX.
		.\\XXXXXXX.
		...XXXX..." );
	
	final ellipse1 = parseInput(
		"7 3
		.XXXXX.
		XXXXXXX
		.XXXX/." );
	
	final ellipse2 = parseInput(
		"7 4
		./XXX\\.
		XXXXXXX
		XXXXXXX
		.\\XXX/." );
	
	final ellipse3 = parseInput(
		"8 7
		..XXXX..
		.XXXXXX.
		XXXXXXXX
		XXXXXXXX
		XXXXXXXX
		.XXXXXX.
		..XXXX.." );
	
}

