package test;

using buddy.Should;
using StringTools;

@:access(Main)
class TestInterval extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test interval 0-9", {
			
			final interval:Interval = { min: 0, max: 9 }

			it( "Test mirror 0 ", {	interval.mirror( 0 ).should.be( 9 ); });
			it( "Test mirror 1 ", {	interval.mirror( 1 ).should.be( 8 ); });
			it( "Test mirror 4 ", {	interval.mirror( 4 ).should.be( 5 ); });
		});

		describe( "Test interval 5-15", {
			
			final interval:Interval = { min: 5, max: 15 }

			it( "Test mirror 4 ", {	interval.mirror( 4 ).should.be( 16 ); });
		});

	}
}