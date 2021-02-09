package test;

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
			it( "Well", {
				final input = well;
				final tunnel = new Tunnel( input.lines, input.exit );
			});	

		});
	}

	static function parseInput( input:String ) {
		final inputLines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		var inputs = inputLines[0].split(' ');
		final w = parseInt( inputs[0] ); // number of columns.
		final h = parseInt( inputs[1] ); // number of rows.
		final lines = [for( i in 0...h ) inputLines[i + 1].split(" ").map( a -> parseInt( a ))]; // represents a line in the grid and contains W integers. Each integer represents one room of a given type.
		final exit = parseInt( inputLines[1 + h] ); // the coordinate along the X axis of the exit (not useful for this first mission, but must be read).
		final start = inputLines[1 + h + 1];
		
		return { lines: lines, exit: exit, start: start };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final well = parseInput(
		"3 3
		0 3 0
		0 3 0
		0 3 0
		1
		1 0 TOP" );
	
	final wellResult = parseResult(
		"1 2" );
	
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

