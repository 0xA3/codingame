package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	////////////////////////////////////////////////////////////////////////////
	// readline helper
	static var lineCounter = 0;
	static var inputLines:Array<String>;
	static function initReadline( input:String ) {
		lineCounter = 0;
		inputLines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
	}
	static function readline() return inputLines[lineCounter++];
	////////////////////////////////////////////////////////////////////////////

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.invoices, ip.paymentEntries ).should.be( test1Result );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.invoices, ip.paymentEntries ).should.be( test2Result );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.invoices, ip.paymentEntries ).should.be( test3Result );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.invoices, ip.paymentEntries ).should.be( test4Result );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );

		final n = parseInt( readline() );
		final m = parseInt( readline() );
		final invoices = [for( _ in 0...n ) parseInt( readline() )];
		final paymentEntries = [for( _ in 0...m ) parseInt( readline() )];
	
		return { invoices: invoices, paymentEntries: paymentEntries };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final test1 = parseInput(
		"1
		1
		5
		5"
	);

	final test1Result = parseResult(
		"A 5 - 5"
	);

	final test2 = parseInput(
		"2
		2
		6
		7
		7
		6"
	);

	final test2Result = parseResult(
		"A 7 - 7
		B 6 - 6"
	);

	final test3 = parseInput(
		"2
		1
		4
		6
		10"
	);

	final test3Result = parseResult(
		"A 10 - 4 6"
	);

	final test4 = parseInput(
		"4
		3
		10
		12
		10
		14
		10
		24
		12"
	);

	final test4Result = parseResult(
		"A 10 - 10
		B 24 - 10 14
		C 12 - 12"
	);
}
