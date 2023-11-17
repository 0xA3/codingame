package test;

import Std.parseInt;
import haxe.ds.Either;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.ship, ip.wormhole ).should.be( test1Result );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.ship, ip.wormhole ).should.be( test2Result );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.ship, ip.wormhole ).should.be( test3Result );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.ship, ip.wormhole ).should.be( test4Result );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.ship, ip.wormhole ).should.be( test5Result );
			});
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.ship, ip.wormhole ).should.be( test6Result );
			});
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.ship, ip.wormhole ).should.be( test7Result );
			});
			it( "Test 8", {
				final ip = test8;
				Main.process( ip.ship, ip.wormhole ).should.be( test8Result );
			});
			it( "Test 9", {
				final ip = test9;
				Main.process( ip.ship, ip.wormhole ).should.be( test9Result );
			});
			it( "Test 10", {
				final ip = test10;
				Main.process( ip.ship, ip.wormhole ).should.be( test10Result );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return { ship: lines[0], wormhole: lines[1] }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"i+j-k
		i-j+k"
	);

	final test1Result = parseResult(
		"Direction: -j+k
		Distance: 2.83"
	);
	
	final test2 = parseInput(
		"3i+5j+2k
		4i+9j+3k"
	);

	final test2Result = parseResult(
		"Direction: i+4j+k
		Distance: 4.24"
	);
	
	final test3 = parseInput(
		"133i - 6 j -8k
		4i +8j -44 k"
	);

	final test3Result = parseResult(
		"Direction: -129i+14j-36k
		Distance: 134.66"
	);
	
	final test4 = parseInput(
		"89k-76i  +76j
		56i +67j+ 90k"
	);

	final test4Result = parseResult(
		"Direction: 132i-9j+k
		Distance: 132.31"
	);
	
	final test5 = parseInput(
		"112i - 456k - 90j
		12 i + 87k + 65j"
	);

	final test5Result = parseResult(
		"Direction: -100i+155j+543k
		Distance: 573.48"
	);
	
	final test6 = parseInput(
		"8893i + 9984k -329j
		2348k -4343i +3488j"
	);

	final test6Result = parseResult(
		"Direction: -13236i+3817j-7636k
		Distance: 15750.23"
	);
	
	final test7 = parseInput(
		"-i
		k"
	);

	final test7Result = parseResult(
		"Direction: i+k
		Distance: 1.41"
	);
	
	final test8 = parseInput(
		"4i+12j-8k
		4i-6j+4k"
	);

	final test8Result = parseResult(
		"Direction: -3j+2k
		Distance: 21.63"
	);
	
	final test9 = parseInput(
		"2487i-3943k-4393j
		3443i-434k"
	);

	final test9Result = parseResult(
		"Direction: 956i+4393j+3509k
		Distance: 5703.11"
	);
	
	final test10 = parseInput(
		"40j+20i
		60j+90k"
	);

	final test10Result = parseResult(
		"Direction: -2i+2j+9k
		Distance: 94.34"
	);
}
