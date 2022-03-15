package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Sample 1", {
				Main.process( ["1231210106"] ).should.be( "OK" );
			});
			
			it( "Sample 2", {
				Main.process( ["5360241298"] ).should.be( "5378241298" );
			});
			
			it( "Sample 3", {
				Main.process( ["1003290208"] ).should.be( "1005290208" );
			});
			
			it( "Valid Numbers", {
				Main.process( validNumbers ).should.be( validNumbersResult );
			});
			
			it( "Syntax Errors", {
				Main.process( syntaxErrors ).should.be( syntaxErrorsResult );
			});

			it( "Invalid Dates", {
				Main.process( invalidDates ).should.be( invalidDatesResult );
			});

			it( "29th February", {
				Main.process( february29th ).should.be( february29thResult );
			});

			it( "10 Consecutive Numbers", {
				Main.process( tenConsecutiveNumbers ).should.be( tenConsecutiveNumbersResult );
			});

			it( "Rejected Identifier", {
				Main.process( rejectedIdentifier ).should.be( rejectedIdentifierResult );
			});

		});
			
	}


	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return lines.slice( 1 );
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final validNumbers = parseInput(
		"3
		1231210106
		5378241298
		3872231176" );
	
	final validNumbersResult = parseResult(
		"OK
		OK
		OK" );
	
	final syntaxErrors = parseInput(
		"5
		124210106
		32851710765
		123A210106
		123421 106
		0375010205" );
	
	final syntaxErrorsResult = parseResult(
		"INVALID SYNTAX
		INVALID SYNTAX
		INVALID SYNTAX
		INVALID SYNTAX
		INVALID SYNTAX" );
		
	final invalidDates = parseInput(
		"5
		1234310406
		1334101308
		9873290202
		1334100008
		1334001298" );
	
	final invalidDatesResult = parseResult(
		"INVALID DATE
		INVALID DATE
		INVALID DATE
		INVALID DATE
		INVALID DATE" );
		
	final february29th = parseInput(
		"7
		1230290204
		4543290205
		5555290200
		8035290200
		5555290201
		1457290220
		1003290208" );
	
	final february29thResult = parseResult(
		"OK
		INVALID DATE
		OK
		OK
		INVALID DATE
		1468290220
		1005290208" );
		
	final tenConsecutiveNumbers = parseInput(
		"10
		2000010489
		2001010489
		2002010489
		2003010489
		2004010489
		2005010489
		2006010489
		2007010489
		2008010489
		2009010489" );
	
	final tenConsecutiveNumbersResult = parseResult(
		"2007010489
		2007010489
		2007010489
		2007010489
		2007010489
		2007010489
		2007010489
		OK
		2007010489
		2007010489" );
		
	final rejectedIdentifier = parseInput(
		"3
		5364241298
		3981270998
		8085010819" );
	
	final rejectedIdentifierResult = parseResult(
		"5378241298
		3998270998
		8098010819" );
}

