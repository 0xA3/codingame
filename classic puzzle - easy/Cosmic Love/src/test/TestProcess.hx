package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "One haven", {
				Main.process( oneHaven ).should.be( "G7_24a" );
			});
			it( "Happy Alice", {
				Main.process( happyAlice ).should.be( "Millers_Planet" );
			});
			it( "Hungry Alice", {
				Main.process( hungryAlice ).should.be( "CodinPlanet" );
			});
			it( "So Many Options", {
				Main.process( soManyOptions ).should.be( "Gh2" );
			});
			it( "The Event Horizon", {
				Main.process( theEventHorizon ).should.be( "Supergiant_H59" );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final planets:Array<Planet> = [for( i in 1...lines.length ) Main.createPlanet( lines[i] )];
		return planets;
	}
	
	final oneHaven = parseInput(
		"3
		Alice 4.70e11 4.70e42 0
		BLARGHHH 6.30e09 1.30e31 5.14e11
		G7_24a 4.49e08 2.50e30 5.51e13"
	);

	final happyAlice = parseInput(
		"6
		New_York_Planet 3.90e04 3.20e20 4.31e13
		Kepler_1337 4.49e08 2.50e30 5.07e13
		Mar_Sara 3.90e07 7.00e25 2.21e14
		The_Sun 6.96e08 1.99e30 1.33e14
		Alice 7.33e11 5.72e44 0
		Millers_Planet 4.40e07 2.00e29 9.20e12"
	);

	final hungryAlice = parseInput(
		"10
		Sector_XII 6.30e07 1.30e24 6.21e11
		Planet_of_the_Apendectomies 4.49e08 2.50e30 6.21e11
		Earth 6.38e06 5.97e23 2.89e12
		VX819 3.62e08 1.67e31 5.33e11
		CodinPlanet 7.49e03 9.23e14 7.62e13
		SSxss2 4.16e11 1.35e39 6.23e11
		Alice 4.70e11 4.70e44 0
		Cybertron 2.60e10 6.29e31 3.96e12
		C44 7.81e08 4.88e30 7.12e11
		Nowhere_Planet 4.39e04 3.95e14 5.25e11"
	);

	final soManyOptions = parseInput(
		"24
		C33 3.18e06 3.52e17 6.98e13
		C32 7.87e06 2.76e25 3.04e14
		C31 5.50e04 3.00e16 1.36e13
		Alice 9.20e12 7.72e48 0
		Gh1 9.71e05 3.67e24 1.62e16
		Gh2 6.36e08 2.52e32 6.95e14
		Gh3 3.63e07 3.57e26 9.63e12
		Gh4 8.46e07 1.54e30 7.09e17
		Gh5 9.28e05 4.17e25 7.68e16
		OMG 2.05e08 5.08e27 3.15e13
		North_Par 9.03e05 8.22e22 7.30e13
		South_Par 1.09e08 7.89e28 2.43e14
		Gi3x5 2.27e05 4.90e16 9.63e13
		Hx9y3 7.70e06 2.68e28 4.28e13
		Mw4e7 4.85e08 1.30e16 6.77e15
		Aa2b9 8.10e08 7.88e30 2.27e13
		Moorf 6.80e06 1.67e27 9.34e17
		Moorg 7.01e06 2.04e26 3.14e13
		Moord 5.43e07 5.13e30 7.62e15
		Moorb 3.40e07 6.71e29 2.73e16
		Moorp 1.09e07 4.28e24 9.76e17
		Moork 7.32e05 9.19e22 1.67e16
		Moo 9.00e06 2.55e27 9.92e12
		Bob 2.88e04 2.64e16 7.62e16"
	);

	final theEventHorizon = parseInput(
		"30
		Virgx3 7.14e06 1.26e27 4.72e13
		Gusty_Garden_Galaxy 1.39e07 3.69e29 9.25e12
		Swsn_42g 3.07e05 8.28e23 8.60e12
		California 4.90e05 8.82e23 2.84e14
		Kepples_x2a_1 8.23e05 1.96e21 8.12e15
		Gz3_an1_5b 9.04e05 3.88e25 8.88e13
		Twin_Planets 3.57e07 6.06e26 8.61e14
		Earht 9.80e07 4.06e31 1.91e13
		Vaelfor 9.25e05 4.69e24 2.91e14
		Ns_2335_b 8.29e06 1.75e29 1.21e14
		Soliferous 1.51e07 1.17e24 2.46e15
		Qua_sar 9.09e08 6.29e29 8.64e16
		GRB_34 1.84e08 6.54e32 7.21e12
		Gernob 7.77e04 2.27e20 6.51e14
		Rad 1.72e05 8.59e22 5.15e13
		Alice 3.92e10 5.36e48 0
		Gernob_2 6.69e07 6.06e27 7.54e14
		Alpha_Parsec_35_y 3.07e08 3.84e30 6.87e14
		Beyond 1.05e07 5.34e28 9.76e13
		Tylenal 5.22e04 9.51e20 4.39e14
		Magen_4s 5.68e05 7.43e23 4.35e14
		Spacescraper 4.43e07 8.01e28 5.79e13
		Schrodingers_Plant 8.62e05 6.62e25 8.23e14
		Tailor_Swift 1.37e07 6.28e27 9.73e15
		Donald_Dunk 8.80e03 4.47e17 4.68e16
		Fireflee 2.32e03 5.96e13 2.15e15
		Supergiant_H59 2.99e08 6.48e33 4.37e13
		GRB_34 6.54e06 9.75e23 6.70e15
		Blue3 3.57e05 5.09e22 4.06e14
		New_New_Zealand 2.16e05 9.65e20 6.62e14"
	);

}

