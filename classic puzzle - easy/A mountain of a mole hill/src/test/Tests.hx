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
			
			it( "A simple garden", {
				Main.process( aSimpleGarden ).should.be( 2 );
			});
			
			it( "From another angle", {
				Main.process( fromAnotherAngle ).should.be( 3 );
			});
			
			it( "Getting crowded", {
				Main.process( gettingCrowded ).should.be( 10 );
			});
			
			it( "Divide and conquer", {
				Main.process( divideAndConquer ).should.be( 9 );
			});
			
			it( "Bag of snakes", {
				Main.process( bagOfSnakes ).should.be( 13 );
			});
			
			it( "Zzzzz...", {
				Main.process( zzzzz ).should.be( 5 );
			});
			
			it( "Include and infiltrate", {
				Main.process( includeAndInfiltrate ).should.be( 20 );
			});
			
			it( "How did THAT happen?", {
				Main.process( howDitTHATHappen ).should.be( 74 );
			});
			
			
		});

	}

	static function parseInput( input:String ) {
		return input.split( "\n" ).map( line -> line.trim());
	}

	final aSimpleGarden = parseInput(
	"................
	................
	..+----------+..
	..|          |..
	..|   o      |..
	..|      o   |..
	..|          |..
	..+----------+..
	................
	............o...
	.....o..........
	................
	.........o......
	................
	................
	................" );

	final fromAnotherAngle = parseInput(
	"................
	................
	...+-------+.o..
	.o.|  o o  |..o.
	...|       |....
	...| o  +--+.oo.
	...|    |.......
	...+----+.......
	................
	........oo......
	................
	...o............
	................
	...........o....
	................
	................" );

	final gettingCrowded = parseInput(
	"................
	................
	.oo.+------+oooo
	.oo.|  o   |.oo.
	oooo|oooooo|....
	....+--+ o |.oo.
	.......| o |....
	....oo.|o ++.oo.
	....oo.+--+o.oo.
	................
	......ooo.......
	................
	................
	................
	................
	................" );

	final divideAndConquer = parseInput(
	"+--+....o..o....
	| o|............
	|  |......o.....
	|o +---+........
	|      |....+--+
	|  o   |....|oo|
	|      |....|oo|
	+------+..o.+--+
	................
	.....oo.........
	................
	+--------------+
	|          o   |
	|          o   |
	|              |
	+--------------+" );

	final bagOfSnakes = parseInput(
	".....o..........
	.+-------+..o.o.
	.|       |.oo...
	.|    o  |ooooo.
	.|       |oo....
	.|oo+-+oo+--+oo.
	.|  |.|     |o..
	.|  |.|     +-+.
	.|oo|o|       |.
	.|  |.|       |.
	.|  |.|ooo   o|.
	.|  |.|       |.
	.|  |.|  oo   |.
	.|  |.|       |.
	.+--+o+-------+.
	...............o" );

	final zzzzz = parseInput(
	"+--------------+
	|    o       o |
	+----------+  ++
	..........++ ++.
	....o....++ ++..
	........++ ++...
	.......++ ++....
	.oo...++o++...o.
	.....++ ++......
	....++ ++.......
	...++ ++....oo..
	..++ ++....o....
	.++ ++..........
	++o +----------+
	|       o      |
	+--------------+" );

	final includeAndInfiltrate = parseInput(
	"+--------------+
	|   o      oo  |
	| +----------+o|
	| |..........| |
	| |.+------+o|o|
	| |.|      |.| |
	| |o| +--+o|.| |
	| |.| |oo|o|.| |
	| |.| +--+ |.| |
	| |.|  oo  |.| |
	| |.|oooooo|.| |
	| |.+------+o|o|
	|o|..........| |
	|o+----------+ |
	|      o   o   |
	+--------------+" );

	final howDitTHATHappen = parseInput(
	"oooooo+--+oooooo
	o+--+o|oo|o+--+o
	o|oo+-+oo+-+oo|o
	o++oooooooooo++o
	oo+-+o+--+o+-+oo
	oooo|o|oo|o|oooo
	o+--+o+--+o+--+o
	++oooooooooooo++
	|oooooooooooooo|
	+--------------+
	oooooooooooooooo
	o+-+oo+--+oo+-+o
	++o|oo|oo|oo|o++
	|oo+--+oo+--+oo|
	|oooooooooooooo|
	+--------------+" );

	

}

