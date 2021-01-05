package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Minimal", {
				final lines = parse( minimal );
				Main.process( lines, 2 ).should.be( "20km" );
			});
		
			it( "Three", {
				final lines = parse( three );
				Main.process( lines, 3 ).should.be( "20km" );
			});
		
			it( "ThreeWall", {
				final lines = parse( threeWall );
				Main.process( lines, 3 ).should.be( "40km" );
			});
		
			it( "Lost in playground", {
				final lines = parse( playground );
				Main.process( lines, 10 ).should.be( "50km" );
			});
		
			it( "Lost in paris", {
				final lines = parse( paris );
				Main.process( lines, 10 ).should.be( "120km" );
			});
		
			it( "Lost in jungle", {
				final lines = parse( jungle );
				Main.process( lines, 10 ).should.be( "160km" );
			});
		
			it( "Lost in Maze Runner", {
				final lines = parse( mazeRunner );
				Main.process( lines, 10 ).should.be( "200km" );
			});
		
			it( "Lost in Space", {
				final lines = parse( space );
				Main.process( lines, 10 ).should.be( "170km" );
			});
		
		});

	}

	static function parse( input:String ) {
		final lines = input.split( "\n" );
		return lines.map( line -> line.trim());
	}

	final minimal =
	"C.
	 .M";

	final three =
	"C.M
	 ...
	 ...";

	final threeWall =
	"C#M
	 ...
	 ...";

	final playground =
	"..........
	 M....C....
	 ..........
	 ..........
	 ..........
	 ..........
	 ..........
	 ..........
	 ..........
	 ..........";

	final paris =
	"..........
	 M#........
	 #C##......
	 ..........
	 ..........
	 ..........
	 ..........
	 ..........
	 ..........
	 ..........";

	final jungle =
	"##########
	 #...#C...#
	 #...##...#
	 ###.#..###
	 #.##M#...#
	 #.....#..#
	 #.....#..#
	 #.....#..#
	 #........#
	 ##########";

	final mazeRunner =
	"##########
	 #..M#C...#
	 #...##...#
	 ###..#.###
	 #.##.#...#
	 #.....#..#
	 #.....#..#
	 #.....#..#
	 #........#
	 ##########";

	final space =
	"##########
	 #...#....#
	 #.C.#.#..#
	 ###.#..###
	 #M#......#
	 #.###.#..#
	 #.#....#.#
	 #..#.##..#
	 #........#
	 ##########";

}

