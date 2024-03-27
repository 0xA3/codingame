package test;

import CompileTime.parseJsonFile;
import CompileTime.readFile;
import Main.findLargestCircle;
import haxe.Json;

using buddy.Should;

class TestFindLargestCircle extends buddy.BuddySuite{

	static final test0Input = readFile( "test/Test_radius_1_input.txt" );
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

	public function new() {

		describe( "Test buildingHeights", {
			it( "Test 0", {
				final ip = parseInput( test0Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_radius_1_output.txt" ).join(","));	});
			it( "Example", {
				final ip = parseInput( test1Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_1_output.txt" ).join(","));	});
			it( "Small circle", {
				final ip = parseInput( test2Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_2_output.txt" ).join(",")); });
			it( "Obvious circle", {
				final ip = parseInput( test3Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_3_output.txt" ).join(","));	});
			it( "Variety", {
				final ip = parseInput( test4Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_4_output.txt" ).join(","));	});
			it( "Olympic", {
				final ip = parseInput( test5Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_5_output.txt" ).join(","));	});
			it( "Rings", {
				final ip = parseInput( test6Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_6_output.txt" ).join(","));	});
			it( "Trompeur", {
				final ip = parseInput( test7Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_7_output.txt" ).join(","));	});
			it( "Binary", {
				final ip = parseInput( test8Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_8_output.txt" ).join(","));	});
			it( "Rings 2", {
				final ip = parseInput( test9Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_9_output.txt" ).join(","));	});
			it( "Variety 2", {
				final ip = parseInput( test10Input );
				findLargestCircle( ip.nRows, ip.nCols, ip.image ).join(",").should.be( parseJsonFile( "test/Test_10_output.txt" ).join(","));	});
		});
	}

	static function parseInput( content:String ) {
		final lines = content.split( "\n" );
		final nRows = Std.parseInt( lines[0] );
		final nCols = Std.parseInt( lines[1] );
		final image = Json.parse( lines[2] );
		return { nRows: nRows, nCols: nCols, image: image }
	}
}
