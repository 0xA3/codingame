package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {	Main.process( "fc:94:b0:c1:e5:b0:98:7c:58:43:99:76:97:ee:9f:b7" ).should.be( test1Result ); });
			it( "Test 2", {	Main.process( "51:8e:d2:95:25:73:8c:eb:da:c4:9c:49:e6:0e:a9:d3" ).should.be( test2Result ); });
			it( "Test 3", {	Main.process( "02:64:d6:eb:fd:ca:bc:10:79:92:6e:91:d8:b5:f3:fd" ).should.be( test3Result ); });
			it( "Test 4", {	Main.process( "a8:6c:78:04:a2:23:00:45:58:f7:1b:bc:dc:11:0a:71" ).should.be( test4Result ); });
			it( "Test 5", {	Main.process( "00:00:00:00:00:00:00:00:ff:ff:ff:ff:ff:ff:ff:ff" ).should.be( test5Result ); });
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1Result = parseResult(
		"+---[CODINGAME]---+
		|       .=o.  .   |
		|     . *+*. o    |
		|      =.*..o     |
		|       o + ..    |
		|        S o.     |
		|         o  .    |
		|          .  . . |
		|              o .|
		|               E.|
		+-----------------+" );

	final test2Result = parseResult(
		"+---[CODINGAME]---+
		|          ==o    |
		|       . =o+.    |
		|      . + ..     |
		|       . .+      |
		|        SO o     |
		|        o O      |
		|       o *       |
		|      o E o      |
		|       .         |
		+-----------------+" );

	final test3Result = parseResult(
		"+---[CODINGAME]---+
		|    +.           |
		|   +  .          |
		|    .  ..        |
		|     +.= .       |
		|    ..X.S        |
		|     ..*.o .     |
		|      +  .. .    |
		|     . +  .  .   |
		|        =o    E  |
		+-----------------+" );

	final test4Result = parseResult(
		"+---[CODINGAME]---+
		|.=+ +.E .        |
		|o  . = . .       |
		|o .   = .        |
		|o. . . * .       |
		|+   . = S        |
		|.. + .           |
		|  . =            |
		|   o             |
		|                 |
		+-----------------+" );

	final test5Result = parseResult(
		"+---[CODINGAME]---+
		|%....            |
		| .   .           |
		|  .   .          |
		|   .   .         |
		|    .   S        |
		|     .           |
		|      .          |
		|       .         |
		|        ........E|
		+-----------------+" );
}
