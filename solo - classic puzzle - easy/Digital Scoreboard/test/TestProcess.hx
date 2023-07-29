package test;

using StringTools;
using buddy.Should;
using test.Utils;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test add", {
			it( "Add0", { Main.add( [[" "]], [[" "]] ).arrayJoin().should.be( " " ); });
			it( "Add1", { Main.add( [["~"]], [[" "]] ).arrayJoin().should.be( "~" ); });
			it( "Add2", { Main.add( [[" "]], [["~"]] ).arrayJoin().should.be( "~" ); });
			it( "Add3", { Main.add( [["~"]], [["~"]] ).arrayJoin().should.be( "~" ); });
		});

		describe( "Test subtract", {
			it( "Subtract0", { Main.subtract( [[" "]], [[" "]] ).arrayJoin().should.be( " " ); });
			it( "Subtract1", { Main.subtract( [["~"]], [[" "]] ).arrayJoin().should.be( "~" ); });
			it( "Subtract2", { Main.subtract.bind( [[" "]], [["~"]] ).should.throwValue( "Error: cannot subtract something from nothing." ); });
			it( "Subtract3", { Main.subtract( [["~"]], [["~"]] ).arrayJoin().should.be( " " ); });
		});

		describe( "Test process", {
			it( "Addition Only - Test 1", { Main.process( test1 ).should.be( "37" ); });
			it( "Subtraction Only - Test 2", { Main.process( test2 ).should.be( "53" ); });
			it( "Test 3", { Main.process( test3 ).should.be( "07" ); });
			it( "Test 4", { Main.process( test4 ).should.be( "90" ); });
			it( "Test 5", { Main.process( test5 ).should.be( "68" ); });
			it( "Nothing ever changes - Test 6", { Main.process( test6 ).should.be( "49" ); });
			it( "Test 7", { Main.process( test7 ).should.be( "32" ); });
			it( "Test 8", { Main.process( test8 ).should.be( "14" ); });
		});
	}

	static function parseInput( input:String ) {
		final grid = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" ).map( line -> line.split( "" ));
		return grid;
	}
	
	final test1  = parseInput(
		".................
		.       .       .
		.     | .     | .
		.       .       .
		.     | .     | .
		.       .       .
		.................
		Subtract:
		.................
		.       .       .
		.       .       .
		.       .       .
		.       .       .
		.       .       .
		.................
		Add:
		.................
		.  ~~~  .  ~~~  .
		.       .       .
		.  ~~~  .       .
		.       .       .
		.  ~~~  .       .
		................." );
	
	final test2  = parseInput(
		".................
		.  ~~~  .  ~~~  .
		. |   | . |   | .
		.  ~~~  .  ~~~  .
		. |   | . |   | .
		.  ~~~  .  ~~~  .
		.................
		Subtract:
		.................
		.       .       .
		.     | . |     .
		.       .       .
		. |     . |     .
		.       .       .
		.................
		Add:
		.................
		.       .       .
		.       .       .
		.       .       .
		.       .       .
		.       .       .
		................." );
	
	final test3  = parseInput(
		".................
		.       .  ~~~  .
		.     | . |   | .
		.       .       .
		.     | . |   | .
		.       .  ~~~  .
		.................
		Subtract:
		.................
		.       .       .
		.       . |     .
		.       .       .
		.       . |     .
		.       .  ~~~  .
		.................
		Add:
		.................
		.  ~~~  .       .
		. |     .       .
		.       .       .
		. |     .       .
		.  ~~~  .       .
		................." );
	
	final test4  = parseInput(
		".................
		.  ~~~  .  ~~~  .
		. |   | .     | .
		.       .  ~~~  .
		. |   | .     | .
		.  ~~~  .  ~~~  .
		.................
		Subtract:
		.................
		.       .       .
		.       .       .
		.       .  ~~~  .
		. |     .       .
		.       .       .
		.................
		Add:
		.................
		.       .       .
		.       . |     .
		.  ~~~  .       .
		.       . |     .
		.       .       .
		................." );
	
	final test5  = parseInput(
		".................
		.  ~~~  .  ~~~  .
		.     | . |     .
		.  ~~~  .  ~~~  .
		. |     . |   | .
		.  ~~~  .  ~~~  .
		.................
		Subtract:
		.................
		.       .       .
		.     | .       .
		.       .       .
		.       .       .
		.       .       .
		.................
		Add:
		.................
		.       .       .
		. |     .     | .
		.       .       .
		.     | .       .
		.       .       .
		................." );
	
	final test6  = parseInput(
		".................
		.       .  ~~~  .
		. |   | . |   | .
		.  ~~~  .  ~~~  .
		.     | .     | .
		.       .  ~~~  .
		.................
		Subtract:
		.................
		.       .       .
		.       .       .
		.       .       .
		.       .       .
		.       .       .
		.................
		Add:
		.................
		.       .       .
		.       .       .
		.       .       .
		.       .       .
		.       .       .
		................." );
	
	final test7  = parseInput(
		".................
		.  ~~~  .  ~~~  .
		.     | .     | .
		.  ~~~  .  ~~~  .
		. |     .     | .
		.  ~~~  .  ~~~  .
		.................
		Subtract:
		.................
		.       .       .
		.       .       .
		.       .       .
		. |     .     | .
		.       .       .
		.................
		Add:
		.................
		.       .       .
		.       .       .
		.       .       .
		.     | . |     .
		.       .       .
		................." );
	
	final test8  = parseInput(
		".................
		.  ~~~  .  ~~~  .
		. |     .     | .
		.  ~~~  .       .
		.     | .     | .
		.  ~~~  .       .
		.................
		Subtract:
		.................
		.  ~~~  .  ~~~  .
		. |     .       .
		.  ~~~  .       .
		.       .       .
		.  ~~~  .       .
		.................
		Add:
		.................
		.       .       .
		.     | . |     .
		.       .  ~~~  .
		.       .       .
		.       .       .
		................." );
}
