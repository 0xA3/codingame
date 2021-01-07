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
			
			it( "1 switch 1 light", {
				final input = _1Switch1Light;
				Main.process( input.wirings, input.switches ).should.be( _1Switch1LightResult );
			});
			
			it( "2 parallel switches 1 light", {
				final input = _2ParallelSwitches1Light;
				Main.process( input.wirings, input.switches ).should.be( _2ParallelSwitches1LightResult );
			});
			
			it( "2 series switches 1 light", {
				final input = _2SeriesSwitches1Light;
				Main.process( input.wirings, input.switches ).should.be( _2SeriesSwitches1LightResult );
			});
			
			it( "Two lights", {
				final input = twoLights;
				Main.process( input.wirings, input.switches ).should.be( twoLightsResult );
			});
			
			it( "Series and parallel", {
				final input = seriesAndParallel;
				Main.process( input.wirings, input.switches ).should.be( seriesAndParallelResult );
			});
			
			it( "Mixed", {
				final input = mixed;
				Main.process( input.wirings, input.switches ).should.be( mixedResult );
			});
			
			it( "Weird Home", {
				final input = weirdHome;
				Main.process( input.wirings, input.switches ).should.be( weirdHomeResult );
			});
			
			it( "Regular Home", {
				final input = regularHome;
				Main.process( input.wirings, input.switches ).should.be( regularHomeResult );
			});
			
		});

	}

	static function parseInput( input:String ) {
		final inputLines = input.split( "\n" );
		
		final c = parseInt( inputLines[0] );
		final wirings = [for( i in 0...c ) inputLines[i + 1].trim()];
		
		final a = parseInt( inputLines[c + 1] );
		final switches = [for( i in 0...a ) inputLines[i + c + 2].trim()];

		return { wirings: wirings, switches: switches };
	}

	static function parseResult( result:String ) {
		final lines = result.split( "\n" );
		return lines.map( line -> line.trim() ).join( "\n" );
	}

	final _1Switch1Light = parseInput(
	"1
	LIGHT - A1
	1
	A1" );

	final _1Switch1LightResult = parseResult( "LIGHT is ON" );

	final _2ParallelSwitches1Light = parseInput(
	"1
	LIGHT = A1 A2
	1
	A2" );

	final _2ParallelSwitches1LightResult = parseResult( "LIGHT is ON" );

	final _2SeriesSwitches1Light = parseInput(
	"1
	LIGHT - A1 A2
	3
	A1
	A2
	A1" );

	final _2SeriesSwitches1LightResult = parseResult( "LIGHT is OFF" );

	final twoLights = parseInput(
	"2
	LIGHT1 - A1
	LIGHT2 - B1
	2
	A1
	B1" );

	final twoLightsResult = parseResult(
	"LIGHT1 is ON
	LIGHT2 is ON" );

	final seriesAndParallel = parseInput(
	"1
	LIGHT - A1 = A2 A3
	6
	A1
	A1
	A2
	A2
	A3
	A1" );

	final seriesAndParallelResult = parseResult( "LIGHT is ON" );

	final mixed = parseInput(
	"2
	LIGHT1 - A1 = A2 A3
	LIGHT2 - B1 = B2 B3 = B4 B5
	6
	A1
	B1
	B2
	A3
	B5
	B4" );

	final mixedResult = parseResult(
	"LIGHT1 is ON
	LIGHT2 is ON" );

	final weirdHome = parseInput(
	"6
	TV = A1 A2 - A3
	BOX = A1 A2 = A3 A4
	CONSOLE = A1 A2
	LIGHTS = B1 B2
	OVEN - KITCHEN = C1 C2 C3 - C4
	DISHWASHER - KITCHEN D1 D2 = D3 D4
	19
	A1
	B1
	A3
	C2
	C4
	A4
	A4
	A4
	A4
	D1
	KITCHEN
	D2
	A4
	A2
	KITCHEN
	D4
	A3
	C4
	KITCHEN" );

	final weirdHomeResult = parseResult(
	"TV is OFF
	BOX is ON
	CONSOLE is ON
	LIGHTS is ON
	OVEN is OFF
	DISHWASHER is ON" );

	final regularHome = parseInput(
	"24
	Room1-Light - Main Room1-Sw-L
	Room1-Radio - Main Room1-Sw-R
	Room1-PC - Main Room1-Sw-PC
	Room2-Light - Main Room2-Sw-L
	Room2-TV - Main Room2-Sw-TV
	Room2-Console - Main Room2-Sw-TV
	Bathroom-Light - Main Bathroom-CB Bathroom-Sw-L
	Bathroom-Vent - Main Bathroom-CB Bathroom-Sw-L
	Bathroom-WashingMachine - Main Bathroom-CB
	Bathroom-ElectricDryer - Main Bathroom-CB
	Kitchen-Light - Main Kitchen-Sw-L
	Kitchen-Oven - Main Kitchen-CB1 Kitchen-Sw-O
	Kitchen-Cooktop - Main Kitchen-CB1 Kitchen-Sw-CT
	Kitchen-Hood - Main Kitchen-CB1 Kitchen-Sw-CT
	Kitchen-DishWasher - Main Kitchen-CB1 Kitchen-Sw-CT
	Kitchen-Fridge - Main Kitchen-CB2
	Kitchen-Freezer - Main Kitchen-CB2
	InternetBox - Main
	Living-Light1 - Main Living-Sw-L1
	Living-Light2 - Main Living-Sw-L2
	Living-TV - Main Living-Sw-TV
	Living-Console - Main Living-Sw-TV
	Living-PC - Main Living-Sw-PC
	Living-Printer - Main Living-Sw-PC
	4
	Main
	Bathroom-CB
	Kitchen-CB1
	Kitchen-CB2" );

	final regularHomeResult = parseResult(
	"Room1-Light is OFF
	Room1-Radio is OFF
	Room1-PC is OFF
	Room2-Light is OFF
	Room2-TV is OFF
	Room2-Console is OFF
	Bathroom-Light is OFF
	Bathroom-Vent is OFF
	Bathroom-WashingMachine is ON
	Bathroom-ElectricDryer is ON
	Kitchen-Light is OFF
	Kitchen-Oven is OFF
	Kitchen-Cooktop is OFF
	Kitchen-Hood is OFF
	Kitchen-DishWasher is OFF
	Kitchen-Fridge is ON
	Kitchen-Freezer is ON
	InternetBox is ON
	Living-Light1 is OFF
	Living-Light2 is OFF
	Living-TV is OFF
	Living-Console is OFF
	Living-PC is OFF
	Living-Printer is OFF" );

}

