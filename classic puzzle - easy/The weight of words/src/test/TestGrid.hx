package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestGrid extends buddy.BuddySuite{

	public function new() {

		describe( "Test grid", {
			
			var grid3:Array<Array<String>> = [];

            beforeEach({
				grid3 = [
					["A","B","C"],
					["D","E","F"],
					["G","H","I"]
				];
			});
			
			it( "Test getColumn", {
				Main.getColumn( grid3, 2 ).join( "" ).should.be( "CFI" );
			});
			
			it( "Test getRow", {
				Main.getRow( grid3, 2 ).join( "" ).should.be( "GHI" );
			});

			it( "Test setColumn", {
				Main.setColumn( grid3, ["J", "K", "L"], 2 );
				Main.getColumn( grid3, 2 ).join( "" ).should.be( "JKL" );
			});
			
			it( "Test setRow", {
				Main.setRow( grid3, ["J", "K", "L"], 2 );
				Main.getRow( grid3, 2 ).join( "" ).should.be( "JKL" );
			});
		});
	}
}
