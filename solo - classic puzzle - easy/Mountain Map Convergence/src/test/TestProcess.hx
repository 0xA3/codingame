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
			
			it( "Test 1", {
				final heights = parseInput(
					"1
					1"
				);
				Main.process( heights ).should.be( parseResult( OneResult ));
			});
			
			it( "Test Familiar", {
				final heights = parseInput(
					"3
					1 2 1"
				);
				Main.process( heights ).should.be( parseResult( familiarResult ));
			});
			
			it( "Test -1", {
				final heights = parseInput(
					"1
					-1"
				);
				Main.process( heights ).should.be( parseResult( minus1Result ));
			});
			
			it( "Test Wait I was correct on the last one", {
				final heights = parseInput(
					"4
					3 7 2 9"
				);
				Main.process( heights ).should.be( parseResult( waitIWasCorrectOnTheLastOneResult ));
			});
			
			it( "Test Twin Peaks", {
				final heights = parseInput(
					"7
					2 3 2 6 6 4 3"
				);
				Main.process( heights ).should.be( parseResult( twinPeaksResult ));
			});
			
			it( "Test Negatives", {
				final heights = parseInput(
					"4
					2 4 -2 3"
				);
				Main.process( heights ).should.be( parseResult( negativesResult ));
			});
			
			it( "Test Tricky Negatives", {
				final heights = parseInput(
					"5
					2 7 -2 -2 -3"
				);
				Main.process( heights ).should.be( parseResult( trickyNegativesResult ));
			});
			
			it( "Test More Tricky Negatives", {
				final heights = parseInput(
					"6
					-6 4 -1 3 -3 -3"
				);
				Main.process( heights ).should.be( parseResult( moreTrickyNegativesResult ));
			});
			
			it( "Test Crazy Mountains", {
				final heights = parseInput(
					"14
					-2 -4 4 -1 2 -1 -2 4 -3 4 -5 2 -4 -3"
				);
				Main.process( heights ).should.be( parseResult( crazyMountainsResult ));
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
	
	final OneResult = parseResult(
"/\\" );
	
	final familiarResult = parseResult(
"   /\\
/\\/  \\/\\" );
	
	final minus1Result = parseResult(
"\\    /
 \\/\\/" );
	
	final waitIWasCorrectOnTheLastOneResult = parseResult(
"                        /\\
                       /  \\
        /\\            /    \\
       /  \\          /      \\
      /    \\        /        \\
     /      \\      /          \\
  /\\/        \\    /            \\
 /            \\/\\/              \\
/                                \\" );
	
	final twinPeaksResult = parseResult(
"             /\\/\\
            /    \\
           /      \\/\\
    /\\    /          \\/\\
 /\\/  \\/\\/              \\
/                        \\" );
	
	final negativesResult = parseResult(
"     /\\
    /  \\            /\\
 /\\/    \\          /  \\
/        \\        /    \\
          \\      /
           \\    /
            \\/\\/" );
	
	final trickyNegativesResult = parseResult(
"        /\\
       /  \\
      /    \\
     /      \\
    /        \\
 /\\/          \\
/              \\
                \\            /
                 \\          /
                  \\/\\/\\    /
                       \\/\\/" );
	
	final moreTrickyNegativesResult = parseResult(
"                   /\\
                  /  \\          /\\
                 /    \\        /  \\
                /      \\      /    \\
\\              /        \\    /      \\          /
 \\            /          \\/\\/        \\        /
  \\          /                        \\      /
   \\        /                          \\/\\/\\/
    \\      /
     \\    /
      \\/\\/" );
	
	final crazyMountainsResult = parseResult(
"                 /\\                          /\\                /\\
                /  \\                        /  \\              /  \\
               /    \\        /\\            /    \\            /    \\                /\\
              /      \\      /  \\          /      \\          /      \\              /  \\
\\            /        \\    /    \\        /        \\        /        \\            /    \\            /
 \\          /          \\/\\/      \\/\\    /          \\      /          \\          /      \\          /
  \\/\\      /                        \\/\\/            \\    /            \\        /        \\        /
     \\    /                                          \\/\\/              \\      /          \\    /\\/
      \\/\\/                                                              \\    /            \\/\\/
                                                                         \\/\\/" );
	
}

