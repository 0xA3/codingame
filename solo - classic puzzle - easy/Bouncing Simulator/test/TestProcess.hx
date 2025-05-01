package test;

import Std.parseFloat;
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
				Main.process( ip.w, ip.h, ip.n ).should.be( test1Result );
			});
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.w, ip.h, ip.n ).should.be( test2Result );
			});
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.w, ip.h, ip.n ).should.be( test3Result );
			});
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.w, ip.h, ip.n ).should.be( test4Result );
			});
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.w, ip.h, ip.n ).should.be( test5Result );
			});
			it( "Test 6", {
				final ip = test6;
				Main.process( ip.w, ip.h, ip.n ).should.be( test6Result );
			});
			it( "Test 7", {
				final ip = test7;
				Main.process( ip.w, ip.h, ip.n ).should.be( test7Result );
			});
			it( "Test 8", {
				final ip = test8;
				Main.process( ip.w, ip.h, ip.n ).should.be( test8Result );
			});
			it( "Test 9", {
				final ip = test9;
				Main.process( ip.w, ip.h, ip.n ).should.be( test9Result );
			});
			it( "Test 10", {
				final ip = test10;
				Main.process( ip.w, ip.h, ip.n ).should.be( test10Result );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final w = parseInt( readline() );
		final h = parseInt( readline() );
		final n = parseInt( readline() );
					
		return { w: w, h: h, n: n }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"7
		3
		2"
	);

	final test1Result = parseResult(
		"#########
		#1   1  #
		# 1 1   #
		#  1    #
		#########"
	);

	final test2 = parseInput(
		"4
		6
		3"
	);

	final test2Result = parseResult(
		"######
		#1   #
		# 1  #
		#  1 #
		#   1#
		#1 1 #
		# 1  #
		######"
	);

	final test3 = parseInput(
		"4
		3
		4"
	);

	final test3Result = parseResult(
		"######
		#1 1 #
		# 2 1#
		#1 1 #
		######"
	);

	final test4 = parseInput(
		"10
		7
		4"
	);

	final test4Result = parseResult(
		"############
		#1     1   #
		# 1   1 1  #
		#  1 1   1 #
		#   2     1#
		#  1 1   1 #
		# 1   1 1  #
		#1     1   #
		############"
	);

	final test5 = parseInput(
		"30
		25
		40"
	);

	final test5Result = parseResult(
		"################################
		#1 1   1 1 1 1   1 1 1 1   1 1 #
		# 2 1 1 1 2 2 1 1 2 2 2 1 1 2 1#
		#1 1 2 1 1 2 1 2 1 2 2 1 2 1 2 #
		# 1 2 2 1 1 1 2 2 1 2 1 2 2 1 1#
		#  2 2 2 1   2 2 2 1 1 2 2 2 1 #
		# 1 2 2 2   1 2 2 2   2 2 2 2  #
		#1 1 2 2 1 1 1 2 2 1 1 2 2 2 1 #
		# 2 1 2 1 2 1 1 2 1 2 1 2 2 1 1#
		#1 2 1 1 2 2 1 1 1 2 2 1 2 1 2 #
		# 2 2   2 2 2 1   2 2 2 1 1 2 1#
		#1 2 1 1 2 2 2   1 2 2 2   2 2 #
		# 2 1 2 1 2 2 1 1 1 2 2 1 1 2 1#
		#1 1 2 2 1 2 1 2 1 1 2 1 2 1 2 #
		# 1 2 2 2 1 1 2 2 1 1 1 2 2 1 1#
		#  2 2 2 2   2 2 2 1   2 2 2 1 #
		# 1 2 2 2 1 1 2 2 2   1 2 2 2  #
		#1 1 2 2 1 2 1 2 2 1 1 1 2 2 1 #
		# 2 1 2 1 2 2 1 2 1 2 1 1 2 1 1#
		#1 2 1 1 2 2 2 1 1 2 2 1 1 1 2 #
		# 2 2   2 2 2 2   2 2 2 1   2 1#
		#1 2 1 1 2 2 2 1 1 2 2 2   1 2 #
		# 2 1 2 1 2 2 1 2 1 2 2 1 1 1 1#
		#1 1 2 2 1 2 1 2 2 1 2 1 2 1 1 #
		# 1 2 2 2 1 1 2 2 2 1 1 2 2 1  #
		#  1 1 1 1   1 1 1 1   1 1 1   #
		################################"
	);

	final test6 = parseInput(
		"22
	7
	10"
	);

	final test6Result = parseResult(
		"########################
		#1     2     1     1   #
		# 1   2 2   1 1   1 1  #
		#  1 2   2 1   1 1   1 #
		#   3     3     2     1#
		#  2 1   1 2   1 1   1 #
		# 2   1 1   2 1   1 1  #
		#1     1     2     1   #
		########################"
	);

	final test7 = parseInput(
		"25
		11
		50"
	);

	final test7Result = parseResult(
		"###########################
		#2   4   3   3   3   3   2#
		# 3 3 4 3 3 3 3 3 3 3 3 4 #
		#  6   7   6   6   6   7  #
		# 3 3 3 4 3 3 3 3 3 3 4 3 #
		#3   6   7   6   6   7   3#
		# 3 3 3 3 4 3 3 3 3 4 3 3 #
		#  6   6   7   6   7   6  #
		# 3 3 3 3 3 4 3 3 4 3 3 3 #
		#3   6   6   7   7   6   3#
		# 3 3 3 3 3 3 4 4 3 3 3 3 #
		#  3   3   3   4   3   3  #
		###########################"
	);

	final test8 = parseInput(
		"3
		3
		4"
	);

	final test8Result = parseResult(
		"#####
		#3  #
		# 4 #
		#  2#
		#####"
	);

	final test9 = parseInput(
		"1
		9
		3"
	);

	final test9Result = parseResult(
		"###
		#1#
		#1#
		#1#
		# #
		# #
		# #
		# #
		# #
		# #
		###"
	);

	final test10 = parseInput(
		"11
		1
		14"
	);

	final test10Result = parseResult(
		"#############
		#11111112221#
		#############"
	);
}
