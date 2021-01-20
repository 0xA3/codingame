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
			
			it( "A simple straight line", {
				final input = aSimpleStraightLine;
				Main.process( input.xthenCommands, input.road ).should.be( aSimpleStraightLineResult );
			});
			
			it( "Gentleman, start your engines", {
				// trace( "\n" + gentlemenStartYourEngines.road.join( "\n" ));
				final input = gentlemenStartYourEngines;
				// trace( "\n" + Main.process( input.xthenCommands, input.road ));
				Main.process( input.xthenCommands, input.road ).should.be( gentlemenStartYourEnginesResult );
			});
			
			it( "The Senna 'S'", {
				final input = theSennaS;
				Main.process( input.xthenCommands, input.road ).should.be( theSennaSResult );
			});
			
			it( "Drunk car", {
				final input = drunkCar;
				Main.process( input.xthenCommands, input.road ).should.be( drunkCarResult );
			});

		});
	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" );
		return { xthenCommands: lines[1].trim(), road: [for( i in 2...lines.length ) lines[i].trim()] };
	}

	static function parseResult( input:String ) {
		final lines = input.split( "\n" );
		return lines.map( line -> line.replace( "\r", "" ).replace( "\t", "    " ).substr( 8 )).join( "\n" );
	}

	final aSimpleStraightLine = parseInput(
		"1
		2;10S
		10;|     |     |"
	);

	final aSimpleStraightLineResult = parseResult(
"		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |"
	);

	final gentlemenStartYourEngines = parseInput(
		"14
		2;12S;6R;18S
		14;|     |     |
		1;\\      \\     \\
		1; \\      \\     \\
		1;  \\      \\     \\
		1;   \\      \\     \\
		1;    \\      \\     \\
		10;     |      |     |
		1;     |      |     |  ---------------
		1;     |      |     |  |  CODINGAME  |
		1;     |      |     |  |    .COM     |
		1;     |      |     |  ---------------
		1;     |      |     |    |         |
		1;     |      |     |    |         |
		1;     |      |     |    |         |"
	);

	final gentlemenStartYourEnginesResult = parseResult(
"		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		|#    |     |
		| #   |     |
		|  #  |     |
		\\   #  \\     \\
		 \\   #  \\     \\
		  \\   #  \\     \\
		   \\   #  \\     \\
			\\  #   \\     \\
			 | #    |     |
			 | #    |     |
			 | #    |     |
			 | #    |     |
			 | #    |     |
			 | #    |     |
			 | #    |     |
			 | #    |     |
			 | #    |     |
			 | #    |     |
			 | #    |     |  ---------------
			 | #    |     |  |  CODINGAME  |
			 | #    |     |  |    .COM     |
			 | #    |     |  ---------------
			 | #    |     |    |         |
			 | #    |     |    |         |
			 | #    |     |    |         |"
	);

	final theSennaS = parseInput(
		"17
		3;4S;8R;8L;3S
		4;|     |     |
		1;\\     \\     \\
		1; \\     \\     \\
		1;  \\     \\     \\
		1;   \\     \\     \\
		1;    \\     \\     \\
		1;     \\     \\     \\
		1;      \\     \\     \\
		1;       \\     \\     \\
		1;       /     /     /
		1;      /     /     /
		1;     /     /     /
		1;    /     /     /
		1;   /     /     /
		1;  /     /     /
		1; /     /     /
		4;|     |     |"
	);

	final theSennaSResult = parseResult(
"		| #   |     |
		| #   |     |
		| #   |     |
		| #   |     |
		\\  #  \\     \\
		 \\  #  \\     \\
		  \\  #  \\     \\
		   \\  #  \\     \\
			\\  #  \\     \\
			 \\  #  \\     \\
			  \\  #  \\     \\
			   \\  #  \\     \\
			   / #   /     /
			  / #   /     /
			 / #   /     /
			/ #   /     /
		   / #   /     /
		  / #   /     /
		 / #   /     /
		| #   |     |
		| #   |     |
		| #   |     |
		| #   |     |"
	);

	final drunkCar = parseInput(
		"17
		4;4S;2R;2L;2R;2L;2L;2R;2L;2R;1R;1S;1R;1S;1R;1S;1R;1S;1R;1S;1R;1S;1R
		4;|     |     |
		1;\\     \\     \\
		1; \\     \\     \\
		1;  \\     \\     \\
		1;   \\     \\     \\
		1;    \\     \\     \\
		1;     \\     \\     \\
		1;      \\     \\     \\
		1;       \\     \\     \\
		1;       /     /     /
		1;      /     /     /
		1;     /     /     /
		1;    /     /     /
		1;   /     /     /
		1;  /     /     /
		1; /     /     /
		14;|     |     |"
	);

	final drunkCarResult = parseResult(
"		|  #  |     |
		|  #  |     |
		|  #  |     |
		|  #  |     |
		\\   # \\     \\
		 \\   # \\     \\
		  \\ #   \\     \\
		   #     \\     \\
			#     \\     \\
			 #     \\     \\
			# \\     \\     \\
		   #   \\     \\     \\
		  #    /     /     /
		 #    /     /     /
		  #  /     /     /
		   #/     /     /
		  #/     /     /
		 #/     /     /
		 /#    /     /
		|  #  |     |
		|   # |     |
		|   # |     |
		|    #|     |
		|    #|     |
		|     #     |
		|     #     |
		|     |#    |
		|     |#    |
		|     | #   |
		|     | #   |
		|     |  #  |
		|     |  #  |
		|     |   # |"
	);

}
