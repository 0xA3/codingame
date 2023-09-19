package test;

import CompileTime.parseJsonFile;
import CompileTime.readFile;
import Main.bestRemainingMutant;
import haxe.Json;

using buddy.Should;

class TestBestRemainingMutant extends buddy.BuddySuite{

	static final test1Input = readFile( "test/Test_1_input.txt" );
	static final test2Input = readFile( "test/Test_2_input.txt" );
	static final test3Input = readFile( "test/Test_3_input.txt" );
	static final test4Input = readFile( "test/Test_4_input.txt" );
	static final test5Input = readFile( "test/Test_5_input.txt" );
	static final test6Input = readFile( "test/Test_6_input.txt" );
	static final test7Input = readFile( "test/Test_7_input.txt" );
	static final test8Input = readFile( "test/Test_8_input.txt" );
	static final test9Input = readFile( "test/Test_9_input.txt" );

	public function new() {

		describe( "Test bestRemainingMutant", {
			it( "Example", {
				final ip = parseInput( test1Input );
				bestRemainingMutant( ip.mutantScores, ip.threshold ).should.be( parseJsonFile( "test/Test_1_output.txt" ));	});
			it( "ToadZilla", {
				final ip = parseInput( test2Input );
				bestRemainingMutant( ip.mutantScores, ip.threshold ).should.be( parseJsonFile( "test/Test_2_output.txt" )); });
			it( "IceScream", {
				final ip = parseInput( test3Input );
				bestRemainingMutant( ip.mutantScores, ip.threshold ).should.be( parseJsonFile( "test/Test_3_output.txt" )); });
			it( "MutAntelope", {
				final ip = parseInput( test4Input );
				bestRemainingMutant( ip.mutantScores, ip.threshold ).should.be( parseJsonFile( "test/Test_4_output.txt" )); });
			it( "WomanWoman", {
				final ip = parseInput( test5Input );
				bestRemainingMutant( ip.mutantScores, ip.threshold ).should.be( parseJsonFile( "test/Test_5_output.txt" )); });
			it( "FroZen", {
				final ip = parseInput( test6Input );
				bestRemainingMutant( ip.mutantScores, ip.threshold ).should.be( parseJsonFile( "test/Test_6_output.txt" )); });
			it( "UnhapPykachu", {
				final ip = parseInput( test7Input );
				bestRemainingMutant( ip.mutantScores, ip.threshold ).should.be( parseJsonFile( "test/Test_7_output.txt" )); });
			it( "RastaRock", {
				final ip = parseInput( test8Input );
				bestRemainingMutant( ip.mutantScores, ip.threshold ).should.be( parseJsonFile( "test/Test_8_output.txt" )); });
			it( "Mike", {
				final ip = parseInput( test9Input );
				bestRemainingMutant( ip.mutantScores, ip.threshold ).should.be( parseJsonFile( "test/Test_9_output.txt" )); });
		});
	}

	static function parseInput( content:String ) {
		final lines = content.split( "\n" );
		final mutantScores = Json.parse( lines[0] );
		final threshold = Std.parseInt( lines[1] );
		return { mutantScores: mutantScores, threshold: threshold }
	}
}
