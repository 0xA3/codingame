package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "2 ply", {
				final ip = twoPly;
				Main.process( ip.order, ip.side ).should.be( 4 );
			});
			it( "4 ply", {
				final ip = fourPly;
				Main.process( ip.order, ip.side ).should.be( 12 );
			});
			it( "6 ply", {
				final ip = sixPly;
				Main.process( ip.order, ip.side ).should.be( 26 );
			});
			it( "8 ply easy", {
				final ip = eightPlyEasy;
				Main.process( ip.order, ip.side ).should.be( 1 );
			});
			it( "8 ply", {
				final ip = eightPly;
				Main.process( ip.order, ip.side ).should.be( 44 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		return { order: lines[0], side: lines[1] };
	}
	
	final twoPly = parseInput(
		"UL
		D" );

	final fourPly = parseInput(
		"DRUL
		D" );

	final sixPly = parseInput(
		"DRRULD
		U" );

	final eightPlyEasy = parseInput(
		"DRULUDDR
		R" );

	final eightPly = parseInput(
		"URDDLRLU
		R" );
}
