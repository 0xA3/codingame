package test;

import Main;
import Std.parseInt;

using Lambda;
using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.r, ip.c, ip.pixels, ip.m, ip.n, ip.weights ).should.be( test1Result );
			});
			
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.r, ip.c, ip.pixels, ip.m, ip.n, ip.weights ).should.be( test2Result );
			});
			
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.r, ip.c, ip.pixels, ip.m, ip.n, ip.weights ).should.be( test3Result );
			});
			
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.r, ip.c, ip.pixels, ip.m, ip.n, ip.weights ).should.be( test4Result );
			});
			
		});
			
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split(' ');
		final r = parseInt(inputs[0]);
		final c = parseInt(inputs[1]);
		final pixels = [for( i in 0...r ) {
			var inputs = lines[i + 1].split(' ');
			[for( j in 0...c ) parseInt( inputs[j] )];
		}];
		
		var inputs = lines[r + 1].split(' ');
		final m = parseInt(inputs[0]);
		final n = parseInt(inputs[1]);
		final weights = [for( i in 0...m ) {
			var inputs = lines[i + r + 2].split(' ');
			[for( j in 0...n ) parseInt( inputs[j] )];
		}];
		// trace( 'r: $r, c: $c\n$pixels\nm: $m, n: $n\n$weights' );
		return { r: r, c: c, pixels: pixels, m: m, n: n, weights: weights };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final test1 = parseInput(
		"3 3
		100 200 100
		200 100 200
		50 100 50
		2 2
		-1 1
		1 -1"
	);

	final test1Result = parseResult(
		"200 -200
		-150 150"
	);
	
	final test2 = parseInput(
		"5 5
		100 200 0 200 240
		20 230 240 0 250
		117 199 200 267 83
		29 212 243 111 33
		100 200 300 400 500
		3 3
		-1 0 -1
		-1 0 -1
		-1 0 -1"
	);

	final test2Result = parseResult(
		"-677 -1096 -1013
		-849 -1019 -1049
		-989 -1389 -1359"
	);
	
	final test3 = parseInput(
		"10 10
		247 152 122 236 159 118 172 233 133 121
		174 201 193 86 94 203 42 3 69 21
		221 56 36 182 108 163 48 240 119 89
		162 150 97 219 180 133 78 51 237 62
		189 100 234 246 138 50 69 201 90 98
		42 155 149 181 172 194 17 234 134 52
		247 249 131 244 11 227 32 221 14 197
		132 246 162 16 24 185 15 146 156 227
		121 3 118 199 241 231 18 12 152 147
		185 231 237 114 239 145 215 33 218 227
		5 5
		1 1 1 1 1
		1 2 2 2 1
		1 2 3 2 1
		1 2 2 2 1
		1 1 1 1 1"
	);

	final test3Result = parseResult(
		"5238 5033 4882 4664 4140 3970
		5182 5379 4911 4432 4178 3881
		5664 5667 4990 4720 4257 4362
		5714 5580 4839 4388 4271 4366
		5414 5240 4569 4428 4287 4309
		5379 5266 4919 4535 4388 4361"
	);
	
	final test4 = parseInput(
		"10 5
		129 176 6 190 225
		210 5 179 222 62
		137 51 87 40 106
		173 149 166 183 85
		53 81 213 6 228
		144 73 6 216 183
		32 9 200 34 54
		68 197 15 183 138
		143 197 113 34 94
		101 98 139 89 207
		3 3
		2 2 2
		2 5 2
		2 2 2"
	);

	final test4Result = parseResult(
		"1975 2449 2900
		2467 2425 2380
		2667 2450 2777
		2359 2825 2590
		1841 1694 2928
		1515 2466 2160
		2539 2009 2279
		2733 2469 2126"
	);
	
}

