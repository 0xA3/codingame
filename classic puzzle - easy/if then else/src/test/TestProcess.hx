package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Smallest program", { Main.process( smallestProgram ).should.be( 1 ); });
			it( "One Condition", { Main.process( oneCondition ).should.be( 2 ); });
			it( "Multiple conditions", { Main.process( multipleConditions ).should.be( 4 ); });
			it( "Nested conditions", { Main.process( nestedConditions ).should.be( 3 ); });
			it( "Optional statements", { Main.process( optionalStatements ).should.be( 13 ); });
			it( "More conditions", { Main.process( moreConditions ).should.be( 42 ); });
			it( "Deeper nests", { Main.process( deeperNests ).should.be( 80 ); });
			it( "Conditions overflow", { Main.process( conditionsOverflow ).should.be( 4294967296 ); });
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return lines.slice( 1 );
	}

	final smallestProgram = parseInput(
		"2
		begin
		end"
	);

	final oneCondition = parseInput(
		"5
		begin
		if
		else
		endif
		end"
	);

	final multipleConditions = parseInput(
		"8
		begin
		if
		else
		endif
		if
		else
		endif
		end"
	);

	final nestedConditions = parseInput(
		"11
		begin
		if
		S
		else
		if
		S
		else
		S
		endif
		endif
		end"
	);

	final optionalStatements = parseInput(
		"30
		begin
		S
		S
		if
		if
		else
		S
		endif
		S
		if
		else
		endif
		if
		S
		else
		endif
		else
		if
		if
		else
		endif
		if
		else
		S
		endif
		else
		endif
		S
		endif
		end"
	);

	final moreConditions = parseInput(
		"43
		begin
		if
		if
		else
		S
		if
		else
		endif
		endif
		if
		else
		endif
		S
		if
		if
		else
		endif
		else
		if
		else
		if
		else
		endif
		endif
		endif
		else
		if
		else
		S
		if
		else
		endif
		endif
		if
		else
		endif
		if
		S
		else
		S
		endif
		endif
		end"
	);

	final deeperNests = parseInput(
		"42
		begin
		if
		if
		if
		if
		if
		if
		if
		else
		endif
		else
		endif
		else
		endif
		else
		endif
		else
		endif
		else
		endif
		else
		endif
		S
		if
		else
		if
		else
		if
		else
		if
		S
		else
		S
		endif
		endif
		endif
		endif
		S
		if
		else
		endif
		end"
	);

	final conditionsOverflow = parseInput(
		"98
		begin
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		if
		else
		endif
		end"
	);


}

