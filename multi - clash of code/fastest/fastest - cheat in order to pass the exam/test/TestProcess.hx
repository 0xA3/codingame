package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Process", {
			it( "Test 4 1", {
				final ip = test_4_1;
				Main.process( ip.n, ip.solutions, ip.answersNeighbor ).should.be( "100.00%" );
			});
			it( "Test 4 2", {
				final ip = test_4_2;
				Main.process( ip.n, ip.solutions, ip.answersNeighbor ).should.be( "100.00%" );
			});
			it( "Test 4 3", {
				final ip = test_4_3;
				Main.process( ip.n, ip.solutions, ip.answersNeighbor ).should.be( "75.00%" );
			});
			it( "Test1", {
				final ip = test1;
				Main.process( ip.n, ip.solutions, ip.answersNeighbor ).should.be( "87.50%" );
			});
			it( "Test2", {
				final ip = test2;
				Main.process( ip.n, ip.solutions, ip.answersNeighbor ).should.be( "100.00%" );
			});
			it( "Test3", {
				final ip = test3;
				Main.process( ip.n, ip.solutions, ip.answersNeighbor ).should.be( "88.28%" );
			});
		});
	}
	
	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final n = parseInt( lines[0] );
		final solutions = lines[1].split(" ");
		final answersNeighbor = lines[2].split(" ");
		
		return { n: n, solutions: solutions, answersNeighbor: answersNeighbor }
	}

	final test_4_1 = parseInput(
		"4
		C C C C
		C C C C" );
		
	final test_4_2 = parseInput(
		"4
		C C C C
		A A A A" );
	
	final test_4_3 = parseInput(
		"4
		A A A A
		A A A A" );
		
	final test1 = parseInput(
		"8
		A D B A C C A B
		A C B A C D A B" );
		
	final test2 = parseInput(
		"8
		C C A D C D C B
		A A A D B D A B" );

	final test3 = parseInput(
		"128
		A D B A B B A B C B A B A C B B D B B C D D C A D A C D B A C A B A B B D C C D D A C D A C B C B B A C C C D D C B B D A B B D A D C D C D C C A C A B A D D C D D D B B B A D C A B C C C A D A B B C A A D A B C D C D A A A B D B A C D C D B B B A A C B B
		A D A A B B A B C B A B A C B B D B B C D D D A D A C D B A C A B A B B D C B D D A D D A C B C B B A C C B D D C D B D A B B D A D C D C D C C A C A B A D D C D D D B B B A D B A B D C C A D A B B C A A D A C C D C B A A C A C B A C D C D B B B A B C B B" );

}

