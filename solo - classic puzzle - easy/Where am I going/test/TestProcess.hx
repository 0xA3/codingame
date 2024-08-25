package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Example", {
				final ip = example;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "2" );
			});
			it( "Simple", {
				final ip = simple;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "3R2R1" );
			});
			it( "Spiral", {
				final ip = spiral;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "10R9R9R7R7R5R5R3R3R1" );
			});
			it( "Hard", {
				final ip = hard;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "3R2L3L1R3R3R1L1R2R1L2L3L3R2R2L2L6L3L2R2R2L1R2R8R11R10L1" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final h = parseInt( lines[0] );
		final w = parseInt( lines[1] );
		final grid = [for( i in 0...h ) lines[i + 2].split( "" )];

		return { w: w, h: h, grid: grid };
	}

	final example = parseInput(
		"1
		5
		##..."
	);

	final simple = parseInput(
		"3
		3
		###
		..#
		.##"
	);

	final spiral = parseInput(
		"10
		10
		##########
		.........#
		########.#
		#......#.#
		#.####.#.#
		#.#..#.#.#
		#.#....#.#
		#.######.#
		#........#
		##########"
	);

	final hard = parseInput(
		"15
		17
		###..............
		..#..####........
		..####..#........
		##......#........
		.#.###.##........
		.#.#.###..###....
		.#.#....###.#....
		.#.####.#...#....
		.#....#.###.#....
		.#..###...#.#....
		.#..#.....#.#....
		.#..#######.#....
		.#..........#....
		.############....
		................."
	);
}
