package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Blown", {
				final np = blown;
				Main.process( np.c, np.d, np.cl ).should.be( "Fuse was blown." );
			});
			
			it( "Not blown", {
				final np = notBlown;
				Main.process( np.c, np.d, np.cl ).should.be( "Fuse was not blown.\nMaximal consumed current was 41 A." );
			});
			
			it( "Single device", {
				final np = singleDevice;
				Main.process( np.c, np.d, np.cl ).should.be( "Fuse was blown." );
			});
			
			it( "More devices", {
				final np = moreDevices;
				Main.process( np.c, np.d, np.cl ).should.be( "Fuse was not blown.\nMaximal consumed current was 49 A." );
			});
			
			it( "More clicks, more devices", {
				final np = moreClicksMoreDevices;
				Main.process( np.c, np.d, np.cl ).should.be( "Fuse was not blown.\nMaximal consumed current was 65 A." );
			});
			
			it( "Power hungry", {
				final np = powerHungry;
				Main.process( np.c, np.d, np.cl ).should.be( "Fuse was not blown.\nMaximal consumed current was 181 A." );
			});
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" ).map( line -> line.split(" ").map( s -> parseInt( s )));
		final c = lines[0][2];
		final d = lines[1];
		final cl = lines[2];
		return { c: c, d: d, cl: cl };
	}

	final blown = parseInput(
	"5 2 10
	11 6 11 10 10
	3 3" );
	
	final notBlown = parseInput(
	"5 8 82
	18 20 3 1 20
	2 4 3 3 5 4 2 3" );
	
	final singleDevice = parseInput(
	"1 10 1
	9
	1 1 1 1 1 1 1 1 1 1" );
	
	final moreDevices = parseInput(
	"6 24 71
	10 10 14 14 14 15
	4 3 3 5 4 1 5 5 5 4 1 5 5 4 2 3 3 3 1 6 2 1 5 5" );
	
	final moreClicksMoreDevices = parseInput(
	"11 20 72
	11 10 13 19 15 9 20 10 16 12 5
	6 8 3 4 8 6 10 3 6 5 2 4 10 2 6 6 4 2 4 5" );
	
	final powerHungry = parseInput(
	"20 20 200
	3 12 5 8 15 12 12 10 11 16 10 19 17 15 11 9 17 6 14 5
	1 3 5 7 5 9 2 4 6 8 10 11 13 15 2 17 12 14 16 18" );
	
}

