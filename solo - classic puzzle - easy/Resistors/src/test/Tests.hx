package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {

			it( "Series", {
				final inputs = parse( series );
				Main.process( inputs.resistors, inputs.circuit ).should.be( "30.0" );
			});

			it( "Parallel", {
				final inputs = parse( parallel );
				Main.process( inputs.resistors, inputs.circuit ).should.be( "11.1" );
			});

			it( "Combined (Example Diagram)", {
				final inputs = parse( combined );
				Main.process( inputs.resistors, inputs.circuit ).should.be( "10.7" );
			});

			it( "Complex", {
				final inputs = parse( complex );
				Main.process( inputs.resistors, inputs.circuit ).should.be( "2.4" );
			});

			it( "More Complex", {
				final inputs = parse( moreComplex );
				Main.process( inputs.resistors, inputs.circuit ).should.be( "45.0" );
			});

			it( "5-pointed Star", {
				final inputs = parse( pointedStar );
				Main.process( inputs.resistors, inputs.circuit ).should.be( "91.0" );
			});

			
		});

	}

	function parse( input:String ) {
		final inputRows = input.split( "\n" );
		
		var n = parseInt( inputRows[0] );
		final resistors:Map<String, Float> = [];
		for( i in 0...n ) {
			var inputs = inputRows[i + 1].split(' ');
			final name = inputs[0].trim();
			final r = parseInt( inputs[1] );
			resistors.set( name, r );
		}
		final circuit = inputRows[n + 1].trim();

		return { resistors: resistors, circuit: circuit };
	}

	static final series = "2
	A 20
	B 10
	( A B )";

	static final parallel = "2
	C 20
	D 25
	[ C D ]";

	static final combined = "3
	A 24
	B 8
	C 48
	[ ( A B ) [ C A ] ]";

	static final complex = "7
	Alfa 1
	Bravo 1
	Charlie 12
	Delta 4
	Echo 2
	Foxtrot 10
	Golf 8
	( Alfa [ Charlie Delta ( Bravo [ Echo ( Foxtrot Golf ) ] ) ] )";

	static final moreComplex = "3
	Alef 30
	Bet 20
	Vet 10
	( Alef [ ( Bet Bet Bet ) ( Vet [ ( Vet Vet ) ( Vet [ Bet Bet ] ) ] ) ] )";

	static final pointedStar = "1
	Star 78
	[ ( [ Star ( Star Star ) ] [ Star ( Star Star ) ] Star ) ( [ Star ( Star Star ) ] [ Star ( Star Star ) ] Star ) ]";

}

