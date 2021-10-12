package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Small map", {
				final ip = smallMap;
				Main.process( ip.w, ip.h, ip.rows ).should.be( 10 );
			});
			it( "Bigger map", {
				final ip = biggerMap;
				Main.process( ip.w, ip.h, ip.rows ).should.be( 18 );
			});
			it( "I want to cry", {
				final ip = iWantToCry;
				Main.process( ip.w, ip.h, ip.rows ).should.be( 0 );
			});
			it( "Easy life", {
				final ip = easyLife;
				Main.process( ip.w, ip.h, ip.rows ).should.be( 135 );
			});
			it( "Am I going in circles ?", {
				final ip = amIGoingInCircles;
				Main.process( ip.w, ip.h, ip.rows ).should.be( 36 );
			});
			it( "That's a maze !", {
				final ip = thatsAMaze;
				Main.process( ip.w, ip.h, ip.rows ).should.be( 39 );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final h = parseInt( inputs[0] );
		final w = parseInt( inputs[1] );
		final rows = [for( i in 1...lines.length ) lines[i]];
		
		return { w: w, h: h, rows: rows };
	}
	final smallMap = parseInput(
		"3 3
		X##
		1 5
		3#4"
	);

	final biggerMap = parseInput(
		"7 12
		############
		#9 2 #4#4  #
		####1# ###1#
		#3 1 #3 2 1#
		###1######1#
		#3 1 1 1 1X#
		############"
	);

	final iWantToCry = parseInput(
		"7 12
		############
		#9   66   9#
		# ######## #
		# #1# X#1# #
		# ######## #
		#9   66   9#
		############"
	);

	final easyLife = parseInput(
		"3 56
		########################################################
		X 1 1 1 2 2 2 3 3 3 4 4 4 5 5 5 6 6 6 7 7 7 8 8 8 9 9 9#
		########################################################"
	);

	final amIGoingInCircles = parseInput(
		"5 5
		#####
		#123#
		#4X5#
		#678#
		#####"
	);

	final thatsAMaze = parseInput(
		"21 21
		#####################
		X       #5  #3  # #5#
		####### # # ### # #6#
		#7#   #   # #  9#   #
		# ### # ##### ##### #
		#52    3  # #7#   # #
		# ### ### # # # ### #
		#9#2  #    6  #     #
		###1# ###9####### ###
		#6#6#5  #     #    5#
		# ##### ### # ### ###
		# #   # # # # #   #2#
		#5### #3# ### ### # #
		#     #3# #     #   #
		### #7# # ##### ### #
		#3# #1 6#   # # # # #
		# # ### ### # # # # #
		# 2 # # #  5#    23 #
		### # # # ### ### # #
		#6  #   #4   4  #6#9#
		#####################"
	);

}

