package test;

import Main.distance2Char;
import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test distance2Char", {
			it( "#", { distance2Char( -2 ).should.be( "#" ); });
			it( ".", { distance2Char( -1 ).should.be( "." ); });
			it( "0", { distance2Char( 0 ).should.be( "0" ); });
			it( "9", { distance2Char( 9 ).should.be( "9" ); });
			it( "A", { distance2Char( 10 ).should.be( "A" ); });
			it( "Z", { distance2Char( 35 ).should.be( "Z" ); });
		});


		describe( "Test process", {
			it( "Easy", {
				final ip = easy;
				Main.process( ip.grid, ip.w, ip.h ).should.be( easyResult );
			});
			it( "Loop", {
				final ip = loop;
				Main.process( ip.grid, ip.w, ip.h ).should.be( loopResult );
			});
			it( "Through borders", {
				final ip = throughBorders;
				Main.process( ip.grid, ip.w, ip.h ).should.be( throughBordersResult );
			});
			it( "Space", {
				final ip = space;
				Main.process( ip.grid, ip.w, ip.h ).should.be( spaceResult );
			});
			it( "Unreachable", {
				final ip = unreachable;
				Main.process( ip.grid, ip.w, ip.h ).should.be( unreachableResult );
			});
			it( "Everything", {
				final ip = everything;
				Main.process( ip.grid, ip.w, ip.h ).should.be( everythingResult );
			});
			it( "Blocked", {
				final ip = blocked;
				Main.process( ip.grid, ip.w, ip.h ).should.be( blockedResult );
			});
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		final grid = [for( i in 0...h ) lines[i + 1].split( '' )];
			
		return { w: w, h: h, grid: grid }
	}

	static function parseResult( input:String ) {
		return input.split( "\n" ).map( line -> line.trim()).join( "\n" );
	}

	static final easy = parseInput(
	"10 5
	##########
	#S.......#
	##.#####.#
	##.#.....#
	##########" );

	static final easyResult = parseResult(
	"##########
	#01234567#
	##2#####8#
	##3#DCBA9#
	##########" );

	static final loop = parseInput(
	"10 5
	##########
	#S.......#
	##.#####.#
	##.......#
	##########" );

	static final loopResult = parseResult(
	"##########
	#01234567#
	##2#####8#
	##3456789#
	##########" );

	static final throughBorders = parseInput(
	"10 5
	#.########
	#.##..####
	..##..#...
	####..#S##
	#....#####" );

	static final throughBordersResult = parseResult(
	"#7########
	#6##EF####
	45##DE#123
	####CD#0##
	#89AB#####" );

	static final space = parseInput(
	"15 10
	...............
	......#........
	...............
	...............
	...............
	............#..
	............#..
	...............
	S..............
	.#............." );

	static final spaceResult = parseResult(
	"234567899876543
	345678#AA987654
	456789ABBA98765
	56789ABCCBA9876
	456789ABBA98765
	3456789AA987#54
	234567899876#43
	123456788765432
	012345677654321
	1#3456788765432" );

	static final unreachable = parseInput(
	"19 7
	....#...#..........
	....#####..........
	....#...#..........
	....#.#.#..........
	......#............
	...S#####..........
	....#...#.........." );

	static final unreachableResult = parseResult(
	"5432#...#EEDCBA9876
	6543#####EFEDCBA987
	6543#567#DEEDCBA987
	5432#4#8#CDDCBA9876
	432123#9ABCCBA98765
	3210#####CCBA987654
	4321#...#DDCBA98765" );

	static final everything = parseInput(
	"27 13
	###########.###.###.###.###
	#.........#..............S#
	###########.....#########.#
	.....#...#.......#...#.....
	####...#...#.......#...####
	#....#...###....#######...#
	#.#######..#............#.#
	#...#........############.#
	#....#.#####....#.........#
	#.....#......##...##.###.#.
	.....#.#.....#.###.###.###.
	..................#.......#
	###.###.###.###.###.###.###" );

	static final everythingResult = parseResult(
	"###########F###B###7###3###
	#.........#EDCBA9876543210#
	###########FEDCB#########1#
	45678#CDE#HGFEDCD#BA9#54323
	####9AB#FGH#GFEDEDC#876####
	#DCBA#CDE###HGFE#######OPQ#
	#E#######NM#IHGFGHIJKLMN#R#
	#FGH#QPONMLKJ############S#
	#GHIJ#Q#####JKLM#QRSTUVVUT#
	#HIJKL#NMLKJI##NOP##U###V#L
	JIJKL#N#LKJIH#F###.###7###K
	KJKLMNMLKJIHGFEDEF#9876567#
	###M###M###G###C###8###4###" );

	static final blocked = parseInput(
	"5 5
	.....
	.....
	.###.
	.#S#.
	.###." );

	static final blockedResult = parseResult(
	".....
	.....
	.###.
	.#0#.
	.###." );
}

