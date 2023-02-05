package test;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "ABC Test 1", {			Main.process( "ABC" ).should.be( test1Result ); });
			it( "QXYZ Test 2", {		Main.process( "QXYZ" ).should.be( test2Result ); });
			it( "HELLO Test 3", {		Main.process( "HELLO" ).should.be( test3Result ); });
			it( "WORLD Test 4", {		Main.process( "WORLD" ).should.be( test4Result ); });
			it( "A Test 5", {			Main.process( "A" ).should.be( test5Result ); });
			it( "QUICK Test 6", {		Main.process( "QUICK" ).should.be( test6Result ); });
			it( "BROWN Test 7", {		Main.process( "BROWN" ).should.be( test7Result ); });
			it( "FOX Test 8", {			Main.process( "FOX" ).should.be( test8Result ); });
			it( "JUMPS Test 9", {		Main.process( "JUMPS" ).should.be( test9Result ); });
			it( "OVER Test 10", {		Main.process( "OVER" ).should.be( test10Result ); });
			it( "THE Test 11", {		Main.process( "THE" ).should.be( test11Result ); });
			it( "LAZY Test 12", {		Main.process( "LAZY" ).should.be( test12Result ); });
			it( "DOG Test 13", {		Main.process( "DOG" ).should.be( test13Result ); });
			it( "ATARI Test 14", {		Main.process( "ATARI" ).should.be( test14Result ); });
			it( "CODINGAME Test 15", {	Main.process( "CODINGAME" ).should.be( test15Result ); });
		});
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

final test1Result = parseResult(
"   XX    XXXX     XXX
   XX    X   X   X   X
  X  X   XXXX   X
  XXXX   X   X  X
 X    X  X   X   X   X
 X    X  XXXX     XXX" );

final test2Result = parseResult(
"   XXX   X    X  X     X XXXXXX
  X   X   X  X    X   X      X
  X   X    XX      X X      X
  X   X    XX       X      X
  X   X   X  X      X     X
   XXX   X    X     X    XXXXXX
      X" );

final test3Result = parseResult(
" X    X  XXXXX   X       X         XXX
 X    X  X       X       X        X   X
 XXXXXX  XXXX    X       X        X   X
 X    X  X       X       X        X   X
 X    X  X       X       X        X   X
 X    X  XXXXX   XXXXXX  XXXXXX    XXX" );

final test4Result = parseResult(
" X     X   XXX   XXXX    X       XXXX
 X     X  X   X  X   X   X       X   X
 X  X  X  X   X  XXXX    X       X   X
 X X X X  X   X  X X     X       X   X
 XX   XX  X   X  X  X    X       X   X
 X     X   XXX   X   X   XXXXXX  XXXX" );

final test5Result = parseResult(
"   XX
   XX
  X  X
  XXXX
 X    X
 X    X" );

final test6Result = parseResult(
"   XXX   X    X   XXXXX   XXX    X   X
  X   X  X    X     X    X   X   X  X
  X   X  X    X     X   X        X X
  X   X  X    X     X   X        XXX
  X   X  X    X     X    X   X   X  X
   XXX    XXXX    XXXXX   XXX    X   X
      X" );

final test7Result = parseResult(
" XXXX    XXXX      XXX   X     X X    X
 X   X   X   X    X   X  X     X XX   X
 XXXX    XXXX     X   X  X  X  X X X  X
 X   X   X X      X   X  X X X X X  X X
 X   X   X  X     X   X  XX   XX X   XX
 XXXX    X   X     XXX   X     X X    X" );

final test8Result = parseResult(
" XXXXX     XXX   X    X
 X        X   X   X  X
 XXXX     X   X    XX
 X        X   X    XX
 X        X   X   X  X
 X         XXX   X    X" );

final test9Result = parseResult(
"   XXX   X    X  X     X XXXX      XXX
     X   X    X  XX   XX X   X    X   X
     X   X    X  X X X X XXXX      X
     X   X    X  X  X  X X          XX
 X   X   X    X  X     X X        X   X
  XXX     XXXX   X     X X         XXX" );

final test10Result = parseResult(
"   XXX  X      X XXXXX   XXXX
  X   X  X    X  X       X   X
  X   X  X    X  XXXX    XXXX
  X   X   X  X   X       X X
  X   X   X  X   X       X  X
   XXX     XX    XXXXX   X   X" );

final test11Result = parseResult(
" XXXXXXX X    X  XXXXX
    X    X    X  X
    X    XXXXXX  XXXX
    X    X    X  X
    X    X    X  X
    X    X    X  XXXXX" );

final test12Result = parseResult(
" X         XX    XXXXXX  X     X
 X         XX        X    X   X
 X        X  X      X      X X
 X        XXXX     X        X
 X       X    X   X         X
 XXXXXX  X    X  XXXXXX     X" );

final test13Result = parseResult(
" XXXX      XXX    XXX
 X   X    X   X  X   X
 X   X    X   X X
 X   X    X   X X  XXX
 X   X    X   X  X   X
 XXXX      XXX    XXX" );

final test14Result = parseResult(
"   XX    XXXXXXX   XX    XXXX     XXXXX
   XX       X      XX    X   X      X
  X  X      X     X  X   XXXX       X
  XXXX      X     XXXX   X X        X
 X    X     X    X    X  X  X       X
 X    X     X    X    X  X   X    XXXXX" );

final test15Result = parseResult(
"  XXX      XXX   XXXX     XXXXX  X    X   XXX      XX    X     X XXXXX
 X   X    X   X  X   X      X    XX   X  X   X     XX    XX   XX X
X         X   X  X   X      X    X X  X X         X  X   X X X X XXXX
X         X   X  X   X      X    X  X X X  XXX    XXXX   X  X  X X
 X   X    X   X  X   X      X    X   XX  X   X   X    X  X     X X
  XXX      XXX   XXXX     XXXXX  X    X   XXX    X    X  X     X XXXXX" );
}
