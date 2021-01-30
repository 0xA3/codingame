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
			
			it( "Test 1", {
				final heights = parseInput(
					"3
					1 2 1"
				);
				Main.process( heights ).should.be( parseResult( test1Result ));
			});
			
			it( "Test 2", {
				final heights = parseInput(
					"1
					1"
				);
				Main.process( heights ).should.be( parseResult( test2Result ));
			});
			
			it( "Test 3", {
				final heights = parseInput(
					"4
					3 7 2 9"
				);
				Main.process( heights ).should.be( parseResult( test3Result ));
			});
			
			it( "Test 4", {
				final heights = parseInput(
					"7
					7 2 3 4 1 2 3"
				);
				Main.process( heights ).should.be( parseResult( test4Result ));
			});
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		return lines[1].split(' ').map( s -> parseInt( s ));
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
	
	final test1Result = parseResult(
"   /\\
/\\/  \\/\\" );
	
	final test2Result = parseResult(
"/\\" );
	
	final test3Result = parseResult(
"                                /\\
                               /  \\
            /\\                /    \\
           /  \\              /      \\
          /    \\            /        \\
         /      \\          /          \\
  /\\    /        \\        /            \\
 /  \\  /          \\  /\\  /              \\
/    \\/            \\/  \\/                \\" );
	
	final test4Result = parseResult(
"      /\\
     /  \\
    /    \\
   /      \\                /\\
  /        \\        /\\    /  \\          /\\
 /          \\  /\\  /  \\  /    \\    /\\  /  \\
/            \\/  \\/    \\/      \\/\\/  \\/    \\" );
	
}

