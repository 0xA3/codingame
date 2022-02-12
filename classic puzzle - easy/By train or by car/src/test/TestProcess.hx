package test;

import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Example", {
				final ip = example;
				Main.process( ip.t0, ip.t1, ip.segments ).should.be( "TRAIN 2:39" );
			});
			it( "no stop car first", {
				final ip = noStopCarFirst;
				Main.process( ip.t0, ip.t1, ip.segments ).should.be( "CAR 1:00" );
			});
			it( "no stop train first", {
				final ip = noStopTrainFirst;
				Main.process( ip.t0, ip.t1, ip.segments ).should.be( "TRAIN 4:13" );
			});
			it( "Orléans Cholet", {
				final ip = orleansCholet;
				Main.process( ip.t0, ip.t1, ip.segments ).should.be( "TRAIN 3:17" );
			});
			it( "Orléans Nantes", {
				final ip = orleansNantes;
				Main.process( ip.t0, ip.t1, ip.segments ).should.be( "TRAIN 4:00" );
			});
			it( "Pithiviers Cholet", {
				final ip = pithiviersCholet;
				Main.process( ip.t0, ip.t1, ip.segments ).should.be( "TRAIN 3:43" );
			});
			it( "Angouleme Royan", {
				final ip = angoulemeRoyan;
				Main.process( ip.t0, ip.t1, ip.segments ).should.be( "CAR 1:46" );
			});
			it( "Montpellier Perpignan", {
				final ip = montepellierPerpignan;
				Main.process( ip.t0, ip.t1, ip.segments ).should.be( "CAR 2:27" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final t = lines[0].split(" ");
		final n = parseInt( lines[1] );
		final segments = [for( i in 0...n ) lines[i + 2].split(" ")];
		
		return { t0: t[0], t1: t[1], segments: segments }
	}

	final example = parseInput(
		"Paris Tours
		2
		Paris Orleans 133
		Orleans Tours 218"
	);

	final noStopCarFirst = parseInput(
		"Paris Chartres
		1
		Paris Chartres 91"
	);

	final noStopTrainFirst = parseInput(
		"Paris Marseille
		1
		Paris Marseille 863"
	);

	final orleansCholet = parseInput(
		"Orleans Cholet
		5
		Orleans Blois 63
		Blois Tours 65
		Tours Saumur 78
		Saumur Angers 66
		Angers Cholet 65"
	);

	final orleansNantes = parseInput(
		"Orleans Nantes
		7
		Orleans Blois 63
		Cholet Clisson 35.9
		Tours Saumur 78
		Clisson Nantes 33.7
		Blois Tours 65
		Angers Cholet 65
		Saumur Angers 66"
	);
	
	final pithiviersCholet = parseInput(
		"Pithiviers Cholet
		8
		Poitiers Angouleme 138
		Pithiviers Orleans 57
		Orleans Blois 63
		Blois Tours 65
		Bordeaux Périgueux 137
		Tours Saumur 78
		Saumur Angers 66
		Angers Cholet 65"
	);
	
	final angoulemeRoyan = parseInput(
		"Angouleme Royan
		5
		Angouleme Jarnac 33.2
		Jarnac Cognac 11
		Cognac Saintes 28.1
		Saintes Saujon 27.7
		Saujon Royan 13.3"
	);
	
	final montepellierPerpignan = parseInput(
		"Montpellier Perpignan
		18
		Cholet Clisson 35.9
		Beziers Narbonne 34.2
		Orleans Blois 63
		Montpellier Beziers 73.1
		Tours Saumur 78
		Angouleme Jarnac 33.2
		Jarnac Cognac 11
		Cognac Saintes 28.1
		Saintes Saujon 27.7
		Saujon Royan 13.3
		Clisson Nantes 33.7
		Blois Tours 65
		Angers Cholet 65
		Saumur Angers 66
		Narbonne Roquefort-des-Corbieres 27
		Salses-le-Château Perpignan 17.6
		Paris Chartres 91
		Roquefort-des-Corbieres Salses-le-Château 28.9"
	);
}

