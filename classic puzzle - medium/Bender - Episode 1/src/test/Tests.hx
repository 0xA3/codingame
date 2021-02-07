package test;

import haxe.Int64;
import Main;
import Std.parseInt;
import Std.parseFloat;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Simple moves", { Main.process( simpleMoves ).should.be( simpleMovesResult ); });
			it( "Obstacles", { Main.process( obstacles ).should.be( obstaclesResult ); });
			it( "Priorities", { Main.process( priorities ).should.be( prioritiesResult ); });
			it( "Straight line", { Main.process( straightLine ).should.be( straightLineResult ); });
			it( "Path modifier", { Main.process( pathModifier ).should.be( pathModifierResult ); });
			it( "Breaker mode", { Main.process( breakerMode ).should.be( breakerModeResult ); });
			it( "Inverter", { Main.process( inverter ).should.be( inverterResult ); });
			it( "Teleport", { Main.process( teleport ).should.be( teleportResult ); });
			it( "Broken wall?", { Main.process( brokenWall ).should.be( brokenWallResult ); });
			it( "All together", { Main.process( allTogether ).should.be( allTogetherResult ); });
			it( "LOOP", { Main.process( loop ).should.be( loopResult ); });
			it( "Multiple loops?", { Main.process( multipleLoops ).should.be( multipleLoopsResult ); });
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		var inputs = lines[0].split(' ');
		final l = parseInt( inputs[0] );
		final c = parseInt( inputs[1] );
		final rows = [for( i in 0...l ) lines[1 + i]];

		return rows;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final simpleMoves = parseInput(
		"5 5
		#####
		#@  #
		#   #
		#  $#
		#####" );
	
	final simpleMovesResult = parseResult(
		"SOUTH
		SOUTH
		EAST
		EAST" );
	
	final obstacles = parseInput(
		"8 8
		########
		# @    #
		#     X#
		# XXX  #
		#   XX #
		#   XX #
		#     $#
		########" );
	
	final obstaclesResult = parseResult(
		"SOUTH
		EAST
		EAST
		EAST
		SOUTH
		EAST
		SOUTH
		SOUTH
		SOUTH" );
	
	final priorities = parseInput(
		"8 8
		########
		#     $#
		#      #
		#      #
		#  @   #
		#      #
		#      #
		########" );
	
	final prioritiesResult = parseResult(
		"SOUTH
		SOUTH
		EAST
		EAST
		EAST
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH" );
	
	final straightLine = parseInput(
		"8 8
		########
		#      #
		# @    #
		# XX   #
		#  XX  #
		#   XX #
		#     $#
		########" );
	
	final straightLineResult = parseResult(
		"EAST
		EAST
		EAST
		EAST
		SOUTH
		SOUTH
		SOUTH
		SOUTH" );
	
	final pathModifier = parseInput(
		"10 10
		##########
		#        #
		#  S   W #
		#        #
		#  $     #
		#        #
		#@       #
		#        #
		#E     N #
		##########" );
	
	final pathModifierResult = parseResult(
		"SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		WEST
		WEST
		WEST
		WEST
		SOUTH
		SOUTH" );
	
	final breakerMode = parseInput(
		"10 10
		##########
		# @      #
		# B      #
		#XXX     #
		# B      #
		#    BXX$#
		#XXXXXXXX#
		#        #
		#        #
		##########" );
	
	final breakerModeResult = parseResult(
		"SOUTH
		SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST" );
	
	final inverter = parseInput(
		"10 10
		##########
		#    I   #
		#        #
		#       $#
		#       @#
		#        #
		#       I#
		#        #
		#        #
		##########" );
	
	final inverterResult = parseResult(
		"SOUTH
		SOUTH
		SOUTH
		SOUTH
		WEST
		WEST
		WEST
		WEST
		WEST
		WEST
		WEST
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		SOUTH
		SOUTH" );
	
	final teleport = parseInput(
		"10 10
		##########
		#    T   #
		#        #
		#        #
		#        #
		#@       #
		#        #
		#        #
		#    T  $#
		##########" );
	
	final teleportResult = parseResult(
		"SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH" );
	
	final brokenWall = parseInput(
		"10 10
		##########
		#        #
		#  @     #
		#  B     #
		#  S   W #
		# XXX    #
		#  B   N #
		# XXXXXXX#
		#       $#
		##########" );
	
	final brokenWallResult = parseResult(
		"SOUTH
		SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST
		NORTH
		NORTH
		WEST
		WEST
		WEST
		WEST
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST
		EAST" );
	
	final allTogether = parseInput(
		"15 15
		###############
		#      IXXXXX #
		#  @          #
		#             #
		#             #
		#  I          #
		#  B          #
		#  B   S     W#
		#  B   T      #
		#             #
		#         T   #
		#         B   #
		#            $#
		#        XXXX #
		###############" );
	
	final allTogetherResult = parseResult(
		"SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		WEST
		WEST
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		EAST
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		WEST
		WEST
		WEST
		WEST
		WEST
		WEST
		SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST" );
	
	final loop = parseInput(
		"15 15
		###############
		#      IXXXXX #
		#  @          #
		#E S          #
		#             #
		#  I          #
		#  B          #
		#  B   S     W#
		#  B   T      #
		#             #
		#         T   #
		#         B   #
		#N          W$#
		#        XXXX #
		###############" );
	
	final loopResult = parseResult(
		"LOOP" );
	
	final multipleLoops = parseInput(
		"30 15
		###############
		#  #@#I  T$#  #
		#  #    IB #  #
		#  #     W #  #
		#  #      ##  #
		#  #B XBN# #  #
		#  ##      #  #
		#  #       #  #
		#  #     W #  #
		#  #      ##  #
		#  #B XBN# #  #
		#  ##      #  #
		#  #       #  #
		#  #     W #  #
		#  #      ##  #
		#  #B XBN# #  #
		#  ##      #  #
		#  #       #  #
		#  #       #  #
		#  #      ##  #
		#  #  XBIT #  #
		#  #########  #
		#             #
		# ##### ##### #
		# #     #     #
		# #     #  ## #
		# #     #   # #
		# ##### ##### #
		#             #
		###############" );
	
	final multipleLoopsResult = parseResult(
		"SOUTH
		SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST
		NORTH
		NORTH
		NORTH
		NORTH
		WEST
		WEST
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		NORTH
		WEST
		WEST
		WEST
		WEST
		WEST
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		WEST
		WEST
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		NORTH
		WEST
		WEST
		WEST
		WEST
		WEST
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		NORTH
		WEST
		WEST
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		SOUTH
		SOUTH
		SOUTH
		WEST
		WEST
		WEST
		WEST
		WEST
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST
		NORTH
		NORTH
		NORTH
		NORTH
		WEST
		WEST
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		SOUTH
		EAST
		EAST
		EAST
		EAST" );
	
}

