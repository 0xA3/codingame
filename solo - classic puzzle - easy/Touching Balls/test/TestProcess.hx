package test;

import Main.Sphere;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Test 1", Main.process( test1 ).should.be( 370 ));
			it( "Test 2", Main.process( test2 ).should.be( 209921 ));
			it( "Test 3", Main.process( test3 ).should.be( 76457 ));
			it( "Test 4", Main.process( test4 ).should.be( 140847 ));
			it( "Test 5", Main.process( test5 ).should.be( 110198 ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final n = parseInt( readline() );
		final spheres:Array<Sphere> = [for( _ in 0...n ) {
			final parts = readline().split(" ").map( s -> parseInt( s ));
			{ x:parts[0], y:parts[1], z:parts[2], r:parts[3] }
		}];
			
		return spheres;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"2
		0 0 0 1
		0 0 10 3"
	);

	final test2 = parseInput(
		"5
		16 21 72 4
		12 8 91 4
		51 38 87 6
		68 30 92 8
		78 17 25 6"
	);

	final test3 = parseInput(
		"25
		46 31 22 9
		45 29 40 6
		43 69 0 4
		6 41 69 8
		21 7 58 8
		11 91 49 9
		95 86 68 6
		17 97 19 9
		42 76 39 8
		82 49 93 10
		58 50 45 2
		40 74 58 9
		54 40 46 5
		27 66 37 2
		17 9 20 5
		92 87 55 3
		97 72 94 5
		12 12 38 10
		17 27 61 1
		91 48 63 4
		0 0 12 1
		18 61 33 8
		4 70 29 7
		42 14 73 3
		68 47 73 2"
	);

	final test4 = parseInput(
		"50
		34 59 97 9
		99 13 67 2
		99 98 1 1
		16 89 35 9
		52 99 23 7
		70 89 49 6
		50 20 15 9
		88 87 59 3
		90 13 61 2
		66 62 97 7
		27 62 15 8
		1 91 7 9
		7 59 35 6
		1 60 9 1
		22 0 47 1
		39 63 69 2
		75 95 36 4
		33 35 0 7
		81 27 93 6
		92 60 41 9
		59 34 99 9
		84 31 81 1
		14 16 0 3
		5 84 99 4
		99 98 76 2
		23 30 92 7
		70 98 89 8
		79 32 24 7
		4 80 52 8
		78 20 47 7
		46 11 41 2
		43 35 35 9
		14 66 31 2
		12 12 61 3
		92 39 29 5
		97 13 52 9
		76 10 64 10
		83 78 90 5
		53 57 83 10
		61 83 84 6
		90 10 81 1
		89 56 2 9
		66 52 24 5
		9 27 77 1
		26 96 76 5
		85 85 47 5
		59 72 6 8
		99 46 97 9
		34 45 36 3
		72 10 40 1"
	);

	final test5 = parseInput(
		"100
		96 53 89 6
		32 38 16 1
		52 24 37 9
		30 30 66 7
		15 65 9 5
		46 78 80 7
		71 27 56 2
		22 56 64 4
		68 41 55 8
		98 12 86 5
		59 33 8 4
		29 53 13 10
		50 66 88 4
		93 65 58 4
		7 52 66 9
		3 93 82 5
		91 1 53 1
		41 61 69 3
		89 61 24 1
		86 9 7 10
		28 12 89 8
		34 80 12 2
		80 63 73 4
		58 39 23 1
		4 92 29 1
		67 53 93 9
		61 5 80 4
		98 63 71 8
		79 48 49 2
		53 82 65 10
		85 61 48 5
		6 86 28 4
		89 26 27 5
		54 61 78 1
		3 57 21 6
		75 41 34 2
		98 74 50 8
		12 37 84 4
		62 67 2 9
		17 76 26 3
		31 55 71 4
		16 37 99 8
		99 45 2 10
		63 32 75 1
		43 53 96 1
		76 53 85 2
		40 6 22 5
		15 8 99 4
		17 22 5 2
		32 38 36 7
		21 38 59 3
		50 87 44 7
		47 55 3 9
		11 17 37 6
		86 31 4 4
		60 18 49 6
		74 82 74 10
		53 15 77 4
		65 5 8 7
		21 37 2 6
		31 88 90 2
		89 15 96 3
		48 24 62 5
		58 2 72 2
		69 38 96 4
		22 25 26 8
		86 90 80 4
		37 87 60 1
		51 46 77 8
		71 92 57 5
		47 95 86 3
		14 21 66 6
		80 72 66 3
		15 31 90 2
		59 2 32 8
		35 82 6 4
		35 19 55 3
		33 2 58 8
		46 76 97 6
		74 64 47 5
		19 21 48 8
		82 17 90 5
		2 94 1 1
		24 78 64 9
		67 99 44 5
		23 93 61 4
		2 3 20 1
		79 89 19 2
		52 87 18 3
		44 76 30 3
		83 60 21 1
		14 21 80 8
		63 26 22 6
		31 51 33 6
		13 86 40 7
		63 48 21 5
		53 41 65 1
		74 61 14 8
		87 69 64 2
		20 43 71 4"
	);
}
