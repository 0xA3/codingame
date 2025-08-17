package test;

import CodinGame.printErr;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.g, ip.grid ).should.be( test1Result );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.g, ip.grid ).should.be( test2Result );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.g, ip.grid ).should.be( test3Result );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.g, ip.grid ).should.be( test4Result );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.g, ip.grid ).should.be( test5Result );
			});
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.g, ip.grid ).should.be( test6Result );
			});
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.g, ip.grid ).should.be( test7Result );
			});
			it( "Test 8", {
				final ip = test8;
				Main.process( ip.g, ip.grid ).should.be( test8Result );
			});
			it( "Test 9", {
				final ip = test9;
				Main.process( ip.g, ip.grid ).should.be( test9Result );
			});
			it( "Test 10", {
				final ip = test10;
				Main.process( ip.g, ip.grid ).should.be( test10Result );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
	final inputs = readline().split( " " );
	final n = parseInt( inputs[0] );
	final g = parseInt( inputs[1] );
	final grid = [for( _ in 0...n ) readline().split( "" )];
		
		return  { g: g, grid: grid }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"3 3
		X O
		XO 
		XOX"
	);
	
	final test1Result = parseResult(
		"| O
		|O 
		|OX
		The winner is X."
	);

	final test2 = parseInput(
		"5 4
		O XXX
		OX   
		 O   
		 XXXX
		  O O"
	);
	
	final test2Result = parseResult(
		"O XXX
		OX   
		 O   
		 ----
		  O O
		The winner is X."
	);

	final test3 = parseInput(
		"6 4
		OX X  
		XX OXX
		XXO XX
		  XOOX
		O  X O
		     O"
	);
	
	final test3Result = parseResult(
		"OX X  
		\\X OXX
		X\\O XX
		  \\OOX
		O  \\ O
		     O
		The winner is X."
	);

	final test4 = parseInput(
		"7 4
		O    XO
		XX   X 
		OXOOX X
		XO OX X
		XO XXX 
		  XX OO
		 X  O O"
	);
	
	final test4Result = parseResult(
		"O    XO
		XX   X 
		OXOOX X
		XO O/ X
		XO /XX 
		  /X OO
		 /  O O
		The winner is X."
	);

	final test5 = parseInput(
		"4 3
		OXOX
		OXOX
		XOXO
		    "
	);
	
	final test5Result = parseResult(
		"OXOX
		OXOX
		XOXO
		    
		The game isn't over yet!"
	);

	final test6 = parseInput(
		"5 3
		O    
		OX XX
		 XO  
		O OXO
		X O O"
	);
	
	final test6Result = parseResult(
		"O    
		OX XX
		 X|  
		O |XO
		X | O
		The winner is O."
	);

	final test7 = parseInput(
		"6 5
		O XOXX
		XX    
		  XO  
		 X O  
		 OOOOO
		 XOX  "
	);
	
	final test7Result = parseResult(
		"O XOXX
		XX    
		  XO  
		 X O  
		 -----
		 XOX  
		The winner is O."
	);

	final test8 = parseInput(
		"4 4
		OX  
		 O O
		OXO 
		X XO"
	);
	
	final test8Result = parseResult(
		"\\X  
		 \\ O
		OX\\ 
		X X\\
		The winner is O."
	);

	final test9 = parseInput(
		"12 4
		    X  X  X 
		   O       X
		XOO X  OXOO 
		X  O    XO  
		 O   XO OOX 
		  XO O OO  X
		X XO   OX   
		       X  O 
		         OO 
		X    XXX O  
		 X X       O
		   XO  XX   "
	);
	
	final test9Result = parseResult(
		"    X  X  X 
		   O       X
		XOO X  OXO/ 
		X  O    X/  
		 O   XO /OX 
		  XO O /O  X
		X XO   OX   
		       X  O 
		         OO 
		X    XXX O  
		 X X       O
		   XO  XX   
		The winner is O."
	);

	final test10 = parseInput(
		"11 10
		XOXOOOOOOXX
		XOOXOXOOOXO
		OOXOXOOXXXX
		XOXXXOOXXOX
		OOOXXXXOXOO
		XOOXOXOOXXX
		XOXOOXXOOOO
		OOXXXOOXOXO
		OXXXXOOXOOO
		XOOOXXXXXOX
		OXOOOOXOXOX"
	);
	
	final test10Result = parseResult(
		"XOXOOOOOOXX
		XOOXOXOOOXO
		OOXOXOOXXXX
		XOXXXOOXXOX
		OOOXXXXOXOO
		XOOXOXOOXXX
		XOXOOXXOOOO
		OOXXXOOXOXO
		OXXXXOOXOOO
		XOOOXXXXXOX
		OXOOOOXOXOX
		The game ended in a draw!"
	);
}