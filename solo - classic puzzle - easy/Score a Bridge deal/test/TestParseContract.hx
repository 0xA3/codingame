package test;

import Main.parseContract;

using buddy.Should;

@:access(Main)
class TestParseContract extends buddy.BuddySuite {

	public function new() {

		describe( "Test process", {
			it( "4S", {
				final contract = parseContract( "4S");
				contract.pass.should.be( 4 );
				contract.suit.should.be( "S" );
				contract.doubles.should.be( 0 );
			});
			it( "2NT", {
				final contract = parseContract( "2NT");
				contract.pass.should.be( 2 );
				contract.suit.should.be( "N" );
				contract.doubles.should.be( 0 );
			});
			it( "7DX", {
				final contract = parseContract( "7DX");
				contract.pass.should.be( 7 );
				contract.suit.should.be( "D" );
				contract.doubles.should.be( 1 );
			});
			it( "1NTX", {
				final contract = parseContract( "1NTX");
				contract.pass.should.be( 1 );
				contract.suit.should.be( "N" );
				contract.doubles.should.be( 1 );
			});
			it( "6SXX", {
				final contract = parseContract( "6SXX");
				contract.pass.should.be( 6 );
				contract.suit.should.be( "S" );
				contract.doubles.should.be( 2 );
			});
			it( "1NTXX", {
				final contract = parseContract( "1NTXX");
				contract.pass.should.be( 1 );
				contract.suit.should.be( "N" );
				contract.doubles.should.be( 2 );
			});
		});
	}
}