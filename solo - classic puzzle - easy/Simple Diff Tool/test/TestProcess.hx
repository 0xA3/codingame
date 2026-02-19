package test;

import CodinGame.printErr;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Add by content", {
				final ip = addByContent;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( addByContentResult );
			});
			
			it( "Add by number", {
				final ip = addByNumber;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( addByNumberResult );
			});
			
			it( "Delete by content", {
				final ip = deleteByContent;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( deleteByContentResult );
			});
			
			it( "Delete by number", {
				final ip = deleteByNumber;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( deleteByNumberResult );
			});
			
			it( "Change by content", {
				final ip = changeByContent;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( changeByContentResult );
			});
			
			it( "Change by number", {
				final ip = changeByNumber;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( changeByNumberResult );
			});
			
			it( "No diffs by content", {
				final ip = noDiffsByContent;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( noDiffsByContentResult );
			});
			
			it( "No diffs by number", {
				final ip = noDiffsByNumber;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( noDiffsByNumberResult );
			});
			
			it( "Moved lines by content", {
				final ip = movedLinesByContent;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( movedLinesByContentResult );
			});
			
			it( "Moved lines by number", {
				final ip = movedLinesByNumber;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( movedLinesByNumberResult );
			});
			
			it( "Multiple diffs by content", {
				final ip = multipleDiffsByContent;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( multipleDiffsByContentResult );
			});
			
			it( "Multiple diffs by number", {
				final ip = multipleDiffsByNumber;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( multipleDiffsByNumberResult );
			});
			
			it( "No lines by content", {
				final ip = noLinesByContent;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( noLinesByContentResult );
			});
			
			it( "No lines by number", {
				final ip = noLinesByNumber;
				Main.process( ip.type, ip.linesV1, ip.linesV2 ).should.be( noLinesByNumberResult );
			});
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		final type = readline();
		final nbLinesV1 = parseInt(readline());
		final linesV1 = [for( _ in 0...nbLinesV1 ) readline()];
		final nbLinesV2 = parseInt(readline());
		final linesV2 = [for( _ in 0...nbLinesV2 ) readline()];
				
		return { type: type, linesV1: linesV1, linesV2: linesV2 };
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final addByContent = parseInput(
		"BY_CONTENT
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		4
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		Some experience points are awarded on tasks achievement"
	);
	
	final addByContentResult = parseResult(
		"ADD: Some experience points are awarded on tasks achievement"
	);
	
	final addByNumber = parseInput(
		"BY_NUMBER
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		4
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		Some experience points are awarded on tasks achievement
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence."
	);
	
	final addByNumberResult = parseResult(
		"ADD: The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		CHANGE: The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence. ---> Some experience points are awarded on tasks achievement"
	);
	
	final deleteByContent = parseInput(
		"BY_CONTENT
		3
		CodinGame is a fun website to learn programming skills.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		It supports a large set of programming languages.
		2
		CodinGame is a fun website to learn programming skills.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence."
	);
	
	final deleteByContentResult = parseResult(
		"DELETE: It supports a large set of programming languages."
	);
	
	final deleteByNumber = parseInput(
		"BY_NUMBER
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		2
		CodinGame is a fun website to learn programming skills.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence."
	);
	
	final deleteByNumberResult = parseResult(
		"CHANGE: It supports a large set of programming languages. ---> The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		DELETE: The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence."
	);
	
	final changeByContent = parseInput(
		"BY_CONTENT
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		3
		CodinGame is a fun website to learn programming skills.
		Some experience points are awarded on tasks achievement
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence."
	);
	
	final changeByContentResult = parseResult(
		"ADD: Some experience points are awarded on tasks achievement
		DELETE: It supports a large set of programming languages."
	);
	
	final changeByNumber = parseInput(
		"BY_NUMBER
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		3
		CodinGame is a fun website to learn programming skills.
		Some experience points are awarded on tasks achievement
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence."
	);
	
	final changeByNumberResult = parseResult(
		"CHANGE: It supports a large set of programming languages. ---> Some experience points are awarded on tasks achievement"
	);
	
	final noDiffsByContent = parseInput(
		"BY_CONTENT
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence."
	);
	
	final noDiffsByContentResult = parseResult(
		"No Diffs"
	);
	
	final noDiffsByNumber = parseInput(
		"BY_NUMBER
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence."
	);
	
	final noDiffsByNumberResult = parseResult(
		"No Diffs"
	);
	
	final movedLinesByContent = parseInput(
		"BY_CONTENT
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		3
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages."
	);
	
	final movedLinesByContentResult = parseResult(
		"MOVE: CodinGame is a fun website to learn programming skills. @:1 >>> @:2
		MOVE: It supports a large set of programming languages. @:2 >>> @:3
		MOVE: The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence. @:3 >>> @:1"
	);
	
	final movedLinesByNumber = parseInput(
		"BY_NUMBER
		3
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages.
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		3
		The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		CodinGame is a fun website to learn programming skills.
		It supports a large set of programming languages."
	);
	
	final movedLinesByNumberResult = parseResult(
		"CHANGE: CodinGame is a fun website to learn programming skills. ---> The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence.
		CHANGE: It supports a large set of programming languages. ---> CodinGame is a fun website to learn programming skills.
		CHANGE: The progression path is divided in four parts: development speed, algorithms, optimisation and artificial intelligence. ---> It supports a large set of programming languages."
	);
	
	final multipleDiffsByContent = parseInput(
		"BY_CONTENT
		11
		Bot programming games are multiplayer games with a game loop.
		There are no test cases to pass.
		The goal is not to output a solution but to create a bot (an AI) capable of playing a game in the given environment.
		Participants play against themselves in matches of 2 to 4 players in an arena.
		Once players submit their code (AI) in the arena, the system matches them against other players of the arena.
		Each match between players impacts their score, hence their ranking.
		The game is divided into several leagues.
		You start in the Wood leagues with a simplified version of the game.
		When ranking up, you'll be promoted to new leagues: Bronze, Silver, Gold and finally Legend.
		In each league but the last (Legend), there is a reference bot: the boss.
		Any player who ends up above the boss' score after their ranking battles are finished will be promoted to the league above.
		10
		Bot programming games are multiplayer games with a game loop.
		There are no test cases to pass.
		The goal is to create a bot (an AI) capable of playing a game in the given environment.
		Participants play against each others in several matches.
		Once players submit their code (AI) in the arena, the system matches them against other players of the arena.
		Each match between players impacts their score, hence their ranking.
		The game is divided into several leagues.
		Each time a player reaches a new league he awards some experience points.
		In each league but the last (Legend), there is a reference bot: the boss.
		Any player who ends up above the boss' score after their ranking battles are finished will be promoted to the league above."
	);
	
	final multipleDiffsByContentResult = parseResult(
		"ADD: Each time a player reaches a new league he awards some experience points.
		ADD: Participants play against each others in several matches.
		ADD: The goal is to create a bot (an AI) capable of playing a game in the given environment.
		DELETE: Participants play against themselves in matches of 2 to 4 players in an arena.
		DELETE: The goal is not to output a solution but to create a bot (an AI) capable of playing a game in the given environment.
		DELETE: When ranking up, you'll be promoted to new leagues: Bronze, Silver, Gold and finally Legend.
		DELETE: You start in the Wood leagues with a simplified version of the game.
		MOVE: Any player who ends up above the boss' score after their ranking battles are finished will be promoted to the league above. @:11 >>> @:10
		MOVE: In each league but the last (Legend), there is a reference bot: the boss. @:10 >>> @:9"
	);
	
	final multipleDiffsByNumber = parseInput(
		"BY_NUMBER
		11
		Bot programming games are multiplayer games with a game loop.
		There are no test cases to pass.
		The goal is not to output a solution but to create a bot (an AI) capable of playing a game in the given environment.
		Participants play against themselves in matches of 2 to 4 players in an arena.
		Once players submit their code (AI) in the arena, the system matches them against other players of the arena.
		Each match between players impacts their score, hence their ranking.
		The game is divided into several leagues.
		You start in the Wood leagues with a simplified version of the game.
		When ranking up, you'll be promoted to new leagues: Bronze, Silver, Gold and finally Legend.
		In each league but the last (Legend), there is a reference bot: the boss.
		Any player who ends up above the boss' score after their ranking battles are finished will be promoted to the league above.
		10
		Bot programming games are multiplayer games with a game loop.
		There are no test cases to pass.
		The goal is to create a bot (an AI) capable of playing a game in the given environment.
		Participants play against themselves in matches of 2 to 4 players in an arena.
		Once players submit their code (AI) in the arena, the system matches them against other players of the arena.
		Each match between players impacts their score, hence their ranking.
		The game is divided into several leagues: Woods, Bronze, Silver, Gold and finally Legend
		You start in the Wood leagues with a simplified version of the game.
		In each league but the last (Legend), there is a reference bot: the boss.
		Any player who ends up above the boss' score after their ranking battles are finished will be promoted to the league above."
	);
	
	final multipleDiffsByNumberResult = parseResult(
		"CHANGE: In each league but the last (Legend), there is a reference bot: the boss. ---> Any player who ends up above the boss' score after their ranking battles are finished will be promoted to the league above.
		CHANGE: The game is divided into several leagues. ---> The game is divided into several leagues: Woods, Bronze, Silver, Gold and finally Legend
		CHANGE: The goal is not to output a solution but to create a bot (an AI) capable of playing a game in the given environment. ---> The goal is to create a bot (an AI) capable of playing a game in the given environment.
		CHANGE: When ranking up, you'll be promoted to new leagues: Bronze, Silver, Gold and finally Legend. ---> In each league but the last (Legend), there is a reference bot: the boss.
		DELETE: Any player who ends up above the boss' score after their ranking battles are finished will be promoted to the league above."
	);
	
	final noLinesByContent = parseInput(
		"BY_CONTENT
		0
		0"
	);
	
	final noLinesByContentResult = parseResult(
		"No Diffs"
	);
	
	final noLinesByNumber = parseInput(
		"BY_NUMBER
		0
		0"
	);
	
	final noLinesByNumberResult = parseResult(
		"No Diffs"
	);
}