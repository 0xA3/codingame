package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Example", { Main.process( parse( example )).should.be( exampleResult ); });
			it( "Basic operations", { Main.process( parse( basicOperations )).should.be( basicOperationsResult ); });
			it( "Smoky trail", { Main.process( parse( smokyTrail )).should.be( smokyTrailResult ); });
			it( "Traps in fames", { Main.process( parse( trapsInFames )).should.be( trapsInFamesResult ); });
			it( "Ambushes", { Main.process( parse( ambushes )).should.be( ambushesResult ); });
			
		});

	}

	static function parse( input:String ) {
		final inputLines = input.split( "\n" );
		final n = parseInt( inputLines[0] );
		final lines = [for( i in 0...n ) inputLines[i + 1].split("").map( cell -> cell.trim() == "f" ? true : false )];
		return lines;
	}

	static function parseResult( input:String ) {
		return input.split( "\n" ).map( line -> line.trim()).join( "\n" );
	}

	static final example =
	"2
	....f....f..
	.......fff";

	static final exampleResult = parseResult(
	"2
	1" );

	static final basicOperations =
	"18
	f.f
	fff..ffff..
	..
	ffffff
	ff.ff
	ffff..ff.f
	fffff.ffff
	ffff.ffff
	ffff.ffff.ff
	ff.ff..fff
	ff.ff..ffff.f
	....
	f
	..ff
	fffff
	f..fff
	ff..
	f.f.f.";

	static final basicOperationsResult = parseResult(
	"1
	3
	0
	2
	2
	4
	4
	3
	4
	3
	4
	0
	1
	1
	2
	2
	1
	2" );

	static final smokyTrail =
	"34
	..
	.f
	fff
	..f.
	ffffff
	ff...f
	f.ff.ff.f
	ffffffff.f
	fff..ffff..
	ff.fffff..f
	f.ffff..f.ffff
	..ff.ffff..f.fffffff
	ffffff.f.f.ffff...ffffff
	ffff.ff.fff..fff...fffffff
	ffff.f.ffffff..ffff.f.ffffffff.
	f.ffff.ffff..ff.ffffff.fff.f.ff.
	fffffff.fff..ffff.f..fffff.f.fffff.ff
	f.fff.f.ffffffff.fff.f.f..fffffffff.ff.f
	.f.ffffff..ff.f.fff..ffff..ffff.ffff.fff
	ff.f.fff.fffffffff.f.ff.ff.fffffff.fffffff
	ff.ffffff.ffffffffffffffffffffffff.f.ff.f.ff
	.f.f..fffffffffffff.fffffff..fffff.fff.fffff.f
	fffff.f.f.f.ff.fff..fff..fffffffff..fff.f.ffff..ff.fffff
	fffffff..f.ff.f.ffffff.ffffffff..ffff.f.ffffffff..f.fff.
	f..ff..ff..f.fffff.f.fffffffff.fffff.ffffffff..ff..f.ffff.
	f.fffffffffffffff.fffff..fffff.f.ffffff.f..f.f..ffffff..ff.f.f
	.fff.ff.ffffff.f..fff.fffff..f.fffffff..ffff.ffffffff..f.ffff..
	fffffffff...ffffff...fff...fffff.f.fffff.fff.ffffff.fffff..ffffffffff.fff
	ff.f..f.fff.ffffff.fff.f.f.ffff..f.f.f.f..fff..ffffffff.ff.f.fffffff..fff.ff
	ffffff.ff.fffff.fffffff...ff.fffff..fffffff.f.ff.ffffffff.ffffffffff.ff.fffff
	.ffffffffffff..f..ff.f.fff.ffffff.f.f..ffffff.f.fff..ff.ff.ffffff..f.f.ffff.ff.
	ff.f.fffff...ffff.ffffff.ffffffff.fff.fff.fffffffff.fff.f.fffff.ff.f..ff.f.f.f..f.f
	ffffff.ff.ff.ff...fffffffffff..ff..ffffff.ff.fffffff..fff.f.fffffff..fffffff..ff..ffff.
	ffff..ff.fffffff.f.fff.ffff.fff..f.fffffff..fff.ff.ff.ffffffff.f.f..f.fffff.fff.ffffffffff.f.f";

	static final smokyTrailResult = parseResult(
	"0
	1
	1
	1
	2
	2
	3
	4
	3
	4
	4
	6
	7
	8
	9
	10
	12
	13
	12
	14
	14
	14
	16
	17
	17
	19
	18
	21
	22
	25
	23
	25
	26
	29" );

	static final trapsInFames =
	"39
	ff
	ff.
	fffff
	ff.ffff
	.f..f.f.f
	f..ffffff
	.ff.f.f...f
	....f..fffffff...f
	..f.fff..ff.f.f.f...
	.ffff.f.ffff..f...f.
	f.f.f.f..ffffff.f...f.f
	f.ffff..f..f.ff.ff.fffff..
	...fff....f.ff..f...fffff.
	fff.f.ff.fffffff.f.ffff.ff.fff
	ffffff...ff.f.fff.ff.fff.f.f.ffffff..
	fffff.fff.ffffffff..fffffff.ffffffffffffffff
	f.fffff..f....ffff...f..f.fff....f..fff.f.f.f
	.fffff.ff.fffff.ffff.ff.f..ff.fffff.ff.fffffffff
	..fffffff.ffffffff.fffffffffffff..fffffffffffff.f
	.f.f..ff..f.ffff.f..f.fff.ffff...f..f.f...f.ff.ff
	....f.f....f.ff.f..ff..fff..fff.ffff...ff..f...fff.
	.ff..fff...ff.f...f.f..f....f.ff.f.f.fff..fff.ff..f
	fff.ffff..fffffffffffffff.fffffffff.f...f.fffff.f..f.f..f
	f.ff.f.ff.......f..ff.fff..ff...fff.fff..ffff.ff...ff...f
	fff.f.ff..f.f..f.ffffffffff.ff..f...f..fffff..f...ffffff..fff
	..fffff.ffff.ff..fffff.f.f.f.fff.ff.ffffffff.ff.ffffffff....f.f
	f.f...fff.f.ffff.ffff..f..f..f..f.....f.f....fffff.f..f.ff..f.fffff.
	fffffffffffffff..fffffff.fffffff.f.fffffffffffffff.ff.ff.fffff.ff.ff.
	fffffffffffffffff..f..fff.fff.ffffffffffff.fffffff.fffff.fff.fff.ffffffffff.fff
	fffff.....ff..ff..f..fff..ff.fffffff..ff......ffffffff.f.fff.ff.f...f...ff.f.f.f.f.
	ffff..ff..ffff.f.ffff..ffff.fff.ffff.f.ff...ff.fff.fffff.fffffffffff.fff.fffffffff.ff
	f.f.....ffffffffffff..f.f..f..ff..ff..f..f.ff....f.fff.fff.fff.f......f..ff.ffff.f.f.
	ff.fffff.fff...ffff..f.f..f.f..fffffffffff..fffffffffff.ff.ff..fff.ffff.ff.ffff.fff.ffffff
	.f..ffff.f.f.ff..ffffff..f.fffffffff.ffffff.fffffff.ff.ff..fffffff.f.ff.ffffffffffffff.f.f
	f.ffffffffffffffffff.ffffff.fff.ffff.fffffff.f.ffff.ffffff.fff..ffff.fffffffff.ffff.ffff.f.
	f.f..ff.f.ffff.f.f..f..ff.ff.f.f.f..ff.ffff....f..ff.f.fffffffff.f.f..fff.f..ff...fff.f.fff..
	ffff.f.f.ffffffff.fffffffffffff.ff..fffff..f.ffffff.fff.f.ff.f.fffff..f.fffffff.ffffff.fff.ff.ff
	.f.ffff.ff.ff.fff.fffff.fffffffff..fff.f.f.ff...ff.f.f..ffffff.fff.f..fff.f.f.f.ffff..ff....ff.fff
	......ff..f......f.f.f..f....ff.fff.f.f.f.f..f.fff.fffff....fffff.f.f.f...fffff.f.........f.ff.f..";

	static final trapsInFamesResult = parseResult(
	"1
	1
	2
	3
	3
	3
	3
	5
	5
	6
	6
	8
	6
	9
	10
	14
	13
	15
	15
	14
	11
	13
	17
	14
	17
	19
	19
	22
	25
	22
	26
	22
	26
	28
	28
	26
	29
	26
	22" );

	static final ambushes =
	"80
	..f
	f.f..f
	ff.ff.
	ff.f.f.
	.fff.f..f
	f.ff.f..f
	fff..f.ff.
	f.f...fff...f
	..fffff.....ff
	f.....ffffff.f.
	f...fffff...ffff
	f.ffff..f....f.f
	f...f..f.f.f.ff..
	f.f..f...fffff.ff...
	ff.....ff.....f....ff
	...f..f..f.f.f.f.f.fff
	fff.f.ffff..f.f.f.f.ff
	f....f...ff...ff.fffffff
	.fff.f.f.f.f.f.f....ffff...
	.f.f......ff..f.ff.ff.ff..f...
	fffffff.....f.f.ff..fffff...fff
	f....ff.....f......ff...f.fff...
	fff...fff.fff..fff.f.ff...ff....
	fff...ff...f.....ffffff.ff...f.f.f.
	...ff.ff..ff..f...ff.f.....f.f..ff.
	ff.f.fff.fff...f.f..f.f.f..f...ffff
	..f.f.f.f..f.ff..fff.f.ff......ffff
	.ff..fff..f.ff.ff...f.fff...ff.fff..f..
	f..f.fff.ff..f.ff..f..f..ffff...f......f
	..f.f.f.....f...f.f....f.ff.f.ffff..fff.
	.ff.fff.ff..f.fff.ff..ff...f...f...f.f.f.
	f.ff.f..ff.ffff.....f...f.ffff....ffff.f..f
	.....f.f.f..fff.f..ff.f.f..fff...ff.ff.f.f.
	.fff.ff.f.ff.ff....ff.f...ff..f...f....f.ff.f
	.ff.f.ff...ff.ffff.f...ff.fff.f.f...f.f.ff..f
	.ff....f.ff.f..f...ffffffff..f.f...f.fffffff.ff.ff
	ff..ff..f.f.ff.f.ff.ff..f.f....f.f.f.fff...f.ff....
	ff...ff.ff..ff.fff..fff..f.f......f.ff..fff..f.f.ff
	.fffff..f.ff...ff..fff.f.f..f.f.f.fffffff.ff...f..f.
	.fffffff.fffff...f..ff..ff..f.ff....f.ffffff.ff.ff.ff..f
	f.ffff.f..f.f.ff.f.....ff..f.ffff..f..ff...ffff.ff.......
	...ff.f..f.........f.f..fff...ffff.f...ffff......f...fff..
	f.f..f...f.f..fff...f.ff.fff..ff.ffff..f.f.fff.ff.f.........
	ffff.ff.ff..f....ff....ff.......f....ffff...ff.f.f...f..ff...
	f.f...ff.f..f.f.ff.f..ff.f....ffff.ff.ff.ff.f...f..fff.ff..f.
	..ffff...f.ff.f.f..ffff..f...ffffff.ff..ffff.f.f..f......f....f
	f..fff.f.....f.ff.ffff.f.f...fff.fffffff.......ff.fff.fff.f..f.f
	f...f.f...f...ff.f.f.fff.ff...f.ff.f.fff....ff....f.ff..f..fff.f
	....fff.ff...f....ff.ffff...fffff....f..f.f.fff........f..fff.f.
	f.ffffff.ff.ffff....ff.fff.f.f..ffff.ff.f.....f.f.ff......f.f..f...
	.f...f.f..ffff.ff.f.f.fff.ffff.f...f..fff.f.ff.fff.ffff.ff......fff
	ff.f.f.f..f.f..f..ffff.ff.f.ffff.ff.f..f..f..f.f..f.f...f.f.f.f..fff
	.fff.f.ff..ff.....f..f.f...f.ff......ff.f...ffffffffff........f.ff..
	ffff..f.fff..ff.ff.ffff.fff..ff.f.ff.f.ff..ff.f...ff.ff..f.f..ff.fff.
	...fff....ffffff..f...f.fff.f.f.f.fff.f..f..fffff..f....ff..f..ff...f
	...f.ff..ff..f...ff..f.f...f.fff.f..f...ffff...f.f.f.ff.f..f..ffff.fff.
	ff.f.fff...f.f..........f..ff.f.f..ff.fff...fff.f.f.....f.ff..f.f.f.f.f
	..f.fffff..f.ffff....ff.fffff.ff.ff..f.f.f..fffffffff.ff...ff....fffff.
	f.ffff..fffff..f.f..ff...ffffff..f.f.f..f.ff..f...f...ffff.ff.ff...f.ff
	fffff..ff.ff...fff..ff....f..f.f.fff..f...ff..ffffff..fffffff..f...ff.f.
	f...f.ff...f.fffff.....f.ff....fff.ffff....ff.f....f.f.f....f.f.fff.ff.f
	...f.....ff.ff...ff.f.f...ffff.ff.f.f.f....f.f.....f...f.ffff...f.fff...f..
	ff..f.f.ffff....fff.....fff....ff.f.f..f.f.f.ff.ff..f.ff..f.f......ff.fff..
	...f......f.f.f...ff.fff.fff.ffff..ffff...f..........ff.f..f..f..f.ff.f.ff..
	.ff..f.ff..f..f..f..f..f.f..fff.....f.ffff.f..f.f..f..ffff............f.....f
	f..fffff.fff...f.fff..f.f.f.f..fff.fff.fffffffffffff.f..f..ff....ffff..f.ffff.
	.f...ff..ff......f.f..fffff....fff..f.ff...f.f.ffff.f.ff...f...ff.f.ffffff...f.
	....ff.ff.f.f.f...fffff..f.f..f...fffffff.fff....ffff.fff.......f..f...f....f.f
	..fffff....f.ff.f..fff..f..f..f.fff.ff...fff...f.ff.f.ff.ff...f...f.f..fffffff..f.
	.ff.ff..f..f.fffff.f..f.f.ff...f.....f.ff.f.fff....f.ff...ff.ff.f..f..f.f.f...ff.ff
	..f.f.fffff.ff..f.f..fff.fff..ff...f.......f.f....f.f..f...ff..fffff...ff...f.ff..ff
	.fff.ff....fff.fffff.fffff...ff.....f.fffffff.....fff...f..f...fff.ff...f.f.fff.f..ff..
	f.f.f......ff..f....ff..ffff.ff.fff.f..ff..f..f......ffff.ff.f.ff.....ff..ff.ff..fffff.
	f..ff.f.fffffff...f....f..ff..ff....fff....ff...ff...ff.ffff......f.f..f..f....f...f.f.ffff
	.f..f.ff...f.f...fff...f...fff.f.ff.fff.f.fff..f.f.f.ff.ff..ff.ff.fff.f...fffff...f.ff.ff..f.
	ff..ff.f.f.....ffff..f..f.f..ffffffff......ffff...fffff.ff...f..f.ffff......f.f.fffffff..f.f..
	f..f.f...ff..ff.ff.fff...ff...fff.f..fff.fffff.f.ff.ff.ff.f.ff.ffff....ffff.f.f...fff....ffffff
	.f.f.f.f...f..ff..ff.ffff.fffff.ff....fffff.fff..f.f.ffff..ff...f..f..ff.ffff..f.f.f....ff..f..ff
	.ff.f..f.f.f..fffffffff..ff..ffff.ff.f.f.ff.f.f..f..fff.f...ff..f.fff.f..ffff....f..f.fff...fff.f
	ff.ff......f.f..ff..f..fffff.fff..fffff.f....f.f.f.f.f.ffff...ff.ffff.fffffffff.fff..ff..f.ff.f...";

	static final ambushesResult = parseResult(
	"1
	2
	2
	2
	3
	3
	3
	3
	3
	4
	5
	4
	5
	5
	4
	6
	6
	7
	6
	7
	8
	6
	7
	8
	8
	10
	9
	10
	12
	9
	11
	11
	10
	12
	12
	13
	13
	12
	14
	17
	14
	11
	14
	14
	17
	17
	16
	16
	14
	16
	18
	18
	16
	20
	18
	19
	16
	19
	20
	19
	19
	16
	17
	18
	18
	21
	19
	19
	21
	22
	19
	20
	22
	22
	26
	23
	25
	27
	28
	25" );

}

