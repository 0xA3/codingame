package test;

import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Example", {
				final ip = example;
				Main.process( ip.teams, ip.scores1, ip.scores2 ).should.be( exampleResult );
			});
			it( "England Argentina", {
				final ip = englandArgentina;
				Main.process( ip.teams, ip.scores1, ip.scores2 ).should.be( englandArgentinaResult );
			});
			it( "France South Africa", {
				final ip = franceSouthAfrica;
				Main.process( ip.teams, ip.scores1, ip.scores2 ).should.be( franceSouthAfricaResult );
			});
			it( "New Zealand Uruguay", {
				final ip = newZealandUruguay;
				Main.process( ip.teams, ip.scores1, ip.scores2 ).should.be( newZealandUruguayResult );
			});
			it( "Perfect Tie", {
				final ip = perfectTie;
				Main.process( ip.teams, ip.scores1, ip.scores2 ).should.be( perfectTieResult );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		final teams = readline().split( ",");
		final scores1 = readline();
		final scores2 = readline();
					
		return { teams: teams, scores1: scores1, scores2: scores2 };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final example = parseInput(
		"A team,Another team
		8 31 37,32,7,10
		15 19,17 20,27 29 67,76"
	);

	final exampleResult = parseResult(
		"A team: 23 42
		Another team: 26 23"
	);

	final englandArgentina = parseInput(
		"England,Argentina
		,,10 46 54 59 66 75,27 31 37
		79,80,5,"
	);

	final englandArgentinaResult = parseResult(
		"England: 27 54
		Argentina: 10 5"
	);

	final franceSouthAfrica = parseInput(
		"France,South Africa
		4 22 31,5 32,40 54 73,
		8 18 26 67,10 28 67,69,"
	);

	final franceSouthAfricaResult = parseResult(
		"France: 28 33
		South Africa: 29 24"
	);

	final newZealandUruguay = parseInput(
		"New Zealand,Uruguay
		20 25 33 38 45 49 53 65 68 73 77,21 26 34 50 54 66 69 74 78,,
		,,,"
	);

	final newZealandUruguayResult = parseResult(
		"New Zealand: 73 61
		Uruguay: 0 0"
	);

	final perfectTie = parseInput(
		"Team A,Team B
		12 45,13,79,
		12 45,13,,79"
	);

	final perfectTieResult = parseResult(
		"Team A: 15 0
		Team B: 15 0"
	);
}