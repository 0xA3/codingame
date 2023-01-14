package test;

import Main.getDigitSums;
import Main.isBuzzle;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test getDigitSums", {
			
			it( "80 base 12", {
				trace( getDigitSums( 80, 12 ));
				getDigitSums( 80, 12 ).join(" ").should.be( "80 14 3" );
			});
			it( "83 base 12", {
				// getDigitSums( 84, 12 ).join(" ").should.be( "70 7" );
				trace( getDigitSums( 83, 12 ));
			});
			it( "84 base 12", {
				getDigitSums( 84, 12 ).join(" ").should.be( "84 7" );
				trace( getDigitSums( 84, 12 ));
			});
		});

		describe( "Test IsBuzzle", {
			
			it( "16 num 7 base 18", {
				isBuzzle( 16, 7, 18 ).should.be( false );
			});
			it( "17 num 7 base 18", {
				isBuzzle( 17, 7, 18 ).should.be( false );
			});
			it( "48 num 7 base 18", {
				isBuzzle( 48, 7, 18 ).should.be( true );
			});
			it( "79 base 12", {
				isBuzzle( 79, 7, 12 ).should.be( true );
			});
			it( "80 base 12", {
				isBuzzle( 80, 7, 12 ).should.be( true );
			});
			it( "81 base 12", {
				isBuzzle( 81, 7, 12 ).should.be( false );
				isBuzzle( 81, 11, 12 ).should.be( false );
			});
			it( "82 base 12", {
				isBuzzle( 82, 7, 12 ).should.be( false );
				isBuzzle( 82, 11, 12 ).should.be( false );
			});
			it( "83 base 12", {
				isBuzzle( 83, 11, 12 ).should.be( true );
			});
		});

		describe( "Test process", {
			
			it( "Test 1 - Level 1+", {
				final ip = test1Level1;
				Main.process( ip.n, ip.a, ip.b, ip.nums ).should.be( test1Level1Result );
			});
			it( "Test 2 - Level 2+", {
				final ip = test2Level2;
				Main.process( ip.n, ip.a, ip.b, ip.nums ).should.be( test2Level2Result );
			});
			it( "Test 3 - Level 3+", {
				final ip = test3Level3;
				Main.process( ip.n, ip.a, ip.b, ip.nums ).should.be( test3Level3Result );
			});
			it( "example - Level 4", {
				final ip = exampleLevel4;
				Main.process( ip.n, ip.a, ip.b, ip.nums ).should.be( exampleLevel4Result );
			});
			it( "Test 4 - Level 4", {
				final ip = test4Level4;
				Main.process( ip.n, ip.a, ip.b, ip.nums ).should.be( test4Level4Result );
			});
			it( "Test 5 - Level 4", {
				final ip = test5Level4;
				Main.process( ip.n, ip.a, ip.b, ip.nums ).should.be( test5Level4Result );
			});
			it( "Everything is Buzzle", {
				final ip = everythingIsBuzzle;
				Main.process( ip.n, ip.a, ip.b, ip.nums ).should.be( everythingIsBuzzleResult );
			});
			it( "Ternary", {
				final ip = ternary;
				Main.process( ip.n, ip.a, ip.b, ip.nums ).should.be( ternaryResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final n = parseInt( inputs[0] );
		final a = parseInt( inputs[1] );
		final b = parseInt( inputs[2] );
		final k = parseInt( lines[1] );
		final inputs = lines[2].split(' ');
		final nums = [for( i in 0...k ) parseInt( inputs[i] )];
				
		return { n: n, a: a, b: b, nums: nums }
	}
	
	static function parseResult( input:String ) return input.replace( "\t", "" ).replace( "\r", "" );

	final test1Level1 = parseInput(
		"10 107 114
		1
		7"
	);

	final test1Level1Result = parseResult(
		"Buzzle
		108
		109
		110
		111
		Buzzle
		113
		114"
	);

	final test2Level2 = parseInput(
		"10 26 40
		1
		7"
	);

	final test2Level2Result = parseResult(
		"26
		Buzzle
		Buzzle
		29
		30
		31
		32
		33
		Buzzle
		Buzzle
		36
		Buzzle
		38
		39
		40"
	);

	final test3Level3 = parseInput(
		"10 566 588
		2
		5 9"
	);

	final test3Level3Result = parseResult(
		"566
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		571
		Buzzle
		Buzzle
		574
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		583
		584
		Buzzle
		Buzzle
		Buzzle
		588"
	);

	final exampleLevel4 = parseInput(
		"12 78 96
		2
		7 11"
	);
	
	final exampleLevel4Result = parseResult(
		"78
		Buzzle
		Buzzle
		81
		82
		Buzzle
		Buzzle
		85
		86
		87
		Buzzle
		89
		90
		Buzzle
		92
		93
		94
		Buzzle
		96"
	);

	final test4Level4 = parseInput(
		"18 1029 1088
		2
		11 17"
	);

	final test4Level4Result = parseResult(
		"1029
		1030
		Buzzle
		1032
		1033
		Buzzle
		1035
		1036
		Buzzle
		1038
		1039
		1040
		1041
		Buzzle
		Buzzle
		1044
		Buzzle
		1046
		1047
		Buzzle
		1049
		1050
		1051
		1052
		1053
		Buzzle
		Buzzle
		Buzzle
		1057
		1058
		Buzzle
		1060
		Buzzle
		1062
		1063
		1064
		Buzzle
		1066
		Buzzle
		1068
		1069
		1070
		Buzzle
		1072
		Buzzle
		1074
		1075
		Buzzle
		1077
		Buzzle
		Buzzle
		1080
		1081
		Buzzle
		1083
		1084
		1085
		1086
		1087
		Buzzle"
	);

	final test5Level4 = parseInput(
		"24 4516 4586
		3
		13 19 23"
	);
	
	final test5Level4Result = parseResult(
		"4516
		4517
		4518
		4519
		4520
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		4526
		Buzzle
		Buzzle
		4529
		4530
		Buzzle
		Buzzle
		4533
		4534
		Buzzle
		4536
		Buzzle
		4538
		4539
		4540
		Buzzle
		4542
		4543
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		4548
		Buzzle
		Buzzle
		Buzzle
		4552
		4553
		Buzzle
		Buzzle
		4556
		4557
		4558
		Buzzle
		Buzzle
		4561
		4562
		Buzzle
		4564
		4565
		4566
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		4571
		4572
		Buzzle
		Buzzle
		4575
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		4580
		4581
		4582
		Buzzle
		4584
		4585
		4586"
	);
	
	final everythingIsBuzzle = parseInput(
		"6 128 144
		3
		3 4 5"
	);
	
	final everythingIsBuzzleResult = parseResult(
		"Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle"
	);
	
	final ternary = parseInput(
		"3 15 46
		1
		2"
	);
	
	final ternaryResult = parseResult(
		"15
		Buzzle
		Buzzle
		Buzzle
		19
		Buzzle
		21
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		27
		Buzzle
		Buzzle
		Buzzle
		31
		Buzzle
		33
		Buzzle
		Buzzle
		Buzzle
		37
		Buzzle
		39
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		Buzzle
		45
		Buzzle"
	);
}

