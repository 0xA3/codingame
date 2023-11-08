package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( test1 ).should.be( test1Result ));
			it( "Test 2", Main.process( test2 ).should.be( test2Result ));
			it( "Test 3", Main.process( test3 ).should.be( test3Result ));
			it( "Test 4", Main.process( test4 ).should.be( test4Result ));
			it( "Test 5", Main.process( test5 ).should.be( test5Result ));
			it( "Test 6", Main.process( test6 ).should.be( test6Result ));
			it( "Test 7", Main.process( test7 ).should.be( test7Result ));
			it( "Test 8", Main.process( test8 ).should.be( test8Result ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 1 );
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final test1 = parseInput(
		"1
		RT 90;setpc #;PD;FD 1;PU;FD 1;PD;FD 1"
	);

	final test1Result = parseResult(
		"# #"
	);

	final test2 = parseInput(
		"9
		CS .
		SETPC *
		FD 5
		RT 90
		FD 5
		RT 90
		FD 5
		RT 90
		FD 5"
	);

	final test2Result = parseResult(
		"******
		*....*
		*....*
		*....*
		*....*
		******"
	);

	final test3 = parseInput(
		"13
		RT 90
		FD 5
		rt 180;fd 5;lt 90;fd 1;lt 90
		FD 5
		rt 180;fd 5;lt 90;fd 1;lt 90
		FD 5
		rt 180;fd 5;lt 90;fd 1;lt 90
		FD 5
		rt 180;fd 5;lt 90;fd 1;lt 90
		FD 5
		rt 180;fd 5;lt 90;fd 1;lt 90
		FD 5
		rt 180;fd 5;lt 90;fd 1;lt 90"
	);

	final test3Result = parseResult(
		"######
		######
		######
		######
		######
		######"
	);
	
	final test4 = parseInput(
		"51
		setpc *;rt 90
		fd 2
		lt 90
		fd 2
		rt 90
		fd 2
		rt 90
		fd 2
		lt 90
		fd 2
		lt 90
		fd 2
		lt 90
		fd 2
		rt 90
		fd 2
		rt 90
		fd 2
		lt 90
		fd 2
		rt 90
		fd 2
		lt 90
		fd 2
		rt 90
		fd 2
		rt 90
		fd 2
		lt 90
		fd 2
		rt 90
		fd 2
		lt 90
		fd 2
		rt 90
		fd 2
		rt 90
		fd 2
		lt 90
		fd 2
		lt 90
		fd 2
		lt 90
		fd 2
		rt 90
		fd 2
		rt 90
		fd 2
		lt 90
		fd 2
		fd 1"
	);

	final test4Result = parseResult(
		"        ***
		        * *
		      *** ***
		      *     *
		    ***     ***
		    *         *
		  *****     *****
		  * * *     * * *
		*** ***     *** ***"
	);

	final test5 = parseInput(
		"31
		setpc *;rt 90
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;rt 180;fd 10;lt 90;fd 1;lt 90
		pd;fd 1;pu;fd 1
		pd;fd 1;pu;fd 1
		pd;fd 1;pu;fd 1
		pd;fd 1;pu;fd 1
		pd;fd 1;pu;fd 1
		pu;rt 180;fd 10;lt 90;fd 1;lt 90
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;rt 180;fd 10;lt 90;fd 1;lt 90
		pd;fd 1;pu;fd 1
		pd;fd 1;pu;fd 1
		pd;fd 1;pu;fd 1
		pd;fd 1;pu;fd 1
		pd;fd 1;pu;fd 1
		pu;rt 180;fd 10;lt 90;fd 1;lt 90
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;fd 1;pd;fd 1
		pu;rt 180;fd 10;lt 90;fd 1;lt 90"
	);

	final test5Result = parseResult(
		" * * * * *
		* * * * *
		 * * * * *
		* * * * *
		 * * * * *"
	);

	final test6 = parseInput(
		"18
		rt 90
		setpc H;fd 1
		setpc e;fd 1
		setpc l;fd 1
		setpc l;fd 1
		setpc o;fd 1
		pu;fd 1;pd
		setpc T;fd 1
		setpc e;fd 1
		setpc s;fd 1
		setpc t;fd 1
		pu;fd 1;pd
		setpc W;fd 1
		setpc o;fd 1
		setpc r;fd 1
		setpc l;fd 1
		setpc d;fd 1
		setpc !;fd 1"
	);

	final test6Result = parseResult(
		"Hello Test World!"
	);

	final test7 = parseInput(
		"1
		RT 90;FD 2;RT 180;FD 1;LT 90;FD 2;PU;FD 1;SETPC *;PD;FD 1;LT 90;FD 1;RT 180;FD 3"
	);

	final test7Result = parseResult(
		"###
		 #
		
		 *
		***"
	);

	final test8 = parseInput(
		"23
		SetPC #;CS .
		Lt 90;Fd 1
		Lt 90;Fd 2
		Lt 90;Fd 3
		Lt 90;Fd 4
		Lt 90;Fd 5
		Lt 90;Fd 6
		Lt 90;Fd 7
		Lt 90;Fd 8
		Lt 90;Fd 9
		Lt 90;Fd 10
		Lt 90;Fd 11
		Lt 90;Fd 12
		Lt 90;Fd 13
		Lt 90;Fd 14
		Lt 90;Fd 15
		Lt 90;Fd 16
		Lt 90;Fd 17
		Lt 90;Fd 18
		Lt 90;Fd 19
		Lt 90;Fd 20
		Lt 90;Fd 21
		fd 1"
	);

	final test8Result = parseResult(
		"######################
		.....................#
		..##################.#
		..#................#.#
		..#.##############.#.#
		..#.#............#.#.#
		..#.#.##########.#.#.#
		..#.#.#........#.#.#.#
		..#.#.#.######.#.#.#.#
		..#.#.#.#....#.#.#.#.#
		..#.#.#.#.##.#.#.#.#.#
		..#.#.#.#.#..#.#.#.#.#
		..#.#.#.#.####.#.#.#.#
		..#.#.#.#......#.#.#.#
		..#.#.#.########.#.#.#
		..#.#.#..........#.#.#
		..#.#.############.#.#
		..#.#..............#.#
		..#.################.#
		..#..................#
		..####################"
	);
}
