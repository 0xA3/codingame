package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "1", { Main.convertToBT( 1 ).should.be( "1" ); });
			it( "2", { Main.convertToBT( 2 ).should.be( "1T" ); });
			it( "3", { Main.convertToBT( 3 ).should.be( "10" ); });
			it( "4", { Main.convertToBT( 4 ).should.be( "11" ); });
			it( "5", { Main.convertToBT( 5 ).should.be( "1TT" ); });
			it( "6", { Main.convertToBT( 6 ).should.be( "1T0" ); });
			it( "7", { Main.convertToBT( 7 ).should.be( "1T1" ); });
			it( "Short", { Main.convertToBT( 8 ).should.be( "10T" ); });
			it( "142", { Main.convertToBT( 142 ).should.be( "1TT1T1" ); });
			it( "345", { Main.convertToBT( 345 ).should.be( "111T10" ); });
			it( "-1", { Main.convertToBT( -1 ).should.be( "T" ); });
			it( "-2", { Main.convertToBT( -2 ).should.be( "T1" ); });
			it( "-3", { Main.convertToBT( -3 ).should.be( "T0" ); });
			it( "-4", { Main.convertToBT( -4 ).should.be( "TT" ); });
			it( "-5", { Main.convertToBT( -5 ).should.be( "T11" ); });
			it( "-142", { Main.convertToBT( -142 ).should.be( "T11T1T" ); });
			it( "-345", { Main.convertToBT( -345 ).should.be( "TTT1T0" ); });
			it( "Negative", { Main.convertToBT( -15 ).should.be( "T110" ); });
			it( "Long", { Main.convertToBT( -255 ).should.be( "T00TT0" ); });
			it( "Single digit", { Main.convertToBT( 0 ).should.be( "0" ); });
			
		});
	}

}
