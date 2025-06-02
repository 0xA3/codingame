package test;

import Std.parseInt;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			
			it( "Teeny", Main.process( teeny ).should.be( "1" ));
			it( "Tiny", Main.process( tiny ).should.be( "769" ));
			it( "Six-digit Figure", Main.process( sixDigitFigure ).should.be( "123456" ));
			it( "BIG BOY", Main.process( bigBoy ).should.be( "00654378111" ));
			it( "Unorganized", Main.process( unorganized ).should.be( "0192837645" ));
			it( "Phone Call?", Main.process( phoneCall ).should.be( "67341682195" ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		return  [for( _ in 0...5 ) readline()];
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final teeny = parseInput(
		"*****
		*****
		00000
		*****
		*****"
	);

	final tiny = parseInput(
		"**0** **0** **0**
		**0** **0** **0**
		00000 00000 0000*
		**0** *0*0* *0*0*
		**000 0***0 0**00"
	);

	final sixDigitFigure = parseInput(
		"***** 00000 00000 00000 00000 **0**
		***** ***** ***** 0*0*0 **0** **0**
		00000 ***** *000* 00*00 *0000 00000
		***** ***** ***** 0***0 **0*0 *0*0*
		***** 00000 00000 00000 00000 0***0"
	);

	final bigBoy = parseInput(
		"*000* *000* **0** 00000 00000 00000 **0** *0*0* ***** ***** *****
		0***0 0***0 **0** **0** 0*0*0 ***** **0** *0*0* ***** ***** *****
		0***0 0***0 00000 *0000 00*00 *000* 00000 *0*0* 00000 00000 00000
		0***0 0***0 *0*0* **0*0 0***0 ***** **0** *0*0* ***** ***** *****
		*000* *000* 0***0 00000 00000 00000 **000 0***0 ***** ***** *****"
	);

	final unorganized = parseInput(
		"*000* ***** **0** 00000 *0*0* 00000 **0** **0** 00000 00000
		0***0 ***** **0** ***** *0*0* ***** **0** **0** 0*0*0 **0**
		0***0 00000 0000* ***** *0*0* *000* 00000 00000 00*00 *0000
		0***0 ***** *0*0* ***** *0*0* ***** **0** *0*0* 0***0 **0*0
		*000* ***** 0**00 00000 0***0 00000 **000 0***0 00000 00000"
	);

	final phoneCall = parseInput(
		"**0** **0** 00000 00000 ***** **0** *0*0* 00000 ***** **0** 00000
		**0** **0** ***** 0*0*0 ***** **0** *0*0* ***** ***** **0** **0**
		00000 00000 *000* 00*00 00000 00000 *0*0* ***** 00000 0000* *0000
		*0*0* **0** ***** 0***0 ***** *0*0* *0*0* ***** ***** *0*0* **0*0
		0***0 **000 00000 00000 ***** 0***0 0***0 00000 ***** 0**00 00000"
	);
}