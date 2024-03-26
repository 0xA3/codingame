package test;

import CompileTime.parseJsonFile;
import CompileTime.readFile;
import Main.buildingHeights;
import haxe.Json;

using buddy.Should;

class TestBuildingHeights extends buddy.BuddySuite{

	static final test1Input = readFile( "test/Test_1_input.txt" );
	static final test2Input = readFile( "test/Test_2_input.txt" );
	static final test3Input = readFile( "test/Test_3_input.txt" );
	static final test4Input = readFile( "test/Test_4_input.txt" );
	static final test5Input = readFile( "test/Test_5_input.txt" );
	static final test6Input = readFile( "test/Test_6_input.txt" );
	static final test7Input = readFile( "test/Test_7_input.txt" );
	static final test8Input = readFile( "test/Test_8_input.txt" );

	public function new() {

		describe( "Test buildingHeights", {
			it( "Example", {
				final ip = parseInput( test1Input );
				buildingHeights( ip.n, ip.buildingMap ).join(",").should.be( parseJsonFile( "test/Test_1_output.txt" ).join(","));	});
			it( "Village", {
				final ip = parseInput( test2Input );
				buildingHeights( ip.n, ip.buildingMap ).join(",").should.be( parseJsonFile( "test/Test_2_output.txt" ).join(",")); });
			it( "Flat", {
				final ip = parseInput( test3Input );
				buildingHeights( ip.n, ip.buildingMap ).join(",").should.be( parseJsonFile( "test/Test_3_output.txt" ).join(","));	});
			it( "Variable", {
				final ip = parseInput( test4Input );
				buildingHeights( ip.n, ip.buildingMap ).join(",").should.be( parseJsonFile( "test/Test_4_output.txt" ).join(","));	});
			it( "Solo Building", {
				final ip = parseInput( test5Input );
				buildingHeights( ip.n, ip.buildingMap ).join(",").should.be( parseJsonFile( "test/Test_5_output.txt" ).join(","));	});
			it( "No sky", {
				final ip = parseInput( test6Input );
				buildingHeights( ip.n, ip.buildingMap ).join(",").should.be( parseJsonFile( "test/Test_6_output.txt" ).join(","));	});
			it( "Missing buildings", {
				final ip = parseInput( test7Input );
				buildingHeights( ip.n, ip.buildingMap ).join(",").should.be( parseJsonFile( "test/Test_7_output.txt" ).join(","));	});
			it( "Town", {
				final ip = parseInput( test8Input );
				buildingHeights( ip.n, ip.buildingMap ).join(",").should.be( parseJsonFile( "test/Test_8_output.txt" ).join(","));	});
		});
	}

	static function parseInput( content:String ) {
		final lines = content.split( "\n" );
		final n = Std.parseInt( lines[0] );
		final buildingMap = Json.parse( lines[1] );
		return { n: n, buildingMap: buildingMap }
	}
}
