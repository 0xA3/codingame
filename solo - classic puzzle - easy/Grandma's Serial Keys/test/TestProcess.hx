package test;

import CodinGame.printErr;
import test.Readline.initReadline;
import test.Readline.readline;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Easy One", Main.process( "johndoe" ).should.be( "4451-0000-05A9-49FA" ));
			it( "Underscores", Main.process( "I_L_I_K_E_C_O_D_I_N_G" ).should.be( "DFB8-0000-0BD0-EB88" ));
			it( "All Characters", Main.process( "{`S00p=ErM@n|s<0ol~b==pb00p]" ).should.be( "5990-0001-17A0-7131" ));
			it( "One Character", Main.process( "A" ).should.be( "5041-0000-0082-50C3" ));
			it( "Looooong One", Main.process( "MWWWWWWWWWWWWWWWWWWWWWWWWAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHAAAAAAAAAAAAAAAAAHHHHAAAAAAAAHHHHHHHHHHHHHHHHHHHHHAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHAAAAAAAAAAAAAAAAAHHHHAAAAAAAAHHHHHHHHHHHHHHHHHHHHHAAAAAAAAAAAAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHAAAAAAAAAAAAAAAAAHHHHAAAAAAAA" ).should.be( "2A80-0077-BA60-E557" ));
			it( "One Key to Another Key", Main.process( "0000-0000-0000-0000" ).should.be( "1305-0000-0720-1A25" ));
			it( "Starts with 0", Main.process( "+o<y4 fxXZ:lpf#r" ).should.be( "0440-0000-09D0-0E10" ));
		});
	}

	static function parseInput( input:String ) {
		initReadline( input );
		
		// return
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}