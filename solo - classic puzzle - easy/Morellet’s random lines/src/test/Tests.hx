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
			
			it( "One line", {
				final input = oneLine;
				Main.process( input.pointA, input.pointB, input.lines ).should.be( "YES" );
			});
			
			it( "Two lines", {
				final input = twoLines;
				Main.process( input.pointA, input.pointB, input.lines ).should.be( "YES" );
			});
			
			it( "On a line", {
				final input = onALine;
				Main.process( input.pointA, input.pointB, input.lines ).should.be( "ON A LINE" );
			});
			
			it( "Many lines", {
				final input = manyLines;
				Main.process( input.pointA, input.pointB, input.lines ).should.be( "NO" );
			});
			
			it( "Same line", {
				final input = sameLine;
				Main.process( input.pointA, input.pointB, input.lines ).should.be( "YES" );
			});
			
			it( "Lots of lines", {
				final input = lotsOfLines;
				Main.process( input.pointA, input.pointB, input.lines ).should.be( "ON A LINE" );
			});
			
			it( "Lots of lines 2", {
				final input = lotsOfLines2;
				Main.process( input.pointA, input.pointB, input.lines ).should.be( "NO" );
			});
			
			it( "Mind the sign", {
				final input = mindTheSign;
				Main.process( input.pointA, input.pointB, input.lines ).should.be( "NO" );
			});
			
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final inputs = lines[0].split(' ');
		final xA = parseInt( inputs[0] );
		final yA = parseInt( inputs[1] );
		final xB = parseInt( inputs[2] );
		final yB = parseInt( inputs[3] );
		
		final pointA:Point = { x: xA, y: yA };
		final pointB:Point = { x: xB, y: yB };
		
		final n = parseInt( lines[1] );
		final lines = [for( i in 0...n ) {
			var inputs = lines[2 + i].split(' ');
			final a = parseFloat( inputs[0] );
			final b = parseFloat( inputs[1] );
			final c = parseFloat( inputs[2] );
			[a, b, c];
		}];
		return { pointA: pointA, pointB: pointB, lines: lines };
	}

	final oneLine = parseInput(
	"1 1 0 0
	1
	1 2 3" );
	
	final twoLines = parseInput(
	"3 2 -2 -2
	2
	1 2 3
	1 1 1" );

	final onALine = parseInput(
	"-1 0 -2 0
	1
	1 1 1" );

	final manyLines = parseInput(
	"-5 3 4 2
	10
	-7 6 -9
	-6 10 -7
	-3 -4 -2
	-3 1 0
	-3 8 3
	1 -5 -4
	3 -8 10
	3 9 -5
	8 3 -2
	10 4 -3" );

	final sameLine = parseInput(
	"3 2 -3 1
	2
	1 2 3
	2 4 6" );

	final lotsOfLines = parseInput(
	"7 -7 5 -5
	100
	-3 5 3
	9 -2 10
	-8 -5 3
	7 10 -5
	2 -4 1
	-6 9 5
	-3 6 9
	2 -6 -6
	-4 -2 -5
	0 1 3
	5 7 10
	8 2 -6
	3 4 1
	-10 5 -2
	1 6 -9
	3 0 3
	-6 -6 -1
	8 7 6
	-9 -9 9
	-7 7 -6
	9 -10 5
	0 5 2
	-4 -1 7
	2 2 -5
	-6 -4 4
	0 9 -7
	2 -7 10
	10 -6 -8
	-5 -9 4
	7 -6 0
	-5 -2 5
	-4 -9 -9
	4 -10 1
	7 7 10
	7 -6 1
	1 4 2
	-9 -4 3
	-1 0 -1
	-5 6 -10
	-10 -2 6
	-3 10 9
	6 5 5
	-2 -7 -4
	-6 3 1
	9 -3 1
	8 -6 2
	10 -8 5
	7 6 5
	-10 -2 -8
	9 -7 -7
	7 -1 -6
	9 10 -2
	-1 6 -6
	-5 -10 -10
	0 3 -7
	-9 8 -9
	7 -8 -4
	-7 5 -3
	9 -2 10
	-10 -9 2
	4 -3 -7
	2 10 8
	9 5 4
	9 0 9
	-10 10 0
	8 8 10
	0 -5 -1
	5 -1 2
	5 3 1
	3 10 8
	10 6 -4
	8 -9 0
	6 2 5
	9 4 6
	-8 7 -8
	5 -3 -3
	-1 -6 -9
	-9 -1 5
	-1 -3 -8
	-4 -8 -2
	5 8 10
	5 10 -9
	10 4 -9
	-7 -7 -2
	7 7 -4
	10 7 7
	7 4 -1
	-9 7 5
	8 0 -4
	0 -10 3
	7 6 4
	2 8 -9
	-5 3 -3
	10 -4 -1
	1 10 -4
	-8 -9 7
	5 -8 -7
	-8 4 -2
	-5 0 5
	7 -3 -4" );

	final lotsOfLines2 = parseInput(
	"-10 201 102 86
	100
	-3 5 3
	9 -2 10
	-8 -5 3
	7 10 -5
	2 -4 1
	-6 9 5
	-3 6 9
	2 -6 -6
	-4 -2 -5
	0 1 3
	5 7 10
	8 2 -6
	3 4 1
	-10 5 -2
	1 6 -9
	3 0 3
	-6 -6 -1
	8 7 6
	-9 -9 9
	-7 7 -6
	9 -10 5
	0 5 2
	-4 -1 7
	2 2 -5
	-6 -4 4
	0 9 -7
	2 -7 10
	10 -6 -8
	-5 -9 4
	7 -6 0
	-5 -2 5
	-4 -9 -9
	4 -10 1
	7 7 10
	7 -6 1
	1 4 2
	-9 -4 3
	-1 0 -1
	-5 6 -10
	-10 -2 6
	-3 10 9
	6 5 5
	-2 -7 -4
	-6 3 1
	9 -3 1
	8 -6 2
	10 -8 5
	7 6 5
	-10 -2 -8
	9 -7 -7
	7 -1 -6
	9 10 -2
	-1 6 -6
	-5 -10 -10
	0 3 -7
	-9 8 -9
	7 -8 -4
	-7 5 -3
	9 -2 10
	-10 -9 2
	4 -3 -7
	2 10 8
	9 5 4
	9 0 9
	-10 10 0
	8 8 10
	0 -5 -1
	5 -1 2
	5 3 1
	3 10 8
	10 6 -4
	8 -9 0
	6 2 5
	9 4 6
	-8 7 -8
	5 -3 -3
	-1 -6 -9
	-9 -1 5
	-1 -3 -8
	-4 -8 -2
	5 8 10
	5 10 -9
	10 4 -9
	-7 -7 -2
	7 7 -4
	10 7 7
	7 4 -1
	-9 7 5
	8 0 -4
	0 -10 3
	7 6 4
	2 8 -9
	-5 3 -3
	10 -4 -1
	1 10 -4
	-8 -9 7
	5 -8 -7
	-8 4 -2
	-5 0 5
	7 -3 -4" );

	final mindTheSign = parseInput(
	"0 0 1 1
	2
	1 1 -1
	-1 -1 1" );

}

