package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", Main.process( test1 ).should.be( test1Result ));
			it( "Test 2", Main.process( test2 ).should.be( test2Result ));
			it( "Test 3", Main.process( test3 ).should.be( test3Result ));
			it( "Test 4", Main.process( test4 ).should.be( test4Result ));
			it( "Test 5", Main.process( test5 ).should.be( test5Result ));
			it( "Test 6", Main.process( test6 ).should.be( test6Result ));
			it( "Test 7", Main.process( test7 ).should.be( test7Result ));
			it( "Test 8", Main.process( test8 ).should.be( test8Result ));
			it( "Test 9", Main.process( test9 ).should.be( test9Result ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.slice( 1 );
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final test1 = parseInput(
		"2
		rt 45
		fd 5"
	);

	final test1Result = parseResult(
		"    #
		   #
		  #
		 #
		#"
	);

	final test2 = parseInput(
		"1
		RP 4 [fd 5;rt 90]"
	);

	final test2Result = parseResult(
		"######
		#    #
		#    #
		#    #
		#    #
		######"
	);

	final test3 = parseInput(
		"1
		setpc +-;RP 2 [Rp 2 [fd 5;rt 90]]"
	);

	final test3Result = parseResult(
		"-+-+-+
		+    -
		-    +
		+    -
		-    +
		+-+-+-"
	);
	
	final test4 = parseInput(
		"1
		setpc #;rt 90;fd 5;lt 45;fd 5;rt 90;fd 5;lt 45;fd 5"
	);

	final test4Result = parseResult(
		"          #
		         # #
		        #   #
		       #     #
		      #       #
		######         #####"
	);

	final test5 = parseInput(
		"1
		setpc HelloWorld!;rp 2 [rt 45;fd 5;pu;fd 1;pd;fd 6;rt 45]"
	);

	final test5Result = parseResult(
		"            H
		           ! e
		          d   l
		         l     l
		        r       o
		       o
		      W           W
		                   o
		    o               r
		   l                 l
		  l                   d
		 e                     !
		H"
	);

	final test6 = parseInput(
		"1
		RP 2 [setpc Hello];rt 90;fd 5"
	);

	final test6Result = parseResult(
		"Hello"
	);

	final test7 = parseInput(
		"1
		RP 2 [RP 2 [fd 5;rt 90;setpc +];RP 2 [fd 5;rt 90;setpc *]]"
	);

	final test7Result = parseResult(
		"++++++
		*    +
		*    +
		*    +
		*    +
		******"
	);

	final test8 = parseInput(
		"1
		rt 90;RP 4 [fd 3;lt 90;rp 2 [fd 3;rt 90];fd 3;lt 90;fd 3;rt 90]"
	);

	final test8Result = parseResult(
		"      ####
		      #  #
		      #  #
		   ####  ####
		   #        #
		   #        #
		####        ####
		#              #
		#              #
		####        ####
		   #        #
		   #        #
		   ####  ####
		      #  #
		      #  #
		      ####"
	);
	
	final test9 = parseInput(
		"2
		cs .
		rp 2 [rt 45];RP 4 [fd 3;rp 2 [lt 45];rp 2 [fd 3;rp 2 [rt 45]];fd 3;rp 2 [lt 45];fd 3;rp 2 [lt 45]]"
	);

	final test9Result = parseResult(
		"####..####
		#..#..#..#
		#..#..#..#
		##########
		...#..#...
		...#..#...
		##########
		#..#..#..#
		#..#..#..#
		####..####"
	);
}
