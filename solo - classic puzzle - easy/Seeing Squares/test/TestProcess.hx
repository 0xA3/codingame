package test;

import CodinGame.printErr;
import CompileTime.readFile;
import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Size 2", Main.process( size2 ).should.be( 1 ));
			it( "Size 3", Main.process( size3 ).should.be( 1 ));
			it( "Size 4", Main.process( size4 ).should.be( 1 ));
			it( "Size 5", Main.process( size5 ).should.be( 1 ));
			it( "Singular Square", Main.process( parseInput( readFile( "test/Test_01.txt" ))).should.be( 1 ));
			it( "Side By Side", Main.process( parseInput( readFile( "test/Test_02.txt" ))).should.be( 2 ));
			it( "Some Missing Sides", Main.process( parseInput( readFile( "test/Test_03.txt" ))).should.be( 0 ));
			it( "Slightly Bigger", Main.process( parseInput( readFile( "test/Test_04.txt" ))).should.be( 2 ));
			it( "Snaking Sequence", Main.process( parseInput( readFile( "test/Test_05.txt" ))).should.be( 7 ));
			it( "Squares On Squares", Main.process( parseInput( readFile( "test/Test_06.txt" ))).should.be( 5 ));
			it( "Spiralling", Main.process( parseInput( readFile( "test/Test_07.txt" ))).should.be( 27 ));
			it( "Segmentation", Main.process( parseInput( readFile( "test/Test_08.txt" ))).should.be( 7 ));
			it( "Squished", Main.process( parseInput( readFile( "test/Test_09.txt" ))).should.be( 26 ));
			it( "So Many??", Main.process( parseInput( readFile( "test/Test_10.txt" ))).should.be( 84 ));
			it( "Slightly Off", Main.process( parseInput( readFile( "test/Test_11.txt" ))).should.be( 14 ));
			it( "Slightly Smaller", Main.process( parseInput( readFile( "test/Test_12.txt" ))).should.be( 12 ));
			it( "Statue", Main.process( parseInput( readFile( "test/Test_13.txt" ))).should.be( 9 ));
			it( "Some Abstraction", Main.process( parseInput( readFile( "test/Test_14.txt" ))).should.be( 1 ));
			it( "Spray And Pray", Main.process( parseInput( readFile( "test/Test_15.txt" ))).should.be( 371 ));
			it( "Somehow The Lines Are Visible", Main.process( parseInput( readFile( "test/Test_16.txt" ))).should.be( 18140 ));
			it( "Stripes And Spots", Main.process( parseInput( readFile( "test/Test_17.txt" ))).should.be( 6636 ));
			it( "So Many!!", Main.process( parseInput( readFile( "test/Test_18.txt" ))).should.be( 187768 ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		final inputs = readline().split(" ");
		final r = parseInt( inputs[0] );
		final c = parseInt( inputs[1] );

		final grid = [for( _ in 0...r ) readline().split( "" )];
		
		return grid;
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final size2 = parseInput(
		"2 3
		+-+
		+-+"
	);
	
	final size3 = parseInput(
		"3 5
		+---+
		|   |
		+---+"
	);
	
	final size4 = parseInput(
		"4 7
		+-----+
		|     |
		|     |
		+-----+"
	);
	
	final size5 = parseInput(
		"5 9
		+-------+
		|       |
		|       |
		|       |
		+-------+"
	);
}