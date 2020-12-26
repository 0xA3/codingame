package test;

import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

import Main;
using buddy.Should;
using StringTools;

typedef ProcessInput = {
	final startRow:Int;
	final startCol:Int;
	final rowMaps:Array<Array<String>>;
}

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Tests", {
			
			it( "Test example", {
				final processInput = parse( example );
				Main.process( processInput.startRow, processInput.startCol, processInput.rowMaps ).should.be( "1" );
			});
			
			it( "Test trap", {
				final processInput = parse( trap );
				Main.process( processInput.startRow, processInput.startCol, processInput.rowMaps ).should.be( "TRAP" );
			});
			
			it( "Test twoMaps", {
				final processInput = parse( twoMaps );
				Main.process( processInput.startRow, processInput.startCol, processInput.rowMaps ).should.be( "0" );
			});
			
			it( "Test manyMaps", {
				final processInput = parse( manyMaps );
				Main.process( processInput.startRow, processInput.startCol, processInput.rowMaps ).should.be( "2" );
			});
			
			it( "Test di", {
				final processInput = parse( di );
				Main.process( processInput.startRow, processInput.startCol, processInput.rowMaps ).should.be( "TRAP" );
			});
			
			it( "Test epicQuest", {
				final processInput = parse( epicQuest );
				Main.process( processInput.startRow, processInput.startCol, processInput.rowMaps ).should.be( "3" );
			});
			
		});

	}

	function parse( input:String ) {
		final inputRows = input.split( "\n" );
		
		var inputs = inputRows[0].split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		var inputs = inputRows[1].split(' ');
		final startRow = parseInt( inputs[0] );
		final startCol = parseInt( inputs[1] );
		final n = parseInt( inputRows[2] );
		
		// trace( 'w: $w, h: $h, startRow: $startRow, startCol: $startCol, n: $n' );
		
		final rowMaps:Array<Array<String>> = [];
		for( i in 0...n ) {
			final rowMap:Array<String> = [];
			for( j in 0...h ) {
				final row = inputRows[3 + i * h + j].trim();
				rowMap.push( row );
			}
			rowMaps.push( rowMap );
		}

		return { startRow: startRow, startCol: startCol, rowMaps: rowMaps };
	}

	final example ="4 4
	1 1
	3
	.>>v
	.^#v
	..#v
	...T
	....
	.v#.
	.v#.
	.>>T
	....
	v<#.
	v.#.
	..>T";

	final trap = "6 7
	0 0
	1
	>.....
	......
	......
	......
	......
	......
	.....T";

	final twoMaps = "6 7
	2 2
	2
	......
	......
	..>>T.
	......
	......
	......
	......
	.>>>>v
	.^...v
	.^<.T<
	......
	......
	......
	......";

	final manyMaps = "11 11
	5 1
	5
	...........
	...........
	.#########.
	.>>>>>>>>>v
	.^..###...v
	.^..###..T<
	....###....
	...........
	.#########.
	...........
	...........
	>>>>>>>>>>v
	^.........v
	^#########v
	^.........v
	^...###...v
	^<..###..T<
	....###....
	...........
	.#########.
	...........
	...........
	...........
	...........
	.#########.
	.>>>>>>>>v.
	.^..###..v.
	.^..###..T.
	....###....
	...........
	.#########.
	...........
	...........
	...........
	...........
	.#########.
	.>>>>>>>...
	.^..###....
	.^..###..T.
	....###..^.
	...>>>>>>^.
	.#########.
	...........
	...........
	...........
	...........
	.#########.
	>>>>>>>>>v.
	^...###..v.
	^<..###..T.
	....###....
	...........
	.#########.
	...........
	...........";

	final di = "19 12
	2 4
	2
	###################
	#.................#
	#..>>>v......>T...#
	#..^..>v.....^<...#
	#..^...>v.........#
	#..^....v....>v...#
	#..^....v....^v...#
	#..^...v<....^v...#
	#..^..v<.....^v...#
	#..^<<<......^<...#
	#.................#
	###################
	###################
	#.................#
	#...>>>v......>T..#
	#...^..>v.....^<..#
	#...^...>v........#
	#...^....v....>v..#
	#...^....v....^v..#
	#...^...v<....^v..#
	#...^..v<.....^v..#
	#...^<<<......^<..#
	#.................#
	###################";

	final epicQuest = "19 19
	0 9
	6
	#########v#########
	##...............##
	#........#........#
	#....##..#..##....#
	#....##..#..##....#
	...####..#..####...
	...####..#..####...
	#........#........#
	#.#............#..#
	#.#..###.#.###.#..#
	#.#............#..#
	#.......###.......#
	.......#####.......
	..#...#######...#..
	#..#...#####...#..#
	##..#...###...#..##
	###..#...#...#..###
	####.....T.....####
	###################
	#########v#########
	##.......>>v.....##
	#........#.v......#
	#....##..#.v##....#
	#....##..#.v##....#
	...####..#v<####...
	...####..#>v####...
	#........#.>>>>>>v#
	#.#............#.v#
	#.#..###.#.###.#.v#
	#.#............#.v#
	#.......###......v#
	.......#####..v<<<.
	..#...#######v<.#..
	#..#...#####v<.#..#
	##..#...###v<.#..##
	###..#...#v<.#..###
	####.....T<....####
	###################
	#########v#########
	##......v>>>>>>>v##
	#.......v#......>v#
	#....##.v#..##...v#
	#....##.v#..##...v#
	...####.v#..####.>>
	...####.v#..####...
	#...v<<<v#........#
	#.#.>^..v......#..#
	#.#..###v#.###.#..#
	#.#....v<......#..#
	#.....v<###.......#
	.....v<#####.......
	..#..v#######...#..
	#..#.>v#####...#..#
	##..#.>v###...#..##
	###..#.>v#...#..###
	####....>T.....####
	###################
	#########v#########
	##......v<>>>>>>v##
	#.......v#......>v#
	#....##.v#..##...v#
	#....##.v#..##...v#
	...####.v#..####.>>
	...####.v#..####...
	#...v<<<v#........#
	#.#.>^..v......#..#
	#.#..###v#.###.#..#
	#.#....v<......#..#
	#.....v<###.......#
	.....v<#####.......
	..#..v#######...#..
	#..#.>v#####...#..#
	##..#.>v###...#..##
	###..#.>v#...#..###
	####....>T.....####
	###################
	#########v#########
	##.......>>>>>>>v##
	#........#......>v#
	#....##..#..##...v#
	#....##..#..##...v#
	...####..#..####.>v
	...####..#..####.v<
	#........#.......v#
	#.#............#.v#
	#.#..###v#.###.#.v#
	#.#............#.v#
	#.......###......v#
	.......#####.....>v
	..#...#######...#v<
	#..#...#####...#v<#
	##..#...###...#v<##
	###..#...#...#v<###
	####.....T<<<<<####
	###################
	#########v#########
	##.......>>>>>>>v##
	#........#......>v#
	#....##..#..##...v#
	#....##..#..##...v#
	...####..#..####.>v
	...####..#..####.v<
	#........#.......v#
	#.#............#.v#
	#.#..###v#.###.#.v#
	#.#....v<<<<...#.v#
	#.....v<###^<....v#
	.....v<#####^<...>v
	..#..v#######^..#v<
	#..#.>v#####>^.#v<#
	##..#.>v###>^.#v<##
	###..#.>v#>^.#v<###
	####....>T^<<<<####
	###################";

}

