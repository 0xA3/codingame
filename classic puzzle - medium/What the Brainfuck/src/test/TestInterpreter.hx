package test;

import Std.parseInt;

using Lambda;
using buddy.Should;
using test.Output;
class TestInterpreter extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test interpreter 1", {
			
			var interpreter:Interpreter;

			beforeEach({ interpreter = new Interpreter( 1 ); });
			
			it( ".", { interpreter.execute( "." ).charCodes().should.be( "0" ); });
			it( "+.", { interpreter.execute( "+." ).charCodes().should.be( "1" ); });
			it( "+-.", { interpreter.execute( "+-." ).charCodes().should.be( "0" ); });
			it( ",.", { interpreter.execute( ",.", ["A".code] ).should.be( "A" ); });
			it( ">", { interpreter.execute( ">" ).should.be( "POINTER OUT OF BOUNDS" ); });
			it( "<", { interpreter.execute( "<" ).should.be( "POINTER OUT OF BOUNDS" ); });
		});
		
		describe( "Test interpreter 2", {
			
			var interpreter:Interpreter;

			beforeEach({
                interpreter = new Interpreter( 2 );
            });
			
			it( ".", { interpreter.execute( "." ).charCodes().should.be( "0" ); });
			it( ">.", { interpreter.execute( ">." ).charCodes().should.be( "0" ); });
		});
	}

	
}
