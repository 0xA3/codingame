package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		describe( "Test process", {
			
			it( "R vs K", { Main.process( rvsk ).should.be( "Check" ); });
			it( "B vs K", { Main.process( bvsk ).should.be( "No Check" ); });
			it( "Q vs K", { Main.process( qvsk ).should.be( "Check" ); });
			it( "N vs K", { Main.process( nvsk ).should.be( "No Check" ); });
			it( "Test 5", { Main.process( test5 ).should.be( "Check" ); });
			
		});

	}

	static function parseInput( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" ).map( row -> row.split(" ")).flatten();
	}

	final rvsk = parseInput(
		"_ _ R _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ K _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _"
	);

	final bvsk = parseInput(
		"_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ K _ _ _ _ _
		_ _ B _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _"
	);

	final qvsk = parseInput(
		"Q _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ K _
		_ _ _ _ _ _ _ _"
	);

	final nvsk = parseInput(
		"_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ N _ K _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _"
	);

	final test5 = parseInput(
		"_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ _ _ _
		_ _ _ _ _ N _ _
		_ _ _ _ _ _ _ K"
	);

}

