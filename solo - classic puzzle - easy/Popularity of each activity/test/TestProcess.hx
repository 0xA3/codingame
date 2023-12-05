package test;

import CompileTime.readFile;
import Std.parseFloat;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( parseInput( readFile( "test/test_01.txt" ))).should.be( test1Result ));
			it( "Test 2 - easy percentages", Main.process( parseInput( readFile( "test/test_02.txt" ))).should.be( test2Result ));
			it( "Test 3 - 100 percent", Main.process( parseInput( readFile( "test/test_03.txt" ))).should.be( test3Result ));
			it( "Test 4 - simple rounding", Main.process( parseInput( readFile( "test/test_04.txt" ))).should.be( test4Result ));
			it( "Test 5", Main.process( parseInput( readFile( "test/test_05.txt" ))).should.be( test5Result ));
			it( "Test 6", Main.process( parseInput( readFile( "test/test_06.txt" ))).should.be( test6Result ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 1 );
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1Result = parseResult(
		"4 attendees
		_25% __0% __0%
		__0% _50% __0%
		__0% _25% __0%"
	);

	final test2Result = parseResult(
		"10 attendees
		__0% __0% _10%
		_30% _10% __0%
		_20% _10% _20%"
	);

	final test3Result = parseResult(
		"3 attendees
		100% __0% __0%
		__0% __0% __0%
		__0% __0% __0%"
	);

	final test4Result = parseResult(
		"3 attendees
		_67% __0% __0%
		_33% __0% __0%
		__0% __0% __0%"
	);

	final test5Result = parseResult(
		"71 attendees
		__1% _10% __1%
		_37% _24% __3%
		_23% __1% __0%"
	);

	final test6Result = parseResult(
		"872 attendees
		_15% __0% _11%
		_17% _14% _31%
		__5% __2% __5%"
	);
}
