package test;

using buddy.Should;
using Conversion;
@:access(Main)
class TestEncodeDecode extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test Encode", {
			it( "AAA => KQF", {
				final startingShift = 4;
				final rotorTexts = ['BDFHJLCPRTXVZNYEIWGAKMUSQO', 'AJDKSIRUXBLHWTMCQGZNPYFVOE', 'EKMFLGDQVZNTOWYHXUSPAIBRCJ'];
				final rotors = rotorTexts.map( t -> t.toIndexes());
				final message = 'AAA';

				Main.encode( startingShift, rotors, message ).should.be( 'KQF' );
			});
		});

		describe( "Test Decode", {
			
			it( "KQF => AAA", {
				final startingShift = 4;
				final rotorTexts = ['BDFHJLCPRTXVZNYEIWGAKMUSQO', 'AJDKSIRUXBLHWTMCQGZNPYFVOE', 'EKMFLGDQVZNTOWYHXUSPAIBRCJ'];
				final rotors = rotorTexts.map( t -> t.toIndexes());
				final message = 'KQF';

				Main.decode( startingShift, rotors, message ).should.be( 'AAA' );
			});
			
			it( "PQSACVVTOISXFXCIAMQEM => EVERYONEISWELCOMEHERE", {
				final startingShift = 9;
				final rotorTexts = ['BDFHJLCPRTXVZNYEIWGAKMUSQO', 'AJDKSIRUXBLHWTMCQGZNPYFVOE', 'EKMFLGDQVZNTOWYHXUSPAIBRCJ'];
				final rotors = rotorTexts.map( t -> t.toIndexes());
				final message = 'PQSACVVTOISXFXCIAMQEM';

				Main.decode( startingShift, rotors, message ).should.be( 'EVERYONEISWELCOMEHERE' );
			});
			
			it( "XPCXAUPHYQALKJMGKRWPGYHFTKRFFFNOUTZCABUAEHQLGXREZ => THEQUICKBROWNFOXJUMPSOVERALAZYSPHINXOFBLACKQUARTZ", {
				final startingShift = 5;
				final rotorTexts = ['BDFHJLCPRTXVZNYEIWGAKMUSQO', 'AJDKSIRUXBLHWTMCQGZNPYFVOE', 'EKMFLGDQVZNTOWYHXUSPAIBRCJ'];
				final rotors = rotorTexts.map( t -> t.toIndexes());
				final message = 'XPCXAUPHYQALKJMGKRWPGYHFTKRFFFNOUTZCABUAEHQLGXREZ';

				Main.decode( startingShift, rotors, message ).should.be( 'THEQUICKBROWNFOXJUMPSOVERALAZYSPHINXOFBLACKQUARTZ' );
			});
			
		});
	}
}