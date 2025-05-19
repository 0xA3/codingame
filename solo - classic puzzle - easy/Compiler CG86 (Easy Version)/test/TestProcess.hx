package test;

import test.Readline.initReadline;
import test.Readline.readline;

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
			it( "Test 9", Main.process( test9 ).should.be( test9Result ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final expression = readline().split(" ");
					
		return expression;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput( "1 + 2 + 2 + 2 + 2 - 3" );

	final test1Result = parseResult(
		"ADD cgx 1
		REPEAT 4
		ADD cgx 2
		SUB cgx 3
		EXIT"
	);

	final test2 = parseInput( "1 + 2 + 2 - 3 + 2 + 2" );

	final test2Result = parseResult(
		"ADD cgx 1
		REPEAT 4
		ADD cgx 2
		SUB cgx 3
		EXIT"
	);

	final test3 = parseInput( "1 + 2" );

	final test3Result = parseResult(
		"ADD cgx 1
		ADD cgx 2
		EXIT"
	);

	final test4 = parseInput( "1 - 2" );

	final test4Result = parseResult(
		"ADD cgx 1
		SUB cgx 2
		EXIT"
	);

	final test5 = parseInput( "1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9" );

	final test5Result = parseResult(
		"ADD cgx 1
		ADD cgx 2
		ADD cgx 3
		ADD cgx 4
		ADD cgx 5
		ADD cgx 6
		ADD cgx 7
		ADD cgx 8
		ADD cgx 9
		EXIT"
	);

	final test6 = parseInput( "1 - 2 - 3 - 4 - 5 - 6 - 7 - 8 - 9" );

	final test6Result = parseResult(
		"ADD cgx 1
		SUB cgx 2
		SUB cgx 3
		SUB cgx 4
		SUB cgx 5
		SUB cgx 6
		SUB cgx 7
		SUB cgx 8
		SUB cgx 9
		EXIT"
	);

	final test7 = parseInput( "- 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 + 3 - 9 - 9 - 9 - 9 + 5 + 6 + 5 + 4 + 5 - 9 - 9 - 9 - 9 - 9 - 9 - 9 + 3 - 1 + 1 + 5" );

	final test7Result = parseResult(
		"REPEAT 2
		SUB cgx 1
		ADD cgx 2
		REPEAT 24
		ADD cgx 3
		REPEAT 2
		ADD cgx 4
		REPEAT 5
		ADD cgx 5
		REPEAT 2
		ADD cgx 6
		ADD cgx 7
		ADD cgx 8
		ADD cgx 9
		REPEAT 11
		SUB cgx 9
		ADD cgx 1
		EXIT"
	);

	final test8 = parseInput( "- 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9" );

	final test8Result = parseResult(
		"REPEAT 127
		SUB cgx 9
		EXIT"
	);

	final test9 = parseInput( "- 9 + 1 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 + 5 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 - 9 + 1
" );

	final test9Result = parseResult(
		"REPEAT 127
		SUB cgx 9
		REPEAT 2
		ADD cgx 1
		ADD cgx 5
		EXIT"
	);
}