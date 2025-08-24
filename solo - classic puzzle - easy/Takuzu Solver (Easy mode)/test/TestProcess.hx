package test;

import CodinGame.printErr;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.n, ip.grid ).should.be( test1Result );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.n, ip.grid ).should.be( test2Result );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.n, ip.grid ).should.be( test3Result );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.n, ip.grid ).should.be( test4Result );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.n, ip.grid ).should.be( test5Result );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final n = parseInt( readline() );
		final grid = [for( _ in 0...n ) readline().split( "" )];
		
		return  { n: n, grid: grid }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"6
		.0...1
		0.11..
		..1..0
		.1...0
		....1.
		11.0.0"
	);
	
	final test1Result = parseResult(
		"100101
		001101
		011010
		110100
		001011
		110010"
	);

	final test2 = parseInput(
		"8
		.....00.
		.1......
		11.0..0.
		..0....1
		.1...0..
		0.0..0..
		....1..0
		0.11.11."
	);
	
	final test2Result = parseResult(
		"10011001
		01100110
		11001001
		10010101
		01101010
		01010011
		10101100
		00110110"
	);

	final test3 = parseInput(
		"10
		.......1..
		.00..0..1.
		.0..1..0.0
		..1...1...
		1.1......1
		.......1..
		.0..1...0.
		....11...0
		.0.0..1..0
		0...0...1."
	);
	
	final test3Result = parseResult(
		"0110010101
		1001100110
		1001101010
		0110011001
		1010100101
		0101010110
		1001101001
		0110110100
		1010011010
		0101001011"
	);

	final test4 = parseInput(
		"12
		0.0.0..1...0
		....1...0...
		.0.......1..
		10.01.1...0.
		..1.....0...
		....1.0....0
		.1....0...1.
		.....1...0..
		..1...0....1
		1......1..0.
		.00..00.0...
		.1.1..1..1.0"
	);
	
	final test4Result = parseResult(
		"010101011010
		011010100101
		100101010110
		101010101001
		011001100101
		100110011010
		011010010110
		100101101001
		011001001011
		101010110100
		100110010011
		010101101100"
	);

	final test5 = parseInput(
		"14
		01.1.10.....1.
		1.......1.1.10
		..11..1...1..0
		1...1..0......
		...1.0..1....0
		11....0....0..
		....0.....1..1
		1.1...0.00...1
		1...0..1....0.
		.1..0...0.0...
		......1.0..1..
		..1....1.....1
		00.0.0....1..1
		.0..1...11..0."
	);
	
	final test5Result = parseResult(
		"01010101010011
		11001001101010
		00110110101100
		10101010010011
		01011001101100
		11010100110010
		00100110011011
		10101001001101
		11010101100100
		01100110010011
		10011011001100
		01100101100101
		00101010011011
		10011010110100"
	);
}