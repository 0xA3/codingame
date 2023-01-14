package test;

import Std.parseInt;

using Lambda;
using buddy.Should;
using test.Output;

class TestParser extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test parser", {
			it( ">", { Parser.parse( [">"] ).should.be( ">" ); });
			it( "te>st", { Parser.parse( [">"] ).should.be( ">" ); });
			it( "te\n>st", { Parser.parse( [">"] ).should.be( ">" ); });
			it( "><+-.,[]", { Parser.parse( ["><+-.,[]"] ).should.be( "><+-.,[]" ); });
			it( "><+-.,[] with comment", { Parser.parse( ["><+-.,[] with comment"] ).should.be( "><+-.,[]" ); });
		});
	}

	

}
