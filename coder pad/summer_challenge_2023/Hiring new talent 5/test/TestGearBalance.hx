package test;

import CompileTime.parseJsonFile;
import CompileTime.readFile;
import Main.gearBalance;
import haxe.Json;

using buddy.Should;

class TestGearBalance extends buddy.BuddySuite{

	static final test1Input = readFile( "test/Test_1_input.txt" );
	static final test2Input = readFile( "test/Test_2_input.txt" );
	static final test3Input = readFile( "test/Test_3_input.txt" );
	static final test4Input = readFile( "test/Test_4_input.txt" );
	static final test5Input = readFile( "test/Test_5_input.txt" );
	static final test6Input = readFile( "test/Test_6_input.txt" );
	static final test7Input = readFile( "test/Test_7_input.txt" );
	static final test8Input = readFile( "test/Test_8_input.txt" );
	static final test9Input = readFile( "test/Test_9_input.txt" );
	static final test10Input = readFile( "test/Test_10_input.txt" );
	static final test11Input = readFile( "test/Test_11_input.txt" );
	static final test12Input = readFile( "test/Test_12_input.txt" );
	static final test13Input = readFile( "test/Test_13_input.txt" );

	public function new() {

		describe( "Test gearBalance", {
			it( "Example 1", {
				final ip = parseInput( test1Input );
				gearBalance( ip.instructions, ip.target ).toString().toString().should.be( parseJsonFile( "test/Test_1_output.txt" ).toString()); });
			it( "Example 2", {
				final ip = parseInput( test2Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_2_output.txt" ).toString()); });
			it( "Tree system", {
				final ip = parseInput( test3Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_3_output.txt" ).toString()); });
			it( "Invalid", {
				final ip = parseInput( test4Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_4_output.txt" ).toString()); });
			it( "Imbalanced", {
				final ip = parseInput( test5Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_5_output.txt" ).toString()); });
			it( "Single invalid", {
				final ip = parseInput( test6Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_6_output.txt" ).toString()); });
			it( "Strongly imbalanced", {
				final ip = parseInput( test7Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_7_output.txt" ).toString()); });
			it( "Strongly imbalanced and invalid", {
				final ip = parseInput( test8Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_8_output.txt" ).toString()); });
			it( "Big tree", {
				final ip = parseInput( test9Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_9_output.txt" ).toString()); });
			it( "Complex network", {
				final ip = parseInput( test10Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_10_output.txt" ).toString()); });
			it( "Extremely imbalanced", {
				final ip = parseInput( test11Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_11_output.txt" ).toString()); });
			it( "Almost perfect", {
				final ip = parseInput( test12Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_12_output.txt" ).toString()); });
			it( "Perfect", {
				final ip = parseInput( test13Input );
				gearBalance( ip.instructions, ip.target ).toString().should.be( parseJsonFile( "test/Test_13_output.txt" ).toString()); });
		});
	}

	static function parseInput( content:String ) {
		final lines = content.split( "\n" );
		final instructions = Json.parse( lines[0] );
		final target = Json.parse( lines[1] );
		return { instructions: instructions, target: target }
	}
}
