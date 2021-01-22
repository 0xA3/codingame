package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Quadrilateral", { Main.process( parseInput( "A -14 -3 B 5 -9 C 11 4 D -7 13" ) ).should.be( "ABCD is a quadrilateral." ); });
			it( "Parallelogram", { Main.process( parseInput( "D -4 -2 E 2 0 R 4 4 P -2 2" ) ).should.be( "DERP is a parallelogram." ); });
			it( "Rhombus", { Main.process( parseInput( "A -2 0 B 0 1 C 2 0 D 0 -1" ) ).should.be( "ABCD is a rhombus." ); });
			it( "Rectangle", { Main.process( parseInput( "E -2 -1 F -2 3 G 1 3 H 1 -1" ) ).should.be( "EFGH is a rectangle." ); });
			it( "Square", { Main.process( parseInput( "A 1 -2 B 5 0 C 3 4 D -1 2" ) ).should.be( "ABCD is a square." ); });
			it( "Everything", { Main.process( parseInput(
				"H -4 3 A 2 5 R 4 2 D 10 4
				J -2 0 A 0 1 C 2 0 K 0 -1
				A 1 -2 B 5 0 C 3 4 D -1 2" )
			).should.be( "HARD is a quadrilateral.\nJACK is a rhombus.\nABCD is a square." ); });
			
		});
	}

	static function parseInput( s:String ) {
		final lines = s.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final quads = [for( i in 0...lines.length ) {
			var inputs = lines[i].split(' ');
			final a = inputs[0];
			final xA = parseInt(inputs[1]);
			final yA = parseInt(inputs[2]);
			final b = inputs[3];
			final xB = parseInt(inputs[4]);
			final yB = parseInt(inputs[5]);
			final c = inputs[6];
			final xC = parseInt(inputs[7]);
			final yC = parseInt(inputs[8]);
			final d = inputs[9];
			final xD = parseInt(inputs[10]);
			final yD = parseInt(inputs[11]);
			[{ id: a, x: xA, y: yA }, { id: b, x: xB, y: yB }, { id: c, x: xC, y: yC }, { id: d, x: xD, y: yD }];
		}];
		return quads;
	}

}
