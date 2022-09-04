package test;

using StringTools;
using buddy.Should;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Triangle", { Main.process( "0103070F1F3F7FFF" ).should.be( triangle ); });
			it( "Character", { Main.process( "1898FF3D3C3CE404" ).should.be( character ); });
			it( "Spaceship", { Main.process( "183C7EDBFF245AB5" ).should.be( spaceship ); });
			it( "Pac Man", { Main.process( "3C7EFFF0FCFF7E3C" ).should.be( pacman ); });
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final triangle = parseResult(
	".......#
	......##
	.....###
	....####
	...#####
	..######
	.#######
	########" );
	
	static final character = parseResult(
	"...##...
	#..##...
	########
	..####.#
	..####..
	..####..
	###..#..
	.....#.." );
	
	static final spaceship = parseResult(
	"...##...
	..####..
	.######.
	##.##.##
	########
	..#..#..
	.#.##.#.
	#.##.#.#" );

	static final pacman = parseResult(
	"..####..
	.######.
	########
	####....
	######..
	########
	.######.
	..####.." );
}
