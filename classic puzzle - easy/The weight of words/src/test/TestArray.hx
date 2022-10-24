package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestArray extends buddy.BuddySuite{

	public function new() {

		describe( "Test array", {
			
			var a:Array<String> = [];

            beforeEach({
				a = ["A","B","C"];
			});
			
			it( "Test move 1", {
				Main.moveArray( a, 1 );
				a.join( "" ).should.be( "CAB" );
			});
			
			it( "Test move 2", {
				Main.moveArray( a, 2 );
				a.join( "" ).should.be( "BCA" );
			});
			
			it( "Test move 3", {
				Main.moveArray( a, 3 );
				a.join( "" ).should.be( "ABC" );
			});
		});
	}
}
