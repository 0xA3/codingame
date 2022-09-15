package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Easy as Pizza Pie", {
				final ip = easyAsPizzaPie;
				Main.process( ip.n, ip.k, ip.areas ).should.be( "1 30" );
			});
			it( "Last Ones Left", {
				final ip = lastOnesLeft;
				Main.process( ip.n, ip.k, ip.areas ).should.be( "2 25" );
			});
			it( "Repetition", {
				final ip = repetition;
				Main.process( ip.n, ip.k, ip.areas ).should.be( "111 1554" );
			});
			it( "Separate but Equal", {
				final ip = separateButEqual;
				Main.process( ip.n, ip.k, ip.areas ).should.be( "7 28" );
			});
			it( "Circular Pizza", {
				final ip = circularPizza;
				Main.process( ip.n, ip.k, ip.areas ).should.be( "1 40000" );
			});
			it( "The Pizza Is Aggressive", {
				final ip = thePizzaIsAggressive;
				Main.process( ip.n, ip.k, ip.areas ).should.be( "777 399632" );
			});
		});
	}
	
	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final n = parseInt( inputs[0] );
		final k = parseInt( inputs[1] );
		final areas = [for( i in 0...n ) parseInt( lines[i + 1])];

		return { n: n, k: k, areas: areas };
	}

	final easyAsPizzaPie = parseInput(
		"7 3
		5
		10
		10
		10
		5
		1
		5" );

	final lastOnesLeft = parseInput(
		"6 5
		2
		3
		4
		5
		6
		7" );

	final repetition = parseInput(
		"15 2
		111
		555
		999
		555
		111
		111
		555
		999
		555
		111
		111
		555
		999
		555
		111" );

	final separateButEqual = parseInput(
		"10 4
		7
		7
		7
		7
		7
		7
		7
		7
		7
		7" );

	final circularPizza = parseInput(
		"3 2
		20000
		1
		20000" );

	final thePizzaIsAggressive = parseInput(
		"11 6
		777
		777
		99999
		777
		777
		99907
		99908
		1
		1
		99908
		99907" );
}
