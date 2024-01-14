package test;

import CompileTime.readFile;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1: One right", {
				final ip = parseInput( readFile( "test/test_01.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_01.txt" )) );
			});
			it( "Test 2: One Isosceles", {
				final ip = parseInput( readFile( "test/test_02.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_02.txt" )) );
			});
			it( "Test 3: Two triangles, sailboat", {
				final ip = parseInput( readFile( "test/test_03.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_03.txt" )) );
			});
			it( "Test 4: Condensed", {
				final ip = parseInput( readFile( "test/test_04.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_04.txt" )) );
			});
			it( "Test 5: Overlap (tree)", {
				final ip = parseInput( readFile( "test/test_05.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_05.txt" )) );
			});
			it( "Test 6: Overlap expanded Star of David", {
				final ip = parseInput( readFile( "test/test_06.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_06.txt" )) );
			});
			it( "Test 7 Overlap condensed Star of David", {
				final ip = parseInput( readFile( "test/test_07.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_07.txt" )) );
			});
			it( "Test 8 Triangles inside of triangles", {
				final ip = parseInput( readFile( "test/test_08.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_08.txt" )) );
			});
			it( "Test 9: Yoga, partial triangles", {
				final ip = parseInput( readFile( "test/test_09.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_09.txt" )) );
			});
			it( "Test 10: Tesla Truck, partial triangles", {
				final ip = parseInput( readFile( "test/test_10.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_10.txt" )) );
			});
			it( "Test 11: Misc", {
				final ip = parseInput( readFile( "test/test_11.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_11.txt" )) );
			});
			it( "Test 12: overflowing everywhere", {
				final ip = parseInput( readFile( "test/test_12.txt" ));
				Main.process( ip.hi, ip.wi, ip.style, ip.triangles ).should.be( parseResult( readFile( "test/result_12.txt" )) );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );

		final inputs = lines[0].split(' ');
		final hi = parseInt( inputs[0] );
		final wi = parseInt( inputs[1] );
		final style = lines[1];
		final howManyTriangles = parseInt( lines[2] );
		final triangles = [for( i in 0...howManyTriangles ){
			final inputs = lines[3 + i].split(' ');
			final triangle:Array<Point> = [
				{ x: parseInt( inputs[0] ), y: parseInt(inputs[1])},
				{ x: parseInt( inputs[2] ), y: parseInt(inputs[3])},
				{ x: parseInt( inputs[4] ), y: parseInt(inputs[5])}
			];
			triangle;
		}];
	
		return { hi: hi, wi: wi, style: style, triangles: triangles }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}
}
