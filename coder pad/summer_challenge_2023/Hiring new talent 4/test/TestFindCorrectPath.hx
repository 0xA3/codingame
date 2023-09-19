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

	public function new() {

		describe( "Test findCorrectPath", {
			it( "Example", {
				final ip = parseInput( test1Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 1 with TURN RIGHT" );	});
			it( "Single possibility", {
				final ip = parseInput( test2Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 2 with TURN RIGHT" ); });
			it( "Back to the start", {
				final ip = parseInput( test3Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 4 with BACK" ); });
			it( "More distance", {
				final ip = parseInput( test4Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 6 with TURN RIGHT" ); });
			it( "Never going back", {
				final ip = parseInput( test5Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 3 with FORWARD" ); });
			it( "Stairs", {
				final ip = parseInput( test6Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 1 with BACK" ); });
			it( "Unique solution", {
				final ip = parseInput( test7Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 195 with TURN RIGHT" ); });
			it( "Late fix", {
				final ip = parseInput( test8Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 500 with FORWARD" ); });
			it( "Walking backwards", {
				final ip = parseInput( test9Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 38 with BACK" ); });
			it( "Many solutions", {
				final ip = parseInput( test10Input );
				findCorrectPath( ip.instructions, ip.target ).should.be( "Replace instruction 12 with BACK" ); });
		});
	}

	static function parseInput( content:String ) {
		final lines = content.split( "\n" );
		final instructions = Json.parse( lines[0] );
		final target = Json.parse( lines[1] );
		return { instructions: instructions, target: target }
	}
}
