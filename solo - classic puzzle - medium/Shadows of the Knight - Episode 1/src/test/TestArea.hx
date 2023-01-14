package test;

using buddy.Should;

class TestArea extends buddy.BuddySuite {
	
	public function new() {

		describe( "Test Center", {
			
			it( "centerX of 1 1 rectangle should be 1", {
				new Area( 0, 0, 1, 1 ).center.x.should.be( 1 );
			});
			
			it( "centerY of 1 1 rectangle should be 1", {
				new Area( 0, 0, 1, 1 ).center.y.should.be( 1 );
			});
			
			it( "centerX of 2 2 rectangle should be 1", {
				new Area( 0, 0, 1, 1 ).center.x.should.be( 1 );
			});
			
			it( "centerX of 0 0 10 5 rectangle should be 5", {
				new Area( 0, 0, 10, 10 ).center.x.should.be( 5 );
			});
			
			it( "centerY of 0 0 10 5 rectangle should be 3", {
				new Area( 0, 0, 10, 5 ).center.y.should.be( 3 );
			});
			
			it( "centerX of 10 10 19 19 rectangle be 15", {
				new Area( 10, 10, 19, 19 ).center.x.should.be( 15 );
			});
			
		});
	}
}