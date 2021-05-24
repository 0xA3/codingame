package test;

import Parser.Expr;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Parser)
class TestParser extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test parser", {
			
			var parser:Parser;

			beforeEach({
				parser = new Parser();
			});
			
			it( "Simple", {
				final ast = parser.parse( "A[0]" );
				ast.should.equal( EArray( "A", EIndex( 0 )) );
			});

			it( "Nested", {
				final ast = parser.parse( "A[B[0]]" );
				ast.should.equal( EArray( "A", EArray( "B", EIndex( 0 ))) );
			});

		});
			
	}

}

