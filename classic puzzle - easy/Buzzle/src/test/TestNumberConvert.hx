package test;

using buddy.Should;
using xa3.NumberConvert;

class TestNumberConvert extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test NumberConvert decToBase", {
			
			it( "76 base 10", {	76.decToBase( 10 ).should.be( "76" );	});
			it( "255 base 16", { 255.decToBase( 16 ).should.be( "FF" ); });
			it( "83 base 12", { 83.decToBase( 12 ).should.be( "6B" ); });
			it( "84 base 12", { 84.decToBase( 12 ).should.be( "70" ); });
		});
		
		describe( "Test NumberConvert baseToDec", {
			
			it( "10 base 10", {	"76".baseToDec( 10 ).should.be( 76 );	});
			it( "255 base 16", { "FF".baseToDec( 16 ).should.be( 255 ); });
			it( "83 base 12", { "6B".baseToDec( 12 ).should.be( 83 ); });
			it( "84 base 12", { "70".baseToDec( 12 ).should.be( 84 ); });
		});
	}
}

