package test;

using buddy.Should;

@:access(Main)
class TestGetLetterWeights extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test TestGetLetterWeights", {
			
            it( "a length should be 1", {
				Main.getLetterWeights( "a" ).get( 'a' ).length.should.be( 1 );
			});
            
            it( "a depth should be 1", {
				Main.getLetterWeights( "a" ).get( 'a' )[0].should.be( 1 );
			});
            
            it( "a-a length should be 1", {
				Main.getLetterWeights( "a-a" ).get( 'a' ).length.should.be( 1 );
			});
            
            it( "a-a depth should be 1", {
				Main.getLetterWeights( "a-a" ).get( 'a' )[0].should.be( 1 );
			});
            
            it( "ab-b-a  a length should be 1", {
				Main.getLetterWeights( "ab-b-a" ).get( 'a' ).length.should.be( 1 );
			});
            
            it( "ab-b-a  a depth should be 1", {
				Main.getLetterWeights( "ab-b-a" ).get( 'a' )[0].should.be( 1 );
			});
            
            it( "ab-b-a depth of b should be 2", {
				Main.getLetterWeights( "ab-b-a" ).get( 'b' )[0].should.be( 2 );
			});
            
		});

	}
}