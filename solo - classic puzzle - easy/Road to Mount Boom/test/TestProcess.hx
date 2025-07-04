package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Basic North", Main.process( basicNorth ).should.be( "3 leagues" ));
			it( "Basic East", Main.process( basicEast ).should.be( "7 leagues" ));
			it( "Basic South", Main.process( basicSouth ).should.be( "2 leagues" ));
			it( "Basic West", Main.process( basicWest ).should.be( "6 leagues" ));
			it( "Basic North-East", Main.process( basicNorthEast ).should.be( "4 leagues" ));
			it( "Basic South-East", Main.process( basicSouthEast ).should.be( "2 leagues" ));
			it( "Basic South-West", Main.process( basicSouthWest ).should.be( "3 leagues" ));
			it( "Basic North-West", Main.process( basicNorthWest ).should.be( "6 leagues" ));
			it( "North and NE (Open)", Main.process( northAndNeOpen ).should.be( "5 leagues" ));
			it( "East and SE (Open)", Main.process( eastAndSeOpen ).should.be( "13 leagues" ));
			it( "South and SW (Open)", Main.process( southAndSwOpen ).should.be( "7 leagues" ));
			it( "West and NW (Open)", Main.process( westAndNwOpen ).should.be( "10 leagues" ));
			it( "Simple Horizontal Journey", Main.process( simpleHorizontalJourney ).should.be( "1 league" ));
			it( "Simple Vertical Journey", Main.process( simpleVerticalJourney ).should.be( "1 league" ));
			it( "Simple Diagonal Journey", Main.process( simpleDiagonalJourney ).should.be( "1 league" ));
			it( "Simple Diagonal Journey 2", Main.process( simpleDiagonalJourney_2 ).should.be( "1 league" ));
			it( "Around the World 1", Main.process( aroundTheWorld_1 ).should.be( "18 leagues" ));
			it( "Around the World 2", Main.process( aroundTheWorld_2 ).should.be( "18 leagues" ));
			it( "Maze 1", Main.process( maze_1 ).should.be( "34 leagues" ));
			it( "Maze 2", Main.process( maze_2 ).should.be( "24 leagues" ));
			it( "Large Maze", Main.process( largeMaze ).should.be( "157 leagues" ));
			it( "Simple Outside Traversal", Main.process( simpleOutsideTraversal ).should.be( "23 leagues" ));
			it( "Horizontal Outside Traversal", Main.process( horizontalOutsideTraversal ).should.be( "43 leagues" ));
			it( "Vertical Outside Traversal", Main.process( verticalOutsideTraversal ).should.be( "22 leagues" ));
			it( "Complete Traversal", Main.process( completeTraversal ).should.be( "59 leagues" ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		final inputs = readline().split(' ');
		final h = parseInt(inputs[0]);
		final w = parseInt(inputs[1]);
		final rows = [for ( i in 0...h ) readline()];

		return rows;
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

	final basicSouthWest = parseInput(
		"6 12
		^^^^^^^    
		^^^^^     B
		^^^^  ^^^^^
		^^^  ^^^^^^
		^^  ^^^^^^^
		M  ^^^^^^^^"
	);

	final westAndNwOpen = parseInput(
		""
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