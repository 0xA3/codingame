package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {

			it( "test1", {
				Main.resetMines();
				Main.process( test1 ).should.be( "No safe cell found" );
			});
			it( "test2", {
				Main.resetMines();
				Main.process( test2 ).should.be( "2 1 1 2" );
			});
			it( "test3", {
				Main.resetMines();
				Main.process( test3 ).should.be( "2 2 3 2" );
			});
		});
	}

	static function parseInput( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" ).map( row -> row.split( "" ) );
	}

	final test1 = parseInput(
		".1?"
	);

	final test2 = parseInput(
		"...
		11?
		1??"
	);
	final test3 = parseInput(
		".....
		1122*
		?????"
	);
}
