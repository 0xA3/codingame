package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test1", {
				Main.process( "John has a cat and a dog" )
				.should.be( "John has a cat and dog" );
			});
			
			it( "Test2", {
				Main.process( "Billy likes to watch soccer and likes to watch basketball" )
				.should.be( "Billy likes to watch soccer and basketball" );
			});
			
			it( "Test3", {
				Main.process( "Bob is hungry and is thirsty" )
				.should.be( "Bob is hungry and thirsty" );
			});
			
			it( "Test4", {
				Main.process( "It is cool that Bob plays basketball and plays hockey" )
				.should.be( "It is cool that Bob plays basketball and hockey" );
			});
		});
	}

}
