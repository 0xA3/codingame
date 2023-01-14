package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Simple", {
				final ip = simple;
				Main.process( ip.x, ip.y, ip.w, ip.h, ip.lines ).should.be( 2 );
			});
			it( "Mrepeate rotate", {
				final ip = mrepeateRotate;
				Main.process( ip.x, ip.y, ip.w, ip.h, ip.lines ).should.be( 8 );
			});
			it( "Overflow", {
				final ip = overflow;
				Main.process( ip.x, ip.y, ip.w, ip.h, ip.lines ).should.be( 3 );
			});
			it( "Repeat", {
				final ip = repeat;
				Main.process( ip.x, ip.y, ip.w, ip.h, ip.lines ).should.be( 18 );
			});
		});

	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final w = parseInt( inputs[0] );
		final h = parseInt( inputs[1] );
		var inputs = lines[1].split(' ');
		final x = parseInt( inputs[0] );
		final y = parseInt( inputs[1] );
		final lines = [for( i in 0...h ) lines[i + 2].split( '' )];
			
		return { x: x, y: y, w: w, h: h, lines: lines }
	}

	static function parseResult( input:String ) {
		return input.split( "\n" ).map( line -> line.trim()).join( "\n" );
	}

	static final simple = parseInput(
	"2 1
	0 0
	^v" );

	static final mrepeateRotate = parseInput(
	"3 3
	2 1
	>v>
	><v
	^^<" );

	static final overflow = parseInput(
	"5 5
	2 2
	<><><
	<><><
	<><><
	<><><
	<><><" );

	static final repeat = parseInput(
	"6 5
	2 2
	<><><>
	<>^>>>
	^^<^<>
	<><><>
	<vvvvv" );
}

