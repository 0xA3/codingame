package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "One place", {
				final ip = onePlace;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( onePlaceResult );
			});
			it( "One wall", {
				final ip = oneWall;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( oneWallResult );
			});
			it( "One in two", {
				final ip = oneInTwo;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( oneInTwoResult );
			});
			it( "Example", {
				final ip = example;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( exampleResult );
			});
			it( "No solution", {
				final ip = noSolution;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( noSolutionResult );
			});
			it( "Multiple solutions", {
				final ip = multipleSolutions;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( multipleSolutionsResult );
			});
			it( "No place for dot", {
				final ip = noPlaceForDot;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( noPlaceForDotResult );
			});
			it( "Empty smallest grid", {
				final ip = emptySmallestGrid;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( emptySmallestGridResult );
			});
			it( "Fragmented object", {
				final ip = fragmentedObject;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( fragmentedObjectResult );
			});
			it( "Lot of solutions", {
				final ip = lotOfSolutions;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( lotOfSolutionsResult );
			});
			it( "Validator 5", {
				final ip = validator5;
				Main.process( ip.a, ip.b, ip.object, ip.c, ip.d, ip.grid ).should.be( validator5Result );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final ohw = lines[0].split(" ");
		final a = parseInt( ohw[0] );
		final b = parseInt( ohw[1] );
		final object:Object = [for( i in 0...a ) lines[i + 1].split( "" ).map( s -> s == "*" )];
		
		final ghw = lines[a + 1].split(" ");
		final c = parseInt( ghw[0] );
		final d = parseInt( ghw[1] );
		final grid:Grid = [for( i in 0...c ) lines[i + a + 2].split( "" ).map( s -> s == "." )];

		return { a: a, b: b, object: object, c: c, d: d, grid: grid };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final onePlace = parseInput(
		"1 1
		*
		1 1
		."
	);

	final onePlaceResult = parseResult(
		"1
		*"
	);

	final oneWall = parseInput(
		"1 1
		*
		1 1
		#"
	);

	final oneWallResult = parseResult(
		"0"
	);

	final oneInTwo = parseInput(
		"1 1
		*
		1 2
		#."
	);

	final oneInTwoResult = parseResult(
		"1
		#*"
	);

	final example = parseInput(
		"3 2
		.*
		**
		.*
		8 10
		#..#######
		#.##..####
		###..##...
		####.#####
		##.#######
		##......##
		##.....###
		########.."
	);

	final exampleResult = parseResult(
		"1
		#..#######
		#.##*.####
		###**##...
		####*#####
		##.#######
		##......##
		##.....###
		########.."
	);

	final noSolution = parseInput(
		"3 3
		*..
		***
		..*
		5 6
		.#####
		..#.##
		#...##
		##.###
		##...."
	);

	final noSolutionResult = parseResult(
		"0"
	);

	final multipleSolutions = parseInput(
		"1 2
		**
		4 4
		.#.#
		##..
		....
		##.#"
	);

	final multipleSolutionsResult = parseResult(
		"4"
	);

	final noPlaceForDot = parseInput(
		"1 1
		*
		4 5
		#####
		#####
		#####
		#####"
	);

	final noPlaceForDotResult = parseResult(
		"0"
	);

	final emptySmallestGrid = parseInput(
		"5 3
		***
		*..
		**.
		..*
		**.
		5 3
		...
		...
		...
		...
		..."
	);

	final emptySmallestGridResult = parseResult(
		"1
		***
		*..
		**.
		..*
		**."
	);

	final fragmentedObject = parseInput(
		"4 4
		.*..
		*...
		...*
		..*.
		5 8
		........
		...#####
		...#####
		###.....
		###....."
	);

	final fragmentedObjectResult = parseResult(
		"1
		........
		..*#####
		.*.#####
		###.*...
		###*...."
	);

	final lotOfSolutions = parseInput(
		"2 3
		*..
		***
		10 10
		..........
		.##...#...
		......#...
		..........
		..##....#.
		..........
		....#.....
		.#........
		.#.......#
		.........."
	);

	final lotOfSolutionsResult = parseResult(
		"42"
	);

	final validator5 = parseInput(
		"3 5
		.*.*.
		*.*.*
		.*.*.
		3 5
		.....
		.....
		....."
	);

	final validator5Result = parseResult(
		"1
		.*.*.
		*.*.*
		.*.*."
	);

}

