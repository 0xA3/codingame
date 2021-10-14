package test;

import Std.parseInt;
import TAction;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test LCG", {
			it( "first rand", {
				final lgc = new LinearCongruentalGenerator( 12 );
				lgc.rand().should.be( 0 );
			});
		});
		
		describe( "Test AI", {
			
			var ai:Ai;

			beforeEach({
				ai = new Ai( "Ai", [], new LinearCongruentalGenerator( 12 ));
			});
			it( "last action Defect", {
				ai.addAction( Cooperate );
				ai.addAction( Defect );
				ai.lastAction.should.equal( Defect );
			});
			it( "dominating action Defect", {
				ai.addAction( Cooperate );
				ai.addAction( Defect );
				ai.getDominatingAction( Defect ).should.be( false );
			});
			it( "dominating action Defect", {
				ai.addAction( Cooperate );
				ai.addAction( Defect );
				ai.addAction( Defect );
				ai.getDominatingAction( Defect ).should.be( true );
			});
			it( "dominating action of last 3 Defect", {
				ai.addAction( Defect );
				ai.getDominatingActionOfLast( 3, Defect ).should.be( true );
			});
			it( "dominating action of last 3 Cooperate", {
				ai.addAction( Defect );
				ai.addAction( Defect );
				ai.addAction( Defect );
				ai.addAction( Cooperate );
				ai.addAction( Cooperate );
				ai.getDominatingActionOfLast( 3, Cooperate ).should.be( true );
			});
		});
		
		describe( "Test process", {
			it( "Nice guys", {
				final ip = niceGuys;
				Main.process( ip.nbturns, ip.ai1, ip.commands1, ip.ai2, ip.commands2 ).should.be( "DRAW" );
			});
			it( "No more Mr nice guy", {
				final ip = noMoreMrNiceGuy;
				Main.process( ip.nbturns, ip.ai1, ip.commands1, ip.ai2, ip.commands2 ).should.be( "BadGuy" );
			});
			it( "Two Jokers", {
				final ip = twoJokers;
				Main.process( ip.nbturns, ip.ai1, ip.commands1, ip.ai2, ip.commands2 ).should.be( "Joker2" );
			});
			it( "Tit for tat", {
				final ip = titForTat;
				Main.process( ip.nbturns, ip.ai1, ip.commands1, ip.ai2, ip.commands2 ).should.be( "Joker" );
			});
			it( "Nice guy but don’t fool me", {
				final ip = niceGuyButDontFoolMe;
				Main.process( ip.nbturns, ip.ai1, ip.commands1, ip.ai2, ip.commands2 ).should.be( "DRAW" );
			});
			it( "Short memory nice guy", {
				final ip = shortMemoryNiceGuy;
				Main.process( ip.nbturns, ip.ai1, ip.commands1, ip.ai2, ip.commands2 ).should.be( "BirdyNiceGuy" );
			});
			it( "Machiavel", {
				final ip = machiavel;
				Main.process( ip.nbturns, ip.ai1, ip.commands1, ip.ai2, ip.commands2 ).should.be( "FlipFlop" );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final nbturns = parseInt( lines[0] );
		var inputs = lines[1].split(' ');
		final n = parseInt( inputs[0] );
		final ai1 = inputs[1];
		final commands1 = [for( i in 0...n ) lines[i + 2]];
		
		var inputs = lines[n + 2].split(' ');
		final m = parseInt( inputs[0] );
		final ai2 = inputs[1];
		final commands2 = [for( i in 0...m ) lines[n + i + 3]];

		return { nbturns: nbturns, ai1: ai1, commands1: commands1, ai2: ai2, commands2: commands2 }
	}
	
	final niceGuys = parseInput(
		"100
		1 NiceGuy1
		* C
		1 NiceGuy2
		* C"
	);

	final noMoreMrNiceGuy = parseInput(
		"1000
		4 MrNiceGuy
		START C
		ME -1 D D
		OPP -1 D D
		* C
		1 BadGuy
		* D"
	);

	final twoJokers = parseInput(
		"100
		1 Joker1
		* RAND
		1 Joker2
		* RAND"
	);

	final titForTat = parseInput(
		"100
		1 Joker
		* RAND
		3 TitForTat
		START C
		OPP -1 C C
		OPP -1 D D"
	);

	final niceGuyButDontFoolMe = parseInput(
		"100
		3 NiceGuyBut
		START C
		OPP MAX D D
		* C
		3 FlipFlop
		START RAND
		ME -1 D C
		ME -1 C D"
	);

	final shortMemoryNiceGuy = parseInput(
		"100
		3 BirdyNiceGuy
		START C
		OPP LAST 3 D D
		* C
		3 TitForTat
		START RAND
		OPP -1 D C
		OPP -1 C D"
	);

	final machiavel = parseInput(
		"100
		3 Machiavel
		START C
		ME WIN D
		* C
		3 FlipFlop
		START RAND
		ME -1 D C
		ME -1 C D"
	);

}

