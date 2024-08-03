package test;

import Main.Action;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "1- KEN vs RYU", {
				final ip = _1KenVsRyu;
				Main.process( ip.champions, ip.actions ).should.be( "RYU beats KEN in 3 hits" );
			});
			it( "-KEN vs VLAD Kick only", {
				final ip = _2KenVsVladKickOnly;
				Main.process( ip.champions, ip.actions ).should.be( "KEN beats VLAD in 5 hits" );
			});
			it( "3-ANNA vs JUN Punch only", {
				final ip = _3AnnaVsJunPunchOnly;
				Main.process( ip.champions, ip.actions ).should.be( "JUN beats ANNA in 5 hits" );
			});
			it( "4-TANK vs JADE punch & kick", {
				final ip = _4TankVsJadePunchKick;
				Main.process( ip.champions, ip.actions ).should.be( "TANK beats JADE in 5 hits" );
			});
			it( "5- VLAD vs JUN Specials", {
				final ip = _5VladVsJunSpecials;
				Main.process( ip.champions, ip.actions ).should.be( "JUN beats VLAD in 6 hits" );
			});
			it( "6- KEN vs TANK Specials", {
				final ip = _6KenVsTankSpecials;
				Main.process( ip.champions, ip.actions ).should.be( "KEN beats TANK in 7 hits" );
			});
			it( "7-VLAD vs RYU Special VLAD Kill", {
				final ip = _7VladVsRyuSpecialVladKill;
				Main.process( ip.champions, ip.actions ).should.be( "VLAD beats RYU in 5 hits" );
			});
			it( "8-JUN vs KEN long story", {
				final ip = _8JunVsKenLongStory;
				Main.process( ip.champions, ip.actions ).should.be( "KEN beats JUN in 11 hits" );
			});
			it( "9-ANNA vs JADE round 1", {
				final ip = _9AnnaVsJadeRound_1;
				Main.process( ip.champions, ip.actions ).should.be( "JADE beats ANNA in 4 hits" );
			});
			it( "10-ANNA vs JADE", {
				final ip = _10AnnaVsJade;
				Main.process( ip.champions, ip.actions ).should.be( "JADE beats ANNA in 4 hits" );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
			
		final champions = lines[0].split(' ');
		final n = parseInt( lines[1] );
		final actions = [for( i in 0...n ) {
			final inputs = lines[i + 2].split(" ");
			final direction = inputs[0];
			final attack = inputs[1];
			{ direction: direction, attack:attack };
		}];
	
		return { champions: champions, actions: actions };
	}

	final _1KenVsRyu = parseInput(
		"KEN RYU
		4
		< KICK
		< PUNCH
		> KICK
		< PUNCH"
	);

	final _2KenVsVladKickOnly = parseInput(
		"KEN VLAD
		10
		> KICK
		< KICK
		> KICK
		< KICK
		> KICK
		< KICK
		> KICK
		< KICK
		> KICK
		< KICK"
	);

	final _3AnnaVsJunPunchOnly = parseInput(
		"ANNA JUN
		10
		> PUNCH
		< PUNCH
		> PUNCH
		< PUNCH
		> PUNCH
		< PUNCH
		> PUNCH
		< PUNCH
		> PUNCH
		< PUNCH"
	);

	final _4TankVsJadePunchKick = parseInput(
		"TANK JADE
		10
		> PUNCH
		< KICK
		> PUNCH
		< KICK
		> PUNCH
		< KICK
		> PUNCH
		< KICK
		> PUNCH
		< KICK"
	);

	final _5VladVsJunSpecials = parseInput(
		"VLAD JUN
		12
		> PUNCH
		< PUNCH
		> KICK
		< KICK
		> PUNCH
		< PUNCH
		> PUNCH
		< KICK
		> KICK
		< KICK
		< SPECIAL
		> SPECIAL"
	);

	final _6KenVsTankSpecials = parseInput(
		"KEN TANK
		14
		> PUNCH
		< PUNCH
		> KICK
		< KICK
		> PUNCH
		< PUNCH
		< SPECIAL
		> SPECIAL
		> PUNCH
		< KICK
		> KICK
		< KICK
		< SPECIAL
		> SPECIAL"
	);

	final _7VladVsRyuSpecialVladKill = parseInput(
		"VLAD RYU
		14
		< PUNCH
		< PUNCH
		< KICK
		< KICK
		< PUNCH
		> PUNCH
		> KICK
		> SPECIAL
		> PUNCH
		< KICK
		> KICK
		< KICK
		< SPECIAL
		> SPECIAL"
	);

	final _8JunVsKenLongStory = parseInput(
		"JUN KEN
		30
		< PUNCH
		< PUNCH
		< KICK
		< KICK
		< PUNCH
		> PUNCH
		> KICK
		> SPECIAL
		> PUNCH
		< KICK
		> KICK
		< KICK
		< SPECIAL
		> SPECIAL
		> PUNCH
		< PUNCH
		< KICK
		> PUNCH
		< KICK
		> PUNCH
		< KICK
		< SPECIAL
		> SPECIAL
		> SPECIAL
		< KICK
		> PUNCH
		< KICK
		> KICK
		< KICK
		> SPECIAL"
	);

	final _9AnnaVsJadeRound_1 = parseInput(
		"ANNA JADE
		30
		< PUNCH
		< PUNCH
		< KICK
		< KICK
		< PUNCH
		> PUNCH
		> KICK
		> SPECIAL
		> PUNCH
		< KICK
		> KICK
		< KICK
		< SPECIAL
		> SPECIAL
		> PUNCH
		< PUNCH
		< KICK
		> PUNCH
		< KICK
		> PUNCH
		< KICK
		< SPECIAL
		> SPECIAL
		< KICK
		< KICK
		> PUNCH
		< KICK
		> KICK
		< KICK
		> SPECIAL"
	);

	final _10AnnaVsJade = parseInput(
		"ANNA JADE
		30
		< PUNCH
		< KICK
		> SPECIAL
		< KICK
		> KICK
		< KICK
		> PUNCH
		> PUNCH
		< SPECIAL
		> KICK
		< KICK
		> PUNCH
		< KICK
		> KICK
		< PUNCH
		< KICK
		< KICK
		< PUNCH
		> PUNCH
		> KICK
		> SPECIAL
		> PUNCH
		< KICK
		> KICK
		< KICK
		< SPECIAL
		> SPECIAL
		> PUNCH
		< PUNCH
		< KICK"
	);
}
