package test;

import CompileTime.readFile;
import Main.solve;
import Std.parseInt;
import haxe.Json;

using buddy.Should;

class TestSolve extends buddy.BuddySuite{

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

		describe( "Test solve", {
			it( "Example", {
				final ip = parseInput( test1Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
			it( "Cross", {
				final ip = parseInput( test2Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
			it( "Mountain", {
				final ip = parseInput( test3Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
			it( "Big cross", {
				final ip = parseInput( test4Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
			it( "Dog", {
				final ip = parseInput( test5Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
			it( "Crewmate", {
				final ip = parseInput( test6Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
			it( "CoderPad", {
				final ip = parseInput( test7Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
			it( "Ghost", {
				final ip = parseInput( test8Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
			it( "Star", {
				final ip = parseInput( test8Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
			it( "Abstract", {
				final ip = parseInput( test8Input );
				final orders = solve( ip.n, ip.targetImage );
				simulate( ip.n, orders ).should.be( ip.targetImage.join("\n"));	});
		});
	}

	static function parseInput( content:String ) {
		final lines = content.split( "\n" );
		final n = Std.parseInt( lines[0] );
		final targetImage = Json.parse( lines[1] );
		return { n: n, targetImage: targetImage }
	}

	static function simulate( n:Int , orders:Array<String> ) {
		final grid = [for( _ in 0...n ) [for( _ in 0...n ) "."]];
		for( order in orders ) {
			final parts = order.split( " " );
			switch parts[0] {
				case "C":
				final col = parseInt( parts[1] );
				for( row in 0...n ) grid[row][col] = "#";
				case "R":
				final row = parseInt( parts[1] );
				for( col in 0...n ) grid[row][col] = ".";
			}
			// trace( order + "\n" + grid2Image( grid ));
		}
		return grid2Image( grid );
	}

	static function grid2Image( grid:Array<Array<String>> ) return grid.map( row -> row.join("")).join( "\n" );
}
