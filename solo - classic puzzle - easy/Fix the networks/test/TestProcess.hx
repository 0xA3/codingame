package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "One", Main.process( one ).should.be( oneResult ));
			it( "Test 1", Main.process( test1 ).should.be( test1Result ));
			it( "Test 2", Main.process( test2 ).should.be( test2Result ));
			it( "Test 3", Main.process( test3 ).should.be( test3Result ));
			it( "Test 4", Main.process( test4 ).should.be( test4Result ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 1 );
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final one = parseInput(
		"1
		10.0.0.32/32"
	);

	final oneResult = parseResult(
		"valid 1"
	);

	final test1 = parseInput(
		"4
		10.0.0.32/32
		10.0.0.32/30
		10.0.0.32/28
		10.0.0.32/26"
	);

	final test1Result = parseResult(
		"valid 1
		valid 4
		valid 16
		invalid 10.0.0.32/27 32"
	);

	final test2 = parseInput(
		"5
		255.0.0.0/32
		255.0.0.0/24
		255.0.0.0/16
		255.0.0.0/8
		255.0.0.0/2"
	);

	final test2Result = parseResult(
		"valid 1
		valid 256
		valid 65536
		valid 16777216
		invalid 255.0.0.0/8 16777216"
	);

	final test3 = parseInput(
		"4
		0.10.0.10/31
		0.10.0.10/25
		0.10.0.10/10
		0.10.0.10/5"
	);

	final test3Result = parseResult(
		"valid 2
		invalid 0.10.0.10/31 2
		invalid 0.10.0.10/31 2
		invalid 0.10.0.10/31 2"
	);

	final test4 = parseInput(
		"2
		0.0.0.0/0
		255.255.255.255/0"
	);

	final test4Result = parseResult(
		"valid 4294967296
		invalid 255.255.255.255/32 1"
	);
}
