package test;

using buddy.Should;
using xa3.NumberConvert;

class TestNumberConvert extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test NumberConvert decToBase", {
			
			it( "76 base 10", {	76.toBaseN( 10 ).should.be( "76" );	});
			it( "255 base 16", { 255.toBaseN( 16 ).should.be( "FF" ); });
			it( "83 base 12", { 83.toBaseN( 12 ).should.be( "6B" ); });
			it( "84 base 12", { 84.toBaseN( 12 ).should.be( "70" ); });
		});
		
		describe( "Test NumberConvert baseToDec", {
			
			it( "10 base 10", {	"76".toDec( 10 ).should.be( 76 );	});
			it( "255 base 16", { "FF".toDec( 16 ).should.be( 255 ); });
			it( "83 base 12", { "6B".toDec( 12 ).should.be( 83 ); });
			it( "84 base 12", { "70".toDec( 12 ).should.be( 84 ); });
		});
	}
}

