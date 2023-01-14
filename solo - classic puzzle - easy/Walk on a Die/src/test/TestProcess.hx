package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Test Up", {
				final ip = testUp;
				Main.process( ip.startingPosition, ip.commands ).should.be( 1 ); });
			it( "Test Left", {
				final ip = testLeft;
				Main.process( ip.startingPosition, ip.commands ).should.be( 2 ); });
			it( "Test Right", {
				final ip = testRight;
				Main.process( ip.startingPosition, ip.commands ).should.be( 5 ); });
			it( "Test Down", {
				final ip = testDown;
				Main.process( ip.startingPosition, ip.commands ).should.be( 6 ); });
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.startingPosition, ip.commands ).should.be( 1 ); });
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.startingPosition, ip.commands ).should.be( 2 ); });
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.startingPosition, ip.commands ).should.be( 6 ); });
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.startingPosition, ip.commands ).should.be( 2 ); });
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.startingPosition, ip.commands ).should.be( 5 ); });
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.startingPosition, ip.commands ).should.be( 5 ); });
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.startingPosition, ip.commands ).should.be( 3 ); });
			it( "Test 8", {
				final ip = test8;
				Main.process( ip.startingPosition, ip.commands ).should.be( 5 ); });
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final startingPosition = lines.slice( 0, 3 );
		final commands = lines[3].split( "" );

		return { startingPosition: startingPosition, commands: commands };
	}
	
	final testUp = parseInput(
	   " 1
		2354
		 6
		U"
	);

	final testLeft = parseInput(
	   " 1
		2354
		 6
		L"
	);

	final testRight = parseInput(
	   " 1
		2354
		 6
		R"
	);
	
	final testDown = parseInput(
	   " 1
		2354
		 6
		D"
	);

	final test1 = parseInput(
	   " 1
		2354
		 6
		DLU"
	);

	final test2 = parseInput(
	   " 2
		3146
		 5
		U"
	);

	final test3 = parseInput(
	   " 5
		6413
		 2
		L"
	);

	final test4 = parseInput(
	   " 6
		4532
		 1
		UU"
	);

	final test5 = parseInput(
	   " 2
		1463
		 5
		LL"
	);

	final test6 = parseInput(
	   " 1
		5423
		 6
		ULRD"
	);

	final test7 = parseInput(
	   " 6
		5324
		 1
		ULDR"
	);

	final test8 = parseInput(
	   " 4
		2156
		 3
		UUURRLDDDLLU"
	);
}

