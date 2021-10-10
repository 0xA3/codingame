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
			it( "Single Gymnast, Single Record", {
				final ip = t1;
				Main.process( ip.gymnasts, ip.categories, ip.rows ).should.be( r1 );
			});
			it( "Single Gymnast, Multiple Records", {
				final ip = t2;
				Main.process( ip.gymnasts, ip.categories, ip.rows ).should.be( r2 );
			});
			it( "Single Gymnast, Multiple Names", {
				final ip = t3;
				Main.process( ip.gymnasts, ip.categories, ip.rows ).should.be( r3 );
			});
			it( "Multiple Gymnasts, Single Category, Multiple Competitions", {
				final ip = t4;
				Main.process( ip.gymnasts, ip.categories, ip.rows ).should.be( r4 );
			});
			it( "Multiple Gymnasts, Multiple Categories, Multiple Competitions", {
				final ip = t5;
				Main.process( ip.gymnasts, ip.categories, ip.rows ).should.be( r5 );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final gymnasts = lines[0].split( "," );
		final categories = lines[1].split( "," );
		final n = parseInt( lines[2] );
		final rows = [for( i in 3...lines.length ) lines[i]];
				
		return { gymnasts: gymnasts, categories: categories, rows: rows };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final t1 = parseInput(
		"Simone Biles
		floor
		1
		Simone Biles,8,7,9"
	);

	final r1 = parseResult(
		"9"
	);

	final t2 = parseInput(
		"Aly Raisman
		bars
		3
		Aly Raisman,7.7,8.4,8.0
		Aly Raisman,7.9,7.6,9.3
		Aly Raisman,8.3,8.3,7.7"
	);

	final r2 = parseResult(
		"8.3"
	);

	final t3 = parseInput(
		"Laurie Hernandez
		bars
		3
		Nadia Comaneci,7.98,9.17,7.84
		Laurie Hernandez,8.57,8.68,7.86
		McKayla Maroney,8.18,9.29,8.47"
	);

	final r3 = parseResult(
		"8.57"
	);

	final t4 = parseInput(
		"Laurie Hernandez,Ragan Smith
		beam
		30
		Alicia Sacramone,7.99,8.01,8.39
		Alicia Sacramone,7.13,7.1,6.9
		Amy Jo Johnson,7.97,6.71,6.32
		Amy Jo Johnson,7.08,7.22,6.52
		Amy Jo Johnson,6.84,6.25,7.73
		Gabby Douglas,7.53,8.26,6.98
		Gabby Douglas,7.47,7.85,7.82
		Gabby Douglas,8.87,8.9,8.67
		Kacy Catanzaro,8.47,7.15,7.26
		Ragan Smith,7.79,6.24,6.25
		Kacy Catanzaro,8.07,7.09,6.96
		Kerri Strug,8.83,7.5,8.32
		Kerri Strug,8.81,8.2,7.52
		Kerri Strug,8.52,7.84,8.06
		Laurie Hernandez,8.57,8.68,7.86
		Shawn Johnson,7.45,8.06,8.98
		Laurie Hernandez,9.57,9.72,8.65
		Laurie Hernandez,8.68,8.81,8.01
		Nadia Comaneci,7.98,9.17,7.84
		Nadia Comaneci,8.26,9.43,8.63
		Nadia Comaneci,7.89,9.66,9.42
		Olga Korbut,6.85,6.7,7.36
		Olga Korbut,8.26,6.83,7.92
		Olga Korbut,7.98,7.16,7.55
		Alicia Sacramone,8.25,7.32,6.55
		Kacy Catanzaro,7.23,7.82,7.4
		Ragan Smith,6.69,8.1,7.23
		Ragan Smith,8.12,7.35,6.92
		Shawn Johnson,9.39,8.09,8.03
		Shawn Johnson,8.29,8.95,9.02"
	);

	final r4 = parseResult(
		"9.72
		8.1"
	);

	final t5 = parseInput(
		"Boris Shakhlin,Nadia Comaneci,Akinori Nakayama
		beam,floor
		28
		Nikolai Andrianov,7.95,9.7,9
		Nikolai Andrianov,8.94,8.3,9.29
		Simone Biles,8.7,8.2,8.6
		Boris Shakhlin,9.55,8.31,9.5
		Boris Shakhlin,8.55,9.02,8.64
		Aly Raisman,9.55,8.38,8.21
		Aly Raisman,8.38,8.04,9.23
		Takashi Ono,8.77,9.48,9.08
		Takashi Ono,8.65,9.19,7.88
		Nadia Comaneci,8.32,8.48,8.88
		Nadia Comaneci,8.92,7.98,8.04
		Sawao Kato,8.34,8.28,8.19
		Sawao Kato,9.5,7.98,8.94
		Laurie Hernandez,9.08,9.02,8.17
		Viktor Chukarin,7.67,8.75,8.94
		Laurie Hernandez,8.22,8.57,8.84
		Alexei Nemov,9.27,9.38,7.98
		Alexei Nemov,7.92,7.91,8.11
		McKayla Maroney,9.32,8.48,8.97
		McKayla Maroney,8.78,8.21,7.87
		Viktor Chukarin,8.07,9.05,7.66
		Katelyn Ohashi,8.03,7.63,9.15
		Katelyn Ohashi,9.06,8.88,9.01
		Akinori Nakayama,8.83,8.9,9.16
		Akinori Nakayama,9.05,8.54,8.56
		Shawn Johnson,8.95,8.11,8.07
		Shawn Johnson,7.6,8.62,8.33
		Simone Biles,8.62,9.56,8.72"
	);

	final r5 = parseResult(
		"9.02,9.5
		8.48,8.88
		8.9,9.16"
	);

}

