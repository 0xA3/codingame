package test;

import Main.Entry;
import Std.parseFloat;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Drone Boi", {
				final ip = droneBoi;
				Main.process( ip.r, ip.rows ).should.be( droneBoiResult );
			});
			it( "Upside Down", {
				final ip = upsideDown;
				Main.process( ip.r, ip.rows ).should.be( upsideDownResult );
			});
			it( "Cluttered", {
				final ip = cluttered;
				Main.process( ip.r, ip.rows ).should.be( clutteredResult );
			});
			it( "Double Trouble", {
				final ip = doubleTrouble;
				Main.process( ip.r, ip.rows ).should.be( doubleTroubleResult );
			});
			it( "Huh?", {
				final ip = huh;
				Main.process( ip.r, ip.rows ).should.be( huhResult );
			});
			it( "Where?", {
				final ip = where;
				Main.process( ip.r, ip.rows ).should.be( whereResult );
			});
			it( "Big Boi", {
				final ip = bigBoi;
				Main.process( ip.r, ip.rows ).should.be( bigBoiResult );
			});
			it( "Going Down", {
				final ip = goingDown;
				Main.process( ip.r, ip.rows ).should.be( goingDownResult );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final x = parseInt( readline() );
		final y = parseInt( readline() );
		final r = parseInt( readline() );
		final rows = [for( i in 0...y ) readline()];
					
		return { r: r, rows: rows };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final droneBoi = parseInput(
		"3
		3
		0
		.@.
		+§+
		^.^"
	);

	final droneBoiResult = "1 Gyroscope, 1 Fuel, 1 Core, 1 Fuel, 2 Thrusters";

	final upsideDown = parseInput(
		"3
		3
		1
		^#^
		+§+
		#@#"
	);

	final upsideDownResult = "1 Block, 1 Gyroscope, 1 Block, 1 Fuel, 1 Core, 1 Fuel, 1 Thruster, 1 Block, 1 Thruster";

	final cluttered = parseInput(
		"5
		5
		0
		....,
		'+#+.
		.@#§.
		.^+^.
		!...."
	);

	final clutteredResult = "1 Fuel, 1 Block, 1 Fuel, 1 Gyroscope, 1 Block, 1 Core, 1 Thruster, 1 Fuel, 1 Thruster";

	final doubleTrouble = parseInput(
		"5
		5
		1
		...,.
		j#^#.
		.+§+.
		;#@#.
		....'"
	);

	final doubleTroubleResult = "1 Block, 1 Gyroscope, 1 Block, 1 Fuel, 1 Core, 1 Fuel, 1 Block, 1 Thruster, 1 Block";

	final huh = parseInput(
		"1
		1
		0
		#"
	);

	final huhResult = "1 Block";

	final where = parseInput(
		"1
		1
		0
		."
	);

	final whereResult = "Nothing";

	final bigBoi = parseInput(
		"13
		11
		0
		..:........./
		.a..#####....
		..#########..
		!.##+@@@+##..
		..##+++++##.,
		..##+§§§+##.*
		..##+++++##..
		..#########..
		..##^^#^^##.b
		..#.,...*.#.(
		*......%....."
	);

	final bigBoiResult = "16 Blocks, 1 Fuel, 3 Gyroscopes, 1 Fuel, 4 Blocks, 5 Fuels, 4 Blocks, 1 Fuel, 3 Cores, 1 Fuel, 4 Blocks, 5 Fuels, 13 Blocks, 2 Thrusters, 1 Block, 2 Thrusters, 4 Blocks";

	final goingDown = parseInput(
		"13
		13
		1
		.i...........
		.^^^#^^^#^^^a
		.###########.
		.#+++#@#+++#.
		;#+++#@#+++#.
		.#+++#@#+++#.
		.###########!
		.#+++#§#+++#.
		.###########.
		.#+++#@#+++#,
		.#+++#@#+++#.
		.z#########..
		.-..........*"
	);

	final goingDownResult = "10 Blocks, 3 Fuels, 1 Block, 1 Gyroscope, 1 Block, 3 Fuels, 2 Blocks, 3 Fuels, 1 Block, 1 Gyroscope, 1 Block, 3 Fuels, 13 Blocks, 3 Fuels, 1 Block, 1 Core, 1 Block, 3 Fuels, 13 Blocks, 3 Fuels, 1 Block, 1 Gyroscope, 1 Block, 3 Fuels, 2 Blocks, 3 Fuels, 1 Block, 1 Gyroscope, 1 Block, 3 Fuels, 2 Blocks, 3 Fuels, 1 Block, 1 Gyroscope, 1 Block, 3 Fuels, 12 Blocks, 3 Thrusters, 1 Block, 3 Thrusters, 1 Block, 3 Thrusters";
}
