package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Basic North", {
				final ip = basicNorth;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "3 leagues" );
			});
			it( "Basic East", {
				final ip = basicEast;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "7 leagues" );
			});
			it( "Basic South", {
				final ip = basicSouth;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "2 leagues" );
			});
			it( "Basic West", {
				final ip = basicWest;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "6 leagues" );
			});
			it( "Basic North-East", {
				final ip = basicNorthEast;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "4 leagues" );
			});
			it( "Basic South-East", {
				final ip = basicSouthEast;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "2 leagues" );
			});
			it( "Basic South-West", {
				final ip = basicSouthWest;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "3 leagues" );
			});
			it( "Basic North-West", {
				final ip = basicNorthWest;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "6 leagues" );
			});
			it( "North and NE (Open)", {
				final ip = northAndNeOpen;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "5 leagues" );
			});
			it( "East and SE (Open)", {
				final ip = eastAndSeOpen;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "13 leagues" );
			});
			it( "South and SW (Open)", {
				final ip = southAndSwOpen;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "7 leagues" );
			});
			it( "West and NW (Open)", {
				final ip = westAndNwOpen;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "10 leagues" );
			});
			it( "Simple Horizontal Journey", {
				final ip = simpleHorizontalJourney;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "1 league" );
			});
			it( "Simple Vertical Journey", {
				final ip = simpleVerticalJourney;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "1 league" );
			});
			it( "Simple Diagonal Journey", {
				final ip = simpleDiagonalJourney;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "1 league" );
			});
			it( "Simple Diagonal Journey 2", {
				final ip = simpleDiagonalJourney_2;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "1 league" );
			});
			it( "Around the World 1", {
				final ip = aroundTheWorld_1;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "18 leagues" );
			});
			it( "Around the World 2", {
				final ip = aroundTheWorld_2;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "18 leagues" );
			});
			it( "Maze 1", {
				final ip = maze_1;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "34 leagues" );
			});
			it( "Maze 2", {
				final ip = maze_2;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "24 leagues" );
			});
			@exclude it( "Large Maze", {
				final ip = largeMaze;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "157 leagues" );
			});
			it( "Simple Outside Traversal", {
				final ip = simpleOutsideTraversal;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "23 leagues" );
			});
			it( "Horizontal Outside Traversal", {
				final ip = horizontalOutsideTraversal;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "43 leagues" );
			});
			it( "Vertical Outside Traversal", {
				final ip = verticalOutsideTraversal;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "22 leagues" );
			});
			it( "Complete Traversal", {
				final ip =completeTraversal;
				Main.process( ip.w, ip.h, ip.grid ).should.be( "59 leagues" );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		final inputs = readline().split(' ');
		final h = parseInt(inputs[0]);
		final w = parseInt(inputs[1]);
		final emptyRow = [for( _ in 0...w + 2 ) " "];
		final grid = [
			[emptyRow],
			[for ( i in 0...h ) (" " + readline() + " ").split( "" )],
			[emptyRow]
		].flatten();

		return { w: w + 2, h: h + 2, grid: grid }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final basicNorth = parseInput(
		"6 5
		^^^^^
		^^M ^
		^   ^
		^^ ^^
		^ B^^
		^^^^^"
	);

	final basicEast = parseInput(
		"4 10
		^^^^^^^^^^
		^B      M^
		^^ ^^^^^ ^
		^^^^^^^^^^"
	);

	final basicSouth = parseInput(
		"5 5
		^^^^^
		^B  ^
		^ ^ ^
		^M  ^
		^^^^^"
	);

	final basicWest = parseInput(
		"4 9
		^^^^^^^^^
		^M     B^
		^^ ^  ^ ^
		^^^^^^^^^"
	);

	final basicNorthEast = parseInput(
		"8 12
		^^^^^^^^^^^^
		^     M  ^^^
		^ ^     ^  ^
		^ ^    ^   ^
		^     ^    ^
		^ B  ^     ^
		^    ^     ^
		^^^^^^^^^^^^"
	);

	final basicSouthEast = parseInput(
		"5 5
		^^^^^
		^B  ^
		^  ^^
		^^ M^
		^^^^^"
	);

	final basicSouthWest = parseInput(
		"6 5
		^^^^^
		^  B^
		^  ^^
		^  ^^
		^M  ^
		^^^^^"
	);

	final basicNorthWest = parseInput(
		"9 16
		^^^^^^^^^^^^^^^^
		^    ^^^M  ^   ^
		^          ^   ^
		^^         ^   ^
		^ ^         ^  ^
		^ ^          ^ ^
		^ ^            ^
		^  ^  ^^^^    B^
		^^^^^^^^^^^^^^^^"
	);

	final northAndNeOpen = parseInput(
		"6 5
		   M 
		     
		     
		 ^   
		 ^   
		B^   "
	);

	final eastAndSeOpen = parseInput(
		"5 20
		      ^^^  ^^    ^^^
		 B                ^^
		 ^^^^^^^^^^^        
		 ^          ^      ^
		^^           ^M    ^"
	);

	final southAndSwOpen = parseInput(
		"10 5
		     
		     
		  ^B 
		  ^  
		^^^  
		^^^  
		^^^  
		^^   
		^    
		M    "
	);

	final westAndNwOpen = parseInput(
		"6 12
		 ^^^^^^^    
		 ^^^^^     B
		 ^^^^  ^^^^^
		 ^^^  ^^^^^^
		 ^^  ^^^^^^^
		 M  ^^^^^^^^"
	);

	final simpleHorizontalJourney = parseInput(
		"3 4
		^^^^
		^BM^
		^^^^"
	);

	final simpleVerticalJourney = parseInput(
		"6 5
		^^^^^
		^   ^
		^ B ^
		^ M ^
		^   ^
		^^^^^"
	);

	final simpleDiagonalJourney = parseInput(
		"2 2
		M 
		 B"
	);

	final simpleDiagonalJourney_2 = parseInput(
		"4 4
		^   
		^B  
		  M^
		  ^ "
	);

	final aroundTheWorld_1 = parseInput(
		"17 19
		         ^         
		        ^^^        
		       ^^ ^^       
		      ^^   ^^      
		     ^^  ^  ^^     
		    ^^  ^^^  ^^    
		   ^^  ^^^^^  ^^   
		  ^^  ^^^^^^^B ^^  
		 ^^  ^^^^^^^^^^^^^ 
		  ^^  ^^^^^^^M ^^  
		   ^^  ^^^^^  ^^   
		    ^^  ^^^  ^^    
		     ^^  ^  ^^     
		      ^^   ^^      
		       ^^ ^^       
		        ^^^        
		         ^         "
	);

	final aroundTheWorld_2 = parseInput(
		"10 10
		^^^^^^^^^^
		^^       ^
		^^ ^^^^ ^^
		^^B^  ^  ^
		^^^^  ^  ^
		^ M^  ^  ^
		^  ^  ^  ^
		^  ^^^^  ^
		^        ^
		^^^^^^^^^^"
	);

	final maze_1 = parseInput(
		"6 23
		^^^^^^^^^^^^^^^^^^^^^^^
		^^               ^^^^^^
		^M^B^^ ^ ^ ^^^        ^
		^  ^  ^ ^ ^   ^^^^^   ^
		^                   ^^^
		^^^^^^^^^^^^^^^^^^^^^^^"
	);

	final maze_2 = parseInput(
		"11 21
		^^^^^^^^^^ ^^^^^^^^^ 
		^M        ^         ^
		^ ^^^^ ^^ ^  ^^^^^^ ^
		^     ^     ^       ^
		 ^^^  ^ ^^  ^ ^^^^ ^^
		^   ^ ^   ^ ^     ^ ^
		^ ^ ^  ^^ ^  ^^^^ ^^^
		^ ^   ^     ^     ^^^
		^  ^^^  ^^^^ ^^^^ ^^^
		^                B^^^
		 ^^^^^^^^^^^^^^^^^ ^^"
	);

	final largeMaze = parseInput(
		"41 41
		 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
		^                                       ^
		^                                       ^
		^                                       ^
		^    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^     ^
		^   ^                                   ^
		^   ^                               ^   ^
		^   ^                               ^   ^
		^   ^    ^^^^^^^^^^^^^^^^^^^^^^^    ^   ^
		^   ^   ^                       ^   ^   ^
		^   ^   ^                       ^   ^   ^
		^   ^   ^                       ^   ^   ^
		^   ^   ^     ^^^^^^^^^^^^^^    ^   ^   ^
		^   ^   ^                   ^   ^   ^   ^
		^   ^   ^   ^               ^   ^   ^   ^
		^   ^   ^   ^               ^   ^   ^   ^
		^   ^   ^   ^    ^^^^^^^    ^   ^   ^   ^
		^   ^   ^   ^   ^       ^   ^   ^   ^   ^
		^   ^   ^   ^   ^       ^   ^   ^   ^   ^
		^   ^   ^   ^   ^       ^   ^   ^   ^   ^
		^   ^   ^   ^   ^   B   ^   ^   ^   ^   ^
		^   ^   ^   ^   ^       ^   ^   ^   ^   ^
		^   ^   ^   ^   ^       ^   ^   ^   ^   ^
		^   ^   ^   ^   ^           ^   ^   ^   ^
		^   ^   ^   ^    ^^^^^^     ^   ^   ^   ^
		^   ^   ^   ^               ^   ^   ^   ^
		^   ^   ^   ^               ^   ^   ^   ^
		^   ^   ^   ^               ^   ^   ^   ^
		^   ^   ^    ^^^^^^^^^^^^^^^    ^   ^   ^
		^   ^   ^                       ^   ^   ^
		^   ^   ^                       ^   ^   ^
		^   ^                           ^   ^   ^
		^   ^     ^^^^^^^^^^^^^^^^^^^^^^    ^   ^
		^   ^                               ^   ^
		^   ^                               ^   ^
		^   ^                               ^   ^
		^    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    ^
		^                                       ^
		^                                       ^
		                                        ^
		M ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ "
	);

	final simpleOutsideTraversal = parseInput(
		"10 10
		^^^^^^^^^^
		^B        
		^^^^^^^^^^
		^^^^^^^^^^
		^^^^^^^^^^
		^^^^^^^^^^
		^^^^^^^^^^
		^^^^^^^^^^
		^M        
		^^^^^^^^^^"
	);

	final horizontalOutsideTraversal = parseInput(
		"19 20
		^^^    ^^^^^^^^^  ^^
		^^    ^^^^^^^^^^  ^^
		^^    ^^     ^^  ^^^
		^^    ^  ^^   ^^   ^
		^    ^^  ^^   ^^^   
		   ^^^  ^^^   ^^^^  
		^^^^^   ^^^^   ^^^B^
		^^^    ^^^^^^^   ^^^
		^^^                 
		      ^^^^^^   ^^^^^
		^^^^^^^    ^^^^^^^^^
		                  M^
		^^^^^^^^^^^^^^^^^^^^
		^^       ^^^^^^     
		^   ^^^   ^^^    ^^^
		   ^^ ^^   ^^^  ^^^ 
		^^^    ^^  ^^^  ^   
		^^  ^^ ^^   ^^^^^  ^
		^  ^^^  ^^   ^^^  ^^"
	);

	final verticalOutsideTraversal = parseInput(
		"17 11
		^^^^ ^ ^^^^
		^^^^B^ ^   
		^^^^^^ ^  ^
		  ^^^^ ^  ^
		^  ^^^ ^ ^^
		^^  ^^ ^ ^^
		^^  ^^ ^  ^
		^^  ^^ ^  ^
		^^  ^^ ^^ ^
		^^  ^^ ^^ ^
		^^  ^^ ^  ^
		^^  ^^ ^  ^
		^^  ^^ ^^ ^
		^   ^^ ^^ ^
		   ^^^ ^^ ^
		^^^^M^ ^^  
		^^^^ ^ ^^^^"
	);

	final completeTraversal = parseInput(
		"11 20
		 ^^^^^^^^^^^^^^^^^^ 
		^B                 ^
		 ^^^^^^^^^^^^^^^^^ ^
		^                  ^
		^ ^^^^^^^^^^^^^^^^^ 
		^                   
		 ^^^^^^^^^^^^^^^^^ ^
		^                  ^
		^ ^^^^^^^^^^^^^^^^^ 
		^                  ^
		 ^^^^^^^^^^^^^^^^^M^"
	);
}