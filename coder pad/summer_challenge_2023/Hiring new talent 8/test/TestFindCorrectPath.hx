package test;

import CompileTime.readFile;
import Main.findCorrectPath;
import haxe.Json;

using buddy.Should;

class TestFindCorrectPath extends buddy.BuddySuite{

	static final test1Input = readFile( "test/test01.txt" );
	static final test2Input = readFile( "test/test02.txt" );
	static final test3Input = readFile( "test/test03.txt" );
	static final test4Input = readFile( "test/test04.txt" );
	static final test5Input = readFile( "test/test05.txt" );
	static final test6Input = readFile( "test/test06.txt" );
	static final test7Input = readFile( "test/test07.txt" );
	static final test8Input = readFile( "test/test08.txt" );
	static final test9Input = readFile( "test/test09.txt" );
	static final test10Input = readFile( "test/test10.txt" );
	static final test11Input = readFile( "test/test11.txt" );

	public function new() {

		var memPositions:Array<Array<Int>> = [];

		describe( "Test findCorrectPath", {
			it( "Example", {
				final ip = parseInput( test1Input );
				findCorrectPath( ip.instructions, ip.target, ip.obstacles ).should.be( "Replace instruction 2 with BACK" );	});

		});
	}

	static function parseInput( content:String ) {
		final lines = content.split( "\n" );
		final instructions = Json.parse( lines[0] );
		final target = Json.parse( lines[1] );
		final obstacles = Json.parse( lines[2] );
		return { instructions: instructions, target: target, obstacles: obstacles }
	}
}
