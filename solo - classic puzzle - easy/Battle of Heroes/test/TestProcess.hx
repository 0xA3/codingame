package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Minotaur vs. Unicorn", {
				final ip = minotaurVsUnicorn;
				Main.process( ip.stack1Data, ip.stack2Data ).should.be( minotaurVsUnicornResult );
			});
			it( "Flawless victory!", {
				final ip = flawlessVictory;
				Main.process( ip.stack1Data, ip.stack2Data ).should.be( flawlessVictoryResult );
			});
			it( "Range battle", {
				final ip = rangeBattle;
				Main.process( ip.stack1Data, ip.stack2Data ).should.be( rangeBattleResult );
			});
			it( "Rebel scum", {
				final ip = rebelScum;
				Main.process( ip.stack1Data, ip.stack2Data ).should.be( rebelScumResult );
			});
			it( "Deadly strike-back", {
				final ip = deadlyStrikeBack;
				Main.process( ip.stack1Data, ip.stack2Data ).should.be( deadlyStrikeBackResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
			
		return { stack1Data: lines[0], stack2Data: lines[1] };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final minotaurVsUnicorn = parseInput(
		"Minotaur;20;35;10
		Unicorn;16;40;14" );

	final minotaurVsUnicornResult = parseResult(
		"Round 1
		20 Minotaur(s) attack(s) 16 Unicorn(s) dealing 200 damage
		5 unit(s) perish
		----------
		11 Unicorn(s) attack(s) 20 Minotaur(s) dealing 154 damage
		4 unit(s) perish
		##########
		Round 2
		16 Minotaur(s) attack(s) 11 Unicorn(s) dealing 160 damage
		4 unit(s) perish
		----------
		7 Unicorn(s) attack(s) 16 Minotaur(s) dealing 98 damage
		3 unit(s) perish
		##########
		Round 3
		13 Minotaur(s) attack(s) 7 Unicorn(s) dealing 130 damage
		3 unit(s) perish
		----------
		4 Unicorn(s) attack(s) 13 Minotaur(s) dealing 56 damage
		1 unit(s) perish
		##########
		Round 4
		12 Minotaur(s) attack(s) 4 Unicorn(s) dealing 120 damage
		3 unit(s) perish
		----------
		1 Unicorn(s) attack(s) 12 Minotaur(s) dealing 14 damage
		1 unit(s) perish
		##########
		Round 5
		11 Minotaur(s) attack(s) 1 Unicorn(s) dealing 110 damage
		1 unit(s) perish
		----------
		Minotaur won! 11 unit(s) left" );
	
	final flawlessVictory = parseInput(
		"Crusader;100;65;20
		Bone dragon;1;150;45" );

	final flawlessVictoryResult = parseResult(
		"Round 1
		100 Crusader(s) attack(s) 1 Bone dragon(s) dealing 2000 damage
		1 unit(s) perish
		----------
		Crusader won! 100 unit(s) left" );
	
	final rangeBattle = parseInput(
		"Halfling;1000;3;3
		Centaur;1300;5;2" );
	
	final rangeBattleResult = parseResult(
		"Round 1
		1000 Halfling(s) attack(s) 1300 Centaur(s) dealing 3000 damage
		600 unit(s) perish
		----------
		700 Centaur(s) attack(s) 1000 Halfling(s) dealing 1400 damage
		466 unit(s) perish
		##########
		Round 2
		534 Halfling(s) attack(s) 700 Centaur(s) dealing 1602 damage
		320 unit(s) perish
		----------
		380 Centaur(s) attack(s) 534 Halfling(s) dealing 760 damage
		254 unit(s) perish
		##########
		Round 3
		280 Halfling(s) attack(s) 380 Centaur(s) dealing 840 damage
		168 unit(s) perish
		----------
		212 Centaur(s) attack(s) 280 Halfling(s) dealing 424 damage
		141 unit(s) perish
		##########
		Round 4
		139 Halfling(s) attack(s) 212 Centaur(s) dealing 417 damage
		83 unit(s) perish
		----------
		129 Centaur(s) attack(s) 139 Halfling(s) dealing 258 damage
		86 unit(s) perish
		##########
		Round 5
		53 Halfling(s) attack(s) 129 Centaur(s) dealing 159 damage
		32 unit(s) perish
		----------
		97 Centaur(s) attack(s) 53 Halfling(s) dealing 194 damage
		53 unit(s) perish
		##########
		Centaur won! 97 unit(s) left" );
	
	final rebelScum = parseInput(
		"Rogue;1000;4;2
		Nomad;400;20;5" );
	
	final rebelScumResult = parseResult(
		"Round 1
		1000 Rogue(s) attack(s) 400 Nomad(s) dealing 2000 damage
		100 unit(s) perish
		----------
		300 Nomad(s) attack(s) 1000 Rogue(s) dealing 1500 damage
		375 unit(s) perish
		##########
		Round 2
		625 Rogue(s) attack(s) 300 Nomad(s) dealing 1250 damage
		62 unit(s) perish
		----------
		238 Nomad(s) attack(s) 625 Rogue(s) dealing 1190 damage
		297 unit(s) perish
		##########
		Round 3
		328 Rogue(s) attack(s) 238 Nomad(s) dealing 656 damage
		33 unit(s) perish
		----------
		205 Nomad(s) attack(s) 328 Rogue(s) dealing 1025 damage
		256 unit(s) perish
		##########
		Round 4
		72 Rogue(s) attack(s) 205 Nomad(s) dealing 144 damage
		7 unit(s) perish
		----------
		198 Nomad(s) attack(s) 72 Rogue(s) dealing 990 damage
		72 unit(s) perish
		##########
		Nomad won! 198 unit(s) left" );
	
	final deadlyStrikeBack = parseInput(
		"Vampire;9;30;8
		Genie;28;50;10" );
	
	final deadlyStrikeBackResult = parseResult(
		"Round 1
		9 Vampire(s) attack(s) 28 Genie(s) dealing 72 damage
		1 unit(s) perish
		----------
		27 Genie(s) attack(s) 9 Vampire(s) dealing 270 damage
		9 unit(s) perish
		##########
		Genie won! 27 unit(s) left" );
}
