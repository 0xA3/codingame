package test;

import Main.Route;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Little annoyance", {
				final ip = littleAnnoyance;
				Main.process( ip.roadLength, ip.routes ).should.be( 3 );
			});
			it( "Like stopping for a coffee", {
				final ip = likeStoppingForACoffee;
				Main.process( ip.roadLength, ip.routes ).should.be( 6 );
			});
			it( "Cote d'Azur", {
				final ip = coteDAzur;
				Main.process( ip.roadLength, ip.routes ).should.be( 37 );
			});
			it( "Genova - Roma", {
				final ip = yetAnotherUrgentMessage;
				Main.process( ip.roadLength, ip.routes ).should.be( 177 );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final roadLength = parseInt( lines[0] );
		final zoneQuantity = parseInt( lines[1] );
		final routes:Array<Route> = [for( i in 0...zoneQuantity ) {
			final inputs = lines[i + 2].split(" ");
			{ start: parseInt( inputs[0] ), speed: parseInt( inputs[1] )}
		}];
		
		return { roadLength: roadLength, routes: routes };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final littleAnnoyance = parseInput(
	"130
	1
	60 120" );

	final likeStoppingForACoffee = parseInput(
	"150
	3
	30 120
	60 110
	90 120" );

	final coteDAzur = parseInput(
	"260
	25
	10 90
	20 90
	30 110
	40 110
	50 90
	60 90
	70 110
	80 110
	90 90
	100 90
	110 110
	120 110
	130 90
	140 90
	150 110
	160 110
	170 90
	180 90
	190 110
	200 110
	210 90
	220 90
	230 110
	240 110
	250 90" );

	final yetAnotherUrgentMessage = parseInput(
	"650
	22
	25 110
	26 60
	50 110
	80 60
	124 130
	125 110
	149 130
	150 90
	255 60
	358 130
	359 110
	387 90
	400 110
	425 130
	426 110
	478 90
	480 60
	514 90
	596 60
	605 130
	606 110
	620 90" );
}
