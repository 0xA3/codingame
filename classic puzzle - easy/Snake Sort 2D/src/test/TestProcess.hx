package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Test1", { Main.process( test1 ).should.be( test1Result ); });
			it( "Test2", { Main.process( test2 ).should.be( test2Result ); });
			it( "Test3", { Main.process( test3 ).should.be( test3Result ); });
			it( "Test4", { Main.process( test4 ).should.be( test4Result ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final n = parseInt( lines[0] );
		final apples = [for( i in 0...n ) {
			var inputs = lines[i + 1].split(' ');
			 { name: inputs[0], y: parseInt( inputs[1] ), x: parseInt( inputs[2] ) }
		}];

		return apples;
	}
	
	final test1 = parseInput(
	"4
	A 0 10
	B 0 20
	C 1 10
	D 1 20" );
	
	final test1Result = "A,B,D,C";
	
	final test2 = parseInput(
	"26
	A 41 56
	B 76 85
	C 8 15
	D 4 7
	E 69 8
	F 25 75
	G 35 88
	H 69 3
	I 10 58
	J 52 80
	K 24 37
	L 2 56
	M 91 24
	N 56 92
	O 52 81
	P 63 94
	Q 2 32
	R 41 9
	S 81 85
	T 46 26
	U 9 92
	V 80 94
	W 4 32
	X 37 54
	Y 92 14
	Z 81 73" );
	
	final test2Result = "Q,L,W,D,C,U,I,K,F,G,X,A,R,T,O,J,N,P,H,E,B,V,S,Z,M,Y";
	
	final test3 = parseInput(
	"26
	A 57 43
	B 60 70
	C 90 60
	D 95 66
	E 42 75
	F 48 10
	G 5 58
	H 10 47
	I 13 50
	J 56 42
	K 27 86
	L 33 36
	M 8 97
	N 2 14
	O 54 6
	P 27 69
	Q 51 97
	R 62 22
	S 90 16
	T 8 48
	U 56 94
	V 90 9
	W 1 49
	X 33 83
	Y 86 76
	Z 95 8" );
	
	final test3Result = "W,N,G,M,T,H,I,P,K,X,L,E,F,Q,O,J,U,A,B,R,Y,C,S,V,Z,D";
	
	final test4 = parseInput(
	"26
	A 65 6
	B 6 41
	C 83 52
	D 39 72
	E 98 89
	F 2 43
	G 11 3
	H 3 17
	I 48 62
	J 94 39
	K 6 80
	L 14 74
	M 13 25
	N 18 85
	O 83 6
	P 40 39
	Q 66 5
	R 92 36
	S 54 62
	T 53 50
	U 19 6
	V 3 73
	W 34 85
	X 6 73
	Y 2 60
	Z 0 3" );
	
	final test4Result = "Z,Y,F,H,V,K,X,B,G,M,L,N,U,W,D,P,I,T,S,A,Q,C,O,R,J,E";
}
