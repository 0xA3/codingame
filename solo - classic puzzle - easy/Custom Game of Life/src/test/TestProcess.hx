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
			it( "Stable", {
				final ip = stable;
				Main.process( ip.w, ip.h, ip.n, ip.alive, ip.dead, ip.lines ).should.be( stableResult );
			});
			it( "1 turn", {
				final ip = _1Turn;
				Main.process( ip.w, ip.h, ip.n, ip.alive, ip.dead, ip.lines ).should.be( _1TurnResult );
			});
			it( "Oscillator", {
				final ip = oscillator;
				Main.process( ip.w, ip.h, ip.n, ip.alive, ip.dead, ip.lines ).should.be( oscillatorResult );
			});
			it( "Spaceship 4 turns", {
				final ip = spaceship4Turns;
				Main.process( ip.w, ip.h, ip.n, ip.alive, ip.dead, ip.lines ).should.be( spaceship4TurnsResult );
			});
			it( "New rules, simple", {
				final ip = newRulesSimple;
				Main.process( ip.w, ip.h, ip.n, ip.alive, ip.dead, ip.lines ).should.be( newRulesSimpleResult );
			});
			it( "A bit more complex", {
				final ip = aBitMoreComplex;
				Main.process( ip.w, ip.h, ip.n, ip.alive, ip.dead, ip.lines ).should.be( aBitMoreComplexResult );
			});
			it( "Weird rules", {
				final ip = weirdRules;
				Main.process( ip.w, ip.h, ip.n, ip.alive, ip.dead, ip.lines ).should.be( weirdRulesResult );
			});
			it( "Complex rules, more turns", {
				final ip = complexRulesMoreTurns;
				Main.process( ip.w, ip.h, ip.n, ip.alive, ip.dead, ip.lines ).should.be( complexRulesMoreTurnsResult );
			});
			it( "Insane (20x20, random rules and grid)", {
				final ip = insane20x20RandomRulesAndGrid;
				Main.process( ip.w, ip.h, ip.n, ip.alive, ip.dead, ip.lines ).should.be( insane20x20RandomRulesAndGridResult );
			});
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final inputs = lines[0].split(' ');
		final h = parseInt( inputs[0] );
		final w = parseInt( inputs[1] );
		final n = parseInt( inputs[2] );
		final alive = lines[1];
		final dead = lines[2];
		final lines = [for( i in 0...h ) lines[3 + i]];
	
		return { w: w, h: h, n: n, alive: alive, dead: dead, lines: lines };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final stable = parseInput(
		"3 4 1
		001100000
		000100000
		.OO.
		O..O
		.OO."
	);

	final stableResult = parseResult(
		".OO.
		O..O
		.OO."
	);

	final _1Turn = parseInput(
		"5 5 1
		001100000
		000100000
		.....
		.OOO.
		.OOO.
		.OOO.
		....."
	);

	final _1TurnResult = parseResult(
		"..O..
		.O.O.
		O...O
		.O.O.
		..O.."
	);

	final oscillator = parseInput(
		"3 3 3
		001100000
		000100000
		.O.
		.O.
		.O."
	);

	final oscillatorResult = parseResult(
		"...
		OOO
		..."
	);

	final spaceship4Turns = parseInput(
		"4 4 4
		001100000
		000100000
		..O.
		O.O.
		.OO.
		...."
	);

	final spaceship4TurnsResult = parseResult(
		"....
		...O
		.O.O
		..OO"
	);

	final newRulesSimple = parseInput(
		"4 4 1
		000100000
		001100000
		....
		.OOO
		.O..
		...."
	);

	final newRulesSimpleResult = parseResult(
		".OOO
		O.O.
		O..O
		...."
	);

	final aBitMoreComplex = parseInput(
		"5 5 1
		010100000
		001000000
		.....
		.OO..
		..OO.
		...O.
		....."
	);

	final aBitMoreComplexResult = parseResult(
		".OO..
		..O..
		...OO
		....O
		....."
	);

	final weirdRules = parseInput(
		"6 6 1
		100000001
		100000001
		...OOO
		...O.O
		...OOO
		.OO..O
		..OO..
		......"
	);

	final weirdRulesResult = parseResult(
		"OO....
		OO..O.
		......
		......
		......
		O....O"
	);

	final complexRulesMoreTurns = parseInput(
		"10 10 8
		000110000
		001000000
		..........
		.OO.OOO...
		..OO..OOO.
		..O..OO...
		....O..OOO
		...O..OO..
		..........
		OOOO...OO.
		OOOOOOOOOO
		....OOO.OO"
	);

	final complexRulesMoreTurnsResult = parseResult(
		".......O..
		.OO.O..O..
		O.O....OO.
		O....OO.O.
		O....O...O
		OO...OOOO.
		.........O
		.O..O..OO.
		.OOO......
		.........O"
	);

	final insane20x20RandomRulesAndGrid = parseInput(
		"20 20 15
		101110010
		011011000
		OOO.OO.O.O..OOO..OOO
		.O.O..OOOOOO.OO.O.O.
		OO.OOO.O..OOO.O..O..
		..OOO....OO..OOO....
		OOO..O..OO.O...OOOO.
		OOOOO...OO.OO.OOOOOO
		OO.O.........OO.O.O.
		O..OOOO.O.OO.O.OOO..
		O..O...O.OO...OOOOOO
		...OOOOOO.OO...O.OO.
		...O...OOOOO...O.O..
		...OO...OO...OO..OO.
		....O..OOO...OOOO.O.
		..OO...OO.OOOO.....O
		OOOO.OOOO.O.OO......
		O..OO.O..OOO...OOO..
		O.O.O..OOO..OO.O.O..
		OOOOO.O..O..OO..O...
		O...OOOO.O..O...O...
		.O...O....OOOOO...O."
	);

	final insane20x20RandomRulesAndGridResult = parseResult(
		"OOOOOOOOOOOOOOOOO..O
		OO..OOO.....OOOO..OO
		O.OO.O.OOOOOOOO.OO.O
		OO..OOOO.OO..OO.OO..
		O...OO.OOO.OOOOO...O
		O...OO.O.O.OOOOO....
		OOOOOO....OOO.OOO.O.
		O.OOOO....OO.OOOOO.O
		O.O..O......OO..OOOO
		O.OOOOOO.OO..O.OO.OO
		O.O..OOOOO..OOOO.O.O
		OOO..O..OOOOOOOOOOOO
		OO.O..OOOOOO.O.OOO..
		OOOO...OOO.OOOOOOOOO
		OOOOO...OOOOO.OOOOO.
		OOO.O.O.OO.O.OO....O
		OO.O.O...OOOOO.OOO.O
		OOO.......OOOO.OO.O.
		O..O.......O.OOOOOOO
		OOOOOOOOOOOOOOOOOOOO"
	);



}

