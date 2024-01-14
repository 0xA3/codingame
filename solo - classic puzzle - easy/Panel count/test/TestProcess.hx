package test;

import CompileTime.readFile;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Simple", {
				final ip = parseInput( readFile( "test/test_01.txt" ));
				Main.process( ip.properties, ip.persons, ip.formulas ).should.be( parseResult( readFile( "test/result_01.txt" )) );
			});
			it( "Only one property", {
				final ip = parseInput( readFile( "test/test_02.txt" ));
				Main.process( ip.properties, ip.persons, ip.formulas ).should.be( parseResult( readFile( "test/result_02.txt" )) );
			});
			it( "Several properties", {
				final ip = parseInput( readFile( "test/test_03.txt" ));
				Main.process( ip.properties, ip.persons, ip.formulas ).should.be( parseResult( readFile( "test/result_03.txt" )) );
			});
			it( "More complex formula", {
				final ip = parseInput( readFile( "test/test_04.txt" ));
				Main.process( ip.properties, ip.persons, ip.formulas ).should.be( parseResult( readFile( "test/result_04.txt" )) );
			});
			it( "Unknown property", {
				final ip = parseInput( readFile( "test/test_05.txt" ));
				Main.process( ip.properties, ip.persons, ip.formulas ).should.be( parseResult( readFile( "test/result_05.txt" )) );
			});
			it( "No one", {
				final ip = parseInput( readFile( "test/test_06.txt" ));
				Main.process( ip.properties, ip.persons, ip.formulas ).should.be( parseResult( readFile( "test/result_06.txt" )) );
			});
			it( "More persons", {
				final ip = parseInput( readFile( "test/test_07.txt" ));
				Main.process( ip.properties, ip.persons, ip.formulas ).should.be( parseResult( readFile( "test/result_07.txt" )) );
			});
			it( "Formulas repeating", {
				final ip = parseInput( readFile( "test/test_08.txt" ));
				Main.process( ip.properties, ip.persons, ip.formulas ).should.be( parseResult( readFile( "test/result_08.txt" )) );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final p = parseInt( lines[0] );
		final properties = lines.slice( 1, p + 1);
	
		final n = parseInt( lines[p + 1] );
		final persons = lines.slice( p + 2, p + n + 2);

		final f = parseInt( lines[p + n + 2] );
		final formulas = lines.slice( p + n + 3, p + n + f + 3 );

		return { properties: properties, persons: persons, formulas: formulas }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}
