package test;

import Std.parseInt;
import haxe.ds.Either;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "#1: Lev Yashin, the goalkeeper", Main.process( test1 ).should.be( test1Result ));
			it( "#2: Cafu, the Right Back", Main.process( test2 ).should.be( test2Result ));
			it( "#3: Marcelo / Roberto Carlos, the Left Back", Main.process( test3 ).should.be( test3Result ));
			it( "#4: Sergio Ramos, the Center Back", Main.process( test4 ).should.be( test4Result ));
			it( "#5: Beckenbauer, der Kaiser, the Libéro", Main.process( test5 ).should.be( test5Result ));
			it( "#6: Sergio Busquets, The Defensive Midfielder", Main.process( test6 ).should.be( test6Result ));
			it( "#7: CR7, Raul, Emilio Butragueño", Main.process( test7 ).should.be( test7Result ));
			it( "#8: Don Alfredo (Di Stéfano), Johan Cruyff, Zizou", Main.process( test8 ).should.be( test8Result ));
			it( "#9: Karim Benzema", Main.process( test9 ).should.be( test9Result ));
			it( "#10: Pelé, Messi, Maradona, Modric", Main.process( test10 ).should.be( test10Result ));
			it( "#11: Romario, Salah, Ribery, the Second Striker / Wing Forward", Main.process( test11 ).should.be( test11Result ));
			it( "#12: The fans, the Ultras, aka the 12th man!", Main.process( test12 ).should.be( test12Result ));
			it( "#13: Ted Lasso, the Coach, the Manager", Main.process( test13 ).should.be( test13Result ));
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		return lines.map( line -> line.split( "" ));
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"###################################################
		#........................#........................#
		#.......................a#........................#
		#...............b.o......#........................#
		#######..................#..................#######
		#.....#......a...b.......b...........a......#.....#
		#.....#......b.......a..a#....b.............#.....#
		#..b..#........A.........#..................#.....#
		#.....#...........b....b.#..............a...#.....#
		#.....#....A.............#..................#.....#
		#######.......b..........#..................#######
		#.....................a..#.......b................#
		#........................#..........a.............#
		#........................#....b...................#
		###################################################"
	);

	final test1Result = parseResult(
		"1 player(s) in an offside position.
		VAR: OFFSIDE!"
	);

	final test2 = parseInput(
		"###################################################
		#........................#........................#
		#.......................a#........................#
		#...............b.o......#........................#
		#######..................#..................#######
		#.....#......a...b.......b...........a......#.....#
		#.....#......b.......a..a#....b.............#.....#
		#..b..#........A.........#..................#.....#
		#.....#...........b....b.#..............a...#.....#
		#.....#....a.............#..................#.....#
		#######.......b..........#..................#######
		#.....................a..#.......b................#
		#........................#..........a.............#
		#........................#....b...................#
		###################################################"
	);

	final test2Result = parseResult(
		"1 player(s) in an offside position.
		VAR: ONSIDE!"
	);
	
	final test3 = parseInput(
		"##################o################################
		#........................#........................#
		#.......................a#........................#
		#...............b........#........................#
		#######..................#..................#######
		#.....#......a...b.......b...........a......#.....#
		#.....#......b.......a..a#....b.............#.....#
		#..b..#........A.........#..................#.....#
		#.....#...........b....b.#..............a...#.....#
		#.....#....A.............#..................#.....#
		#######.......b..........#..................#######
		#.....................a..#.......b................#
		#........................#..........a.............#
		#........................#....b...................#
		###################################################"
	);

	final test3Result = parseResult(
		"No player in an offside position.
		VAR: ONSIDE!"
	);
	
	final test4 = parseInput(
		"###################################################
		#........................#........................#
		#.......................a#........................#
		#...............a........#........................#
		#######..................#..................#######
		#.....#......a...b.......b...........a......#.....#
		#.....#......b.......a..a#....b.............#.....#
		#..b..#........a.........#..................#.....#
		#.....#...........b....b.#..................#.....#
		#.....#....a.............#..............B...#.....#
		#######.......a....O.....#..................#######
		#.....................a..#.......a................#
		#........................#..........B.............#
		#........................#....b...................#
		###################################################"
	);

	final test4Result = parseResult(
		"2 player(s) in an offside position.
		VAR: OFFSIDE!"
	);
	
	final test5 = parseInput(
		"###################################################
		#........................#........................#
		#.............a..........#........................#
		#..............a.........#........................#
		#######....b.............#..................#######
		#.....#....b.............#..................#.....#
		b...a.ba.................#..................#.....#
		#....abba................#..B...............#.....#
		#.....bb.................#..................#.....#
		#....baa..........a......#..................#.....#
		#####O#.a................#..................#######
		#..a.....................#........................#
		#........................#........................#
		#........................#........................#
		###################################################"
	);

	final test5Result = parseResult(
		"1 player(s) in an offside position.
		VAR: OFFSIDE!"
	);
	
	final test6 = parseInput(
		"###################################################
		#........................#........................#
		#.............a..........#........................#
		#..............a.........#........................#
		#######....b.............#..................#######
		#.....#..................#.........b........#.....#
		b...a.ba.................#..................#.....#
		#....abba................#.....aB...........#.....#
		#.....bb.................#..................#.....#
		#....baa.................#........O.........#.....#
		#######.a................#..................#######
		#..a.....................#........................#
		#........................#........................#
		#........................#........................#
		###################################################"
	);

	final test6Result = parseResult(
		"1 player(s) in an offside position.
		VAR: ONSIDE!"
	);
	
	final test7 = parseInput(
		"###################################################
		#........................#.......a.b..............#
		#.o...b......b.......b...#.a.........a.a..........#
		#.....ba...........b.....#........................#
		#######..................#...............a..#######
		#.....#..................#..............a...#.....#
		#.....#......b...........#..................#.a...#
		#.....#..................#..................#.....#
		#.....#..................#..................#.....#
		#.....#.......b..b.......#..........a....b..#.....#
		#######................a.#..................#######
		#........................#........b...............#
		#........................#........................#
		#........................#........................#
		###################################################"
	);

	final test7Result = parseResult(
		"No player in an offside position.
		VAR: ONSIDE!"
	);
	
	final test8 = parseInput(
		"###################################################
		#........................#.......a.b..............#
		#.A...b......b.......b...#.a.........a.a..........#
		#.....bo...........b.....#........................#
		#######..................#...............a..#######
		#.....#..................#..............a...#.....#
		#.....#......b...........#..................#.a...#
		#.....#..................#..................#.....#
		#.....#..................#..................#.....#
		#.....#.......b..b.......#..........a....b..#.....#
		#######................a.#..................#######
		#........................#........b...............#
		#........................#........................#
		#........................#........................#
		###################################################"
	);

	final test8Result = parseResult(
		"1 player(s) in an offside position.
		VAR: OFFSIDE!"
	);
	
	final test9 = parseInput(
		"###################################################
		#........................#........................#
		#.......................a#........................#
		#...............a........#........................#
		#######..................#..................#######
		#.....#......a...b.......b...........a......#.....#
		#.....#......b.......b..a#....b.............#.....#
		#..b..#........a.........#..................#.....#
		#.....#...........b....b.#..................#.....#
		#.....#....A.............#..............b...#.....#
		#######.......A..........#..................#######
		#.....................A..#........................#
		#........................A..........b.............#
		#........................#....b...................#
		#############################o#####################"
	);

	final test9Result = parseResult(
		"No player in an offside position.
		VAR: ONSIDE!"
	);
	
	final test10 = parseInput(
		"###################################################
		#........................#....a...................#
		#........................#........................#
		#........................#........................#
		#######..................#.......b........b.#######
		#.....#.................b#...............a..#.....#
		#.....#..................#..........ab......#.....#
		#.....#..................#....b..........b..#.....#
		#.....#..................#..b.....a.........#..o..#
		#.....#...........a......#..................#.....#
		#######..................#.A....b...........#######
		#........................#...............b........#
		#.......................b#...A..........b.....a...#
		#.......................a#.......a................#
		###################################################"
	);

	final test10Result = parseResult(
		"1 player(s) in an offside position.
		VAR: ONSIDE!"
	);
	
	final test11 = parseInput(
		"###################################################
		#........................#....a...................#
		#........................#........................#
		#........................#........................#
		#######..................#.......b........b.#######
		#.....#.................b#...............a..#.....#
		#.....#..................#..........ab......#.....#
		#.....#..................#....b..........b..#.....#
		#.....#..................#..o.....b.........#..a..#
		#.....#..................#..................#.....#
		#######..................a......b...........#######
		#........................#...............b.......a#
		#........................#...A..........b.....a...#
		#.......................a#.......A................#
		##############################b####################"
	);

	final test11Result = parseResult(
		"1 player(s) in an offside position.
		VAR: ONSIDE!"
	);
	
	final test12 = parseInput(
		"###################################################
		#........................#....a...................#
		#........................#........................#
		#........................#........................#
		#######..................#.......b........b.#######
		#.....#.................b#...............a..#.....#
		#.....#......A...........#..........ab......#.....#
		#.....#..................#....b..........b..#.....#
		#.....#...........o......#..................#..a..#
		#.....#.b................#..................#.....#
		#######..................a......b...........#######
		#........................#...............b........#
		#........................#...a..........b.....a...#
		#.....................a..#.......a................#
		##############################b####################"
	);

	final test12Result = parseResult(
		"1 player(s) in an offside position.
		VAR: OFFSIDE!"
	);
	
	final test13 = parseInput(
		"###################################################
		#........................#........................#
		#.............a..........#........................#
		#..........b.............#........................#
		#######....b.............#..................#######
		#.....#..................#..................#.....#
		b...aOba.................#..................#.....#
		#....abba................#..................#.....#
		#....bab.a...............#..................#.....#
		#....b.a............B....#..................#.....#
		######a.a................#..................#######
		#..a.....................#........................#
		#........................#........................#
		#........................#........................#
		###################################################"
	);

	final test13Result = parseResult(
		"No player in an offside position.
		VAR: ONSIDE!"
	);
}
