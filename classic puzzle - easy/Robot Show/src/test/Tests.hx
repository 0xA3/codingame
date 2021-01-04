package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Example", {
				final input = parse( example );
				Main.process( input.length, input.initLocations ).should.be( 8 );
			});
			
			it( "Simple", {
				final input = parse( simple );
				Main.process( input.length, input.initLocations ).should.be( 20 );
			});
			
			it( "More Bots", {
				final input = parse( moreBots );
				Main.process( input.length, input.initLocations ).should.be( 102 );
			});
			
			it( "Ping Pong", {
				final input = parse( pingPong );
				Main.process( input.length, input.initLocations ).should.be( 112 );
			});
			
			it( "Traffic Jam", {
				final input = parse( trafficJam );
				Main.process( input.length, input.initLocations ).should.be( 153 );
			});
			
			it( "Singular", {
				final input = parse( singular );
				Main.process( input.length, input.initLocations ).should.be( 7 );
			});
			
		});

	}

	static function parse( input:String ) {
		final lines = input.split( "\n" );
		final length = parseInt( lines[0] );
		final n = parseInt( lines[1] );
		final inputs = lines[2].split(' ');
		final initLocations = [for( i in 0...n) parseInt( inputs[i] )];
		return { length: length, initLocations: initLocations };
	}

	final example =
	"10
	2
	2 6";

	final simple =
	"20
	7
	1 2 20 7 6 10 14";

	final moreBots =
	"103
	20
	87 19 72 59 22 74 89 30 33 3 66 77 15 23 58 82 56 98 1 84";

	final pingPong =
	"113
	50
	42 38 102 73 106 15 51 8 72 66 112 95 87 90 1 104 25 43 14 29 57 98 33 58 55 16 49 60 105 71 18 12 28 86 4 101 63 36 22 31 45 17 75 85 32 61 62 30 107 13";

	final trafficJam =
	"156
	78
	14 127 21 15 91 121 89 105 32 136 100 95 143 112 88 147 78 48 36 114 28 33 151 9 59 11 116 134 6 39 67 50 110 102 139 49 118 30 144 4 97 56 52 73 125 115 149 66 71 42 3 61 141 81 106 101 99 137 111 133 79 43 145 84 51 107 131 12 87 104 60 126 119 146 96 7 94 10";

	final singular =
	"14
	1
	7";

}

