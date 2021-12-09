package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Small Garden", {
				final ip = smallGarden;
				Main.process( ip.m, ip.n, ip.t, ip.choices ).should.be( smallGardenResult ); });
			it( "A Bigger Garden", {
				final ip = aBiggerGarden;
				Main.process( ip.m, ip.n, ip.t, ip.choices ).should.be( aBiggerGardenResult ); });
			it( "Wide Garden", {
				final ip = wideGarden;
				Main.process( ip.m, ip.n, ip.t, ip.choices ).should.be( wideGardenResult ); });
			it( "So Many Carrots!!", {
				final ip = soManyCarrots;
				Main.process( ip.m, ip.n, ip.t, ip.choices ).should.be( soManyCarrotsResult ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final inputs = lines[0].split(" ");
		final m = parseInt( inputs[0] );
		final n = parseInt( inputs[1] );
		final t = parseInt( lines[1] );
		final inputs = lines[2].split(" ");
		final choices = [for( i in 0...t ) parseInt( inputs[i] )];
		
		return { m: m, n: n, t: t, choices: choices };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final smallGarden = parseInput(
		"2 2
		4
		2 1 1 2"
	);

	final smallGardenResult = parseResult(
		"8
		6
		4
		0"
	);

	final aBiggerGarden = parseInput(
		"3 3
		6
		1 2 3 2 3 3"
	);

	final aBiggerGardenResult = parseResult(
		"12
		12
		10
		12
		10
		8"
	);

	final wideGarden = parseInput(
		"1 20
		6
		2 5 8 13 15 16"
	);

	final wideGardenResult = parseResult(
		"42
		42
		42
		42
		42
		40"
	);

	final soManyCarrots = parseInput(
		"20 20
		80
		4 14 13 8 14 20 1 19 17 4 14 17 19 2 20 2 12 1 13 19 19 7 5 12 20 4 14 8 10 14 9 19 15 19 8 3 17 17 8 2 17 9 10 16 17 8 16 10 5 20 15 4 3 16 15 6 20 14 20 18 19 11 11 6 8 1 13 17 14 5 8 3 20 12 6 8 3 7 12 13"
	);
	
	final soManyCarrotsResult = parseResult(
		"82
		84
		84
		86
		88
		88
		88
		88
		90
		92
		94
		96
		98
		98
		96
		98
		98
		96
		96
		98
		100
		100
		100
		100
		98
		100
		102
		104
		106
		108
		106
		108
		108
		110
		112
		110
		112
		114
		116
		118
		120
		120
		120
		118
		120
		122
		122
		124
		124
		122
		120
		122
		120
		120
		118
		116
		114
		116
		114
		112
		114
		112
		110
		110
		112
		110
		110
		112
		114
		114
		116
		114
		112
		112
		112
		114
		114
		112
		114
		112"
	);
}

