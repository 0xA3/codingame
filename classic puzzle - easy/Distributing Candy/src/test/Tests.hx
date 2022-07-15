package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test 1", {
				final ip = test1;
				Main.process( ip.n, ip.m, ip.bags ).should.be( 2 );
			} );
			it( "Test 2", {
				final ip = test2;
				Main.process( ip.n, ip.m, ip.bags ).should.be( 5 );
			} );
			it( "Test 3", {
				final ip = test3;
				Main.process( ip.n, ip.m, ip.bags ).should.be( 23 );
			} );
			it( "Test 4", {
				final ip = test4;
				Main.process( ip.n, ip.m, ip.bags ).should.be( 13 );
			} );
			it( "Test 5", {
				final ip = test5;
				Main.process( ip.n, ip.m, ip.bags ).should.be( 20 );
			} );
		} );
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final inputs = lines[0].split( ' ' );
		final n = parseInt( inputs[0] );
		final m = parseInt( inputs[1] );
		final inputs = lines[1].split( ' ' );
		final bags = [for( i in 0...n ) parseInt( inputs[i] )];

		return { n: n, m: m, bags: bags }
	}

	static final test1 = parseInput( "6 3
	7 1 3 10 12 10" );

	static final test2 = parseInput( "26 5
	0 0 16 61 22 26 58 38 61 68 2 59 3 23 67 68 33 90 27 35 49 97 8 97 10 25" );

	static final test3 = parseInput( "72 21
	0 1 19 31 36 23 6 35 11 73 38 4 22 70 16 49 31 87 62 91 61 72 47 53 4 21 67 65 77 34 60 27 96 59 9 70 13 29 79 32 81 47 30 82 87 93 10 89 97 21 17 68 55 14 82 69 46 85 7 28 66 87 49 97 81 0 58 90 3 35 96 20" );

	static final test4 = parseInput( "240 41
	0 5 42 25 30 62 20 78 29 35 73 87 38 3 23 94 92 9 94 35 45 1 11 66 47 19 2 41 93 60 16 99 39 79 59 65 65 42 58 71 73 56 36 70 99 32 8 51 79 6 28 58 9 8 42 5 26 31 43 8 31 45 91 37 45 36 23 92 2 76 14 56 67 35 75 77 89 56 13 49 83 73 40 64 97 38 54 76 0 82 51 0 30 20 54 95 4 94 37 16 10 29 13 9 22 55 67 35 95 67 59 91 91 28 61 97 8 12 85 40 58 91 88 21 85 96 77 12 25 60 49 18 2 87 16 65 81 29 41 71 35 96 23 86 49 2 35 80 31 96 73 29 78 57 0 61 58 72 62 6 49 38 34 25 70 35 25 84 44 55 42 1 28 2 15 77 34 77 40 79 26 26 38 33 78 5 67 27 97 60 97 67 70 31 10 46 53 10 65 6 81 72 21 63 98 90 19 73 98 38 94 11 4 76 83 33 0 55 17 73 18 9 69 20 46 62 93 62 40 69 55 26 82 97 76 33 45 55 83 16" );

	static final test5 = parseInput( "192 51
	0 1 53 98 15 96 37 5 48 90 14 1 48 98 32 9 59 21 35 53 34 16 92 41 64 8 15 12 57 19 32 63 76 33 44 90 67 70 11 51 72 73 98 50 80 20 7 69 67 81 88 9 19 70 50 72 37 50 36 66 27 32 50 96 74 78 32 20 91 28 72 62 23 43 13 19 84 16 57 78 37 30 91 59 34 48 1 4 64 31 29 87 66 74 72 81 32 99 64 80 34 15 4 71 70 77 19 68 55 32 89 56 48 44 77 58 18 83 79 76 49 46 62 61 98 16 23 62 83 27 25 68 9 21 77 46 33 96 80 45 25 64 89 34 85 70 83 30 5 1 0 66 60 53 26 58 82 13 82 89 1 14 21 54 76 53 26 24 48 88 85 35 64 84 84 98 64 63 8 95 2 49 75 74 56 83 62 63 33 51 48 16" );
}
