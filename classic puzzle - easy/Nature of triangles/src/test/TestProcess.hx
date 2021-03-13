package test;

import Main.Triangle;
import Std.parseInt;

using StringTools;
using buddy.Should;

class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test process", {
			
			it( "Scalene triangles", { Main.process( scaleneTriangles ).should.be( scaleneTrianglesResult ); });
			it( "Isosceles triangles", { Main.process( isocelesTriangles ).should.be( isocelesTrianglesResult ); });
			it( "Right angled triangles", { Main.process( rightAngledTriangles ).should.be( rightAngledTrianglesResult ); });
			it( "Almost right", { Main.process( almostRight ).should.be( almostRightResult ); });
			it( "Everything", { Main.process( everything ).should.be( everythingResult ); });
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final triangles:Array<Triangle> = [for( i in 1...lines.length ) {
			var inputs = lines[i].split(' ');
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
	
		return triangles;
	}

	static function parseResult( result:String ) {
		return result.replace( "\t", "" ).replace( "\r", "" );
	}

	final scaleneTriangles = parseInput(
		"2
		A 5 -2 B 8 2 C -1 -9
		O 0 0 A 3 0 B 1 2"
	);

	final scaleneTrianglesResult = parseResult(
		"ABC is a scalene and an obtuse in A (176°) triangle.
		OAB is a scalene and an acute triangle."
	);
	
	final isocelesTriangles = parseInput(
		"2
		D -4 -3 O 3 -4 G 8 1
		C -5 -2 A 3 -1 T -1 5"
	);
	
	final isocelesTrianglesResult = parseResult(
		"DOG is an isosceles in O and an obtuse in O (127°) triangle.
		CAT is an isosceles in C and an acute triangle."
	);
	
	final rightAngledTriangles = parseInput(
		"2
		O 0 0 I 1 0 J 0 1
		H 1 2 O 5 -6 G -1 0"
	);
	
	final rightAngledTrianglesResult = parseResult(
		"OIJ is an isosceles in O and a right in O triangle.
		HOG is a scalene and a right in G triangle."
	);
	
	final almostRight = parseInput(
		"1
		A 5 4 B -6 -1 C 9 -5"
	);
	
	final almostRightResult = parseResult(
		"ABC is a scalene and an acute triangle."
	);
	
	final everything = parseInput(
		"5
		A -3 5 C 4 1 D 0 -1
		A -5 -4 B 6 1 C -9 5
		C -3 2 O -2 -2 G 2 -1
		B 3 -4 C 8 1 D 1 2
		D -1 0 E 1 1 F 4 4"
	);
	
	final everythingResult = parseResult(
		"ACD is a scalene and a right in D triangle.
		ABC is a scalene and an acute triangle.
		COG is an isosceles in O and a right in O triangle.
		BCD is an isosceles in C and an acute triangle.
		DEF is a scalene and an obtuse in E (162°) triangle."
	);
	
}

