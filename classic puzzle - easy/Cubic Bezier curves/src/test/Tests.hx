package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Simple with low resolution", {
				final ip = simpleWithLowResolution;
				Main.process( ip.width, ip.height, ip.steps, ip.ax, ip.ay, ip.bx, ip.by, ip.cx, ip.cy, ip.dx, ip.dy ).should.be( simpleWithLowResolutionResult );
			} );
			it( "Inverted control points", {
				final ip = invertedControlPoints;
				Main.process( ip.width, ip.height, ip.steps, ip.ax, ip.ay, ip.bx, ip.by, ip.cx, ip.cy, ip.dx, ip.dy ).should.be( invertedControlPointsResult );
			} );
			it( "Close loop", {
				final ip = closeLoop;
				Main.process( ip.width, ip.height, ip.steps, ip.ax, ip.ay, ip.bx, ip.by, ip.cx, ip.cy, ip.dx, ip.dy ).should.be( closeLoopResult );
			} );
			it( "Only extremes", {
				final ip = onlyExtremes;
				Main.process( ip.width, ip.height, ip.steps, ip.ax, ip.ay, ip.bx, ip.by, ip.cx, ip.cy, ip.dx, ip.dy ).should.be( onlyExtremesResult );
			} );
			it( "High resolution", {
				final ip = highResolution;
				Main.process( ip.width, ip.height, ip.steps, ip.ax, ip.ay, ip.bx, ip.by, ip.cx, ip.cy, ip.dx, ip.dy ).should.be( highResolutionResult );
			} );
			it( "High resolution 2", {
				final ip = highResolution2;
				Main.process( ip.width, ip.height, ip.steps, ip.ax, ip.ay, ip.bx, ip.by, ip.cx, ip.cy, ip.dx, ip.dy ).should.be( highResolution2Result );
			} );
		} );
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final width = parseInt( inputs[0] );
		final height = parseInt( inputs[1] );
		final steps = parseInt( lines[1] );
		final inputs = lines[2].split(' ');
		final ax = parseInt( inputs[0] );
		final ay = parseInt( inputs[1] );
		final inputs = lines[3].split(' ');
		final bx = parseInt( inputs[0] );
		final by = parseInt( inputs[1] );
		final inputs = lines[4].split(' ');
		final cx = parseInt( inputs[0] );
		final cy = parseInt( inputs[1] );
		final inputs = lines[5].split(' ');
		final dx = parseInt( inputs[0] );
		final dy = parseInt( inputs[1] );
	
		return { width: width, height: height, steps: steps, ax: ax, ay: ay, bx: bx, by: by, cx: cx, cy: cy, dx: dx, dy: dy }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final simpleWithLowResolution = parseInput(
	"10 10
	10
	0 0
	0 9
	9 9
	9 0" );

	static final simpleWithLowResolutionResult = parseResult(
	".
	.
	.   ##
	. #    #
	.#      #
	.
	#        #
	.
	.
	#        #" );

	static final invertedControlPoints = parseInput(
	"20 20
	25
	0 0
	19 19
	0 19
	19 0" );

	static final invertedControlPointsResult = parseResult(
	".
	.
	.
	.
	.
	.        ##
	.        ##
	.        ##
	.       #  #
	.
	.       #  #
	.      #    #
	.
	.    #        #
	.
	.   #          #
	.
	. #              #
	.
	#                  #" );

	static final closeLoop = parseInput(
	"30 30
	20
	5 2
	3 29
	29 15
	5 2" );

	static final closeLoopResult = parseResult(
	".
	.
	.
	.
	.
	.
	.
	.
	.
	.
	.
	.
	.        ## ###
	.       #      #
	.              #
	.      #
	.              #
	.     #        #
	.
	.             #
	.    #
	.            #
	.
	.    #     #
	.
	.       #
	.
	.    #
	.
	." );

	static final onlyExtremes = parseInput(
	"15 15
	2
	12 5
	3 14
	1 2
	3 9" );

	static final onlyExtremesResult = parseResult(
	".
	.
	.
	.
	.
	.  #
	.
	.
	.
	.           #
	.
	.
	.
	.
	." );

	static final highResolution = parseInput(
	"50 50
	100
	10 47
	2 1
	45 3
	1 35" );

	static final highResolutionResult = parseResult(
	".
	.
	.         #
	.         #
	.
	.         #
	.        #
	.        #
	.
	.        #
	.        #
	.        #
	.        #
	.        #
	.#       #
	. #
	.   #    #
	.    #   #
	.     #  #
	.      ###
	.        #
	.         #
	.         ##
	.         # #
	.         #  #
	.         #   #
	.          #   #
	.          #    #
	.          #     #
	.           #     #
	.           #     ##
	.            #     #
	.            ##     #
	.             #     #
	.              #     #
	.               #    #
	.               ##   #
	.                 ####
	.
	.
	.
	.
	.
	.
	.
	.
	.
	.
	.
	." );

	static final highResolution2 = parseInput(
	"50 40
	100
	0 38
	30 26
	1 2
	49 0" );

	static final highResolution2Result = parseResult(
	".
	##
	. ##
	.  ###
	.     #
	.      ##
	.        #
	.         #
	.         ##
	.          ##
	.           ##
	.            #
	.             #
	.             #
	.              #
	.              #
	.              ##
	.               #
	.               #
	.               #
	.                #
	.                #
	.                #
	.                ##
	.                 #
	.                 #
	.                  #
	.                  #
	.                  ##
	.                   #
	.                    #
	.                    ##
	.                     ##
	.                       ##
	.                        ##
	.                          ##
	.                            ###
	.                               ####
	.                                   ######
	.                                         # ### ##" );
}
