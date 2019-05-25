package test;

using buddy.Should;

@:access(Main)
class TestBrackets extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Brackets", {
			
            it( "][ shoud be false", {
				Main.evaluate( "][" ).should.be( false );
			});
            
            it( "{(}) shoud be false", {
				Main.evaluate( "{(})" ).should.be( false );
			});
            
            it( "{([]){}()} shoud be true", {
				Main.evaluate( "{([]){}()}" ).should.be( true );
			});
            
            it( "{[{iHTSc}]}p(R)m(){q({}) shoud be false", {
				Main.evaluate( "{[{iHTSc}]}p(R)m(){q({})" ).should.be( false );
			});
		});

	}
}