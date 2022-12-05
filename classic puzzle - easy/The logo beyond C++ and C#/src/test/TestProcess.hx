package test;

import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Thickness 1", {
				final ip = thickness1;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( thickness1Result );
			});
			it( "Thickness 2", {
				final ip = thickness2;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( thickness2Result );
			});
			it( "C Sharp Plus Test 1", {
				final ip = cSharpPlusTest1;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cSharpPlusTest1Result );
			});
			it( "C Venn Test 2", {
				final ip = cVennTest2;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cVennTest2Result );
			});
			it( "C Plus Plus and Plus Test 3", {
				final ip = cPlusPlusAndPlusTest3;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cPlusPlusAndPlusTest3Result );
			});
			it( "C-hi Test 4", {
				final ip = cHiTest4;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cHiTest4Result );
			});
			it( "C Climb Test 5", {
				final ip = cClimbTest5;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cClimbTest5Result );
			});
			it( "C-Cliff Test 6", {
				final ip = cCliffTest6;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cCliffTest6Result );
			});
			it( "C-X Test 7", {
				final ip = CXTest7;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( CXTest7Result );
			});
			it( "Tic Tac C Test 8", {
				final ip = ticTacCTest8;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( ticTacCTest8Result );
			});
			it( "C-Check Test 9", {
				final ip = cCheckTest9;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cCheckTest9Result );
			});
			it( "C-Checkers Test 10", {
				final ip = cCheckersTest10;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cCheckersTest10Result );
			});
			it( "C Sharp Sharp Test 11", {
				final ip = cSharpSharpTest11;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cSharpSharpTest11Result );
			});
			it( "C Sharp Plus Sharp Test 12", {
				final ip = cSharpPlusSharpTest12;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cSharpPlusSharpTest12Result );
			});
			it( "C Pyramid Test 13", {
				final ip = cPyramidTest13;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cPyramidTest13Result );
			});
			it( "Greater Than C Test 14", {
				final ip = greaterThanCTest14;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( greaterThanCTest14Result );
			});
			it( "Giant C Test 15", {
				final ip = GiantCTest15;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( GiantCTest15Result );
			});
			it( "One Thick C Test 16", {
				final ip = oneThickCTest16;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( oneThickCTest16Result );
			});
			it( "C-U Test 17", {
				final ip = CUTest17;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( CUTest17Result );
			});
			it( "You can C forever Test 18", {
				final ip = youCanCForeverTest18;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( youCanCForeverTest18Result );
			});
			it( "I C U Test 19", {
				final ip = ICUTest19;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( ICUTest19Result );
			});
			it( "C-Nake (Snake) Test 20", {
				final ip = cNakeSnakeTest20;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cNakeSnakeTest20Result );
			});
			it( "C-Legs Test 21", {
				final ip = cLegsTest21;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cLegsTest21Result );
			});
			it( "C You Tuesday Test 22", {
				final ip = cYouTuesdayTest22;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cYouTuesdayTest22Result );
			});
			it( "C-Man Test 23", {
				final ip = cManTest23;
				Main.process( ip.size, ip.thickness, ip.logoLines ).should.be( cManTest23Result );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		
		final size = parseInt( lines[0] );
		final thickness = parseInt( lines[1] );
		final n = parseInt( lines[2] );
		final logoLines = lines.slice( 3 );
			
		return { size: size, thickness: thickness, logoLines: logoLines };
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final thickness1 = parseInput(
	"3
	1
	1
	+" );

	final thickness1Result = parseResult(
	" +
	+++
	 +" );

	final thickness2 = parseInput(
	"6
	2
	1
	+" );

	final thickness2Result = parseResult(
	"  ++
	  ++
	++++++
	++++++
	  ++
	  ++" );

	final cSharpPlusTest1 = parseInput(
	"13
	5
	2
	+++
	++" );

	final cSharpPlusTest1Result = parseResult(
"    +++++        +++++        +++++
    +   +        +   +        +   +
    +   +        +   +        +   +
    +   +        +   +        +   +
+++++   ++++++++++   ++++++++++   +++++
+                                     +
+                                     +
+                                     +
+++++   ++++++++++   ++++++++++   +++++
    +   +        +   +        +   +
    +   +        +   +        +   +
    +   +        +   +        +   +
    +   +        +   +        +++++
    +   +        +   +
    +   +        +   +
    +   +        +   +
    +   +        +   +
+++++   ++++++++++   +++++
+                        +
+                        +
+                        +
+++++   ++++++++++   +++++
    +   +        +   +
    +   +        +   +
    +   +        +   +
    +++++        +++++" );

	final cVennTest2 = parseInput(
	"11
	3
	3
	++
	+++
	 ++" );

	final cVennTest2Result = parseResult(
"    +++        +++
    + +        + +
    + +        + +
    + +        + +
+++++ ++++++++++ +++++
+                    +
+++++ ++++++++++ +++++
    + +        + +
    + +        + +
    + +        + +
    + +        + +
    + +        + +        +++
    + +        + +        + +
    + +        + +        + +
    + +        + +        + +
+++++ ++++++++++ ++++++++++ +++++
+                               +
+++++ ++++++++++ ++++++++++ +++++
    + +        + +        + +
    + +        + +        + +
    + +        + +        + +
    +++        + +        + +
               + +        + +
               + +        + +
               + +        + +
               + +        + +
           +++++ ++++++++++ +++++
           +                    +
           +++++ ++++++++++ +++++
               + +        + +
               + +        + +
               + +        + +
               +++        +++" );

	final cPlusPlusAndPlusTest3 = parseInput(
	"12
	4
	3
	 +
	+++
	 +" );

	final cPlusPlusAndPlusTest3Result = parseResult(
"                ++++
                +  +
                +  +
                +  +
            +++++  +++++
            +          +
            +          +
            +++++  +++++
                +  +
                +  +
                +  +
                +  +
    ++++        +  +        ++++
    +  +        +  +        +  +
    +  +        +  +        +  +
    +  +        +  +        +  +
+++++  ++++++++++  ++++++++++  +++++
+                                  +
+                                  +
+++++  ++++++++++  ++++++++++  +++++
    +  +        +  +        +  +
    +  +        +  +        +  +
    +  +        +  +        +  +
    ++++        +  +        ++++
                +  +
                +  +
                +  +
                +  +
            +++++  +++++
            +          +
            +          +
            +++++  +++++
                +  +
                +  +
                +  +
                ++++" );

	final cHiTest4 = parseInput(
	"9
	3
	3
	+
	+++ +
	+ + +" );

	final cHiTest4Result = parseResult(
"   +++
   + +
   + +
++++ ++++
+       +
++++ ++++
   + +
   + +
   + +
   + +      +++      +++               +++
   + +      + +      + +               + +
   + +      + +      + +               + +
++++ ++++++++ ++++++++ ++++         ++++ ++++
+                         +         +       +
++++ ++++++++ ++++++++ ++++         ++++ ++++
   + +      + +      + +               + +
   + +      + +      + +               + +
   + +      +++      + +               + +
   + +               + +               + +
   + +               + +               + +
   + +               + +               + +
++++ ++++         ++++ ++++         ++++ ++++
+       +         +       +         +       +
++++ ++++         ++++ ++++         ++++ ++++
   + +               + +               + +
   + +               + +               + +
   +++               +++               +++" );

	final cClimbTest5 = parseInput(
	"13
	7
	3
	+
	++
	+++" );

	final cClimbTest5Result = parseResult(
"   +++++++
   +     +
   +     +
++++     ++++
+           +
+           +
+           +
+           +
+           +
++++     ++++
   +     +
   +     +
   +     +
   +     +      +++++++
   +     +      +     +
   +     +      +     +
++++     ++++++++     ++++
+                        +
+                        +
+                        +
+                        +
+                        +
++++     ++++++++     ++++
   +     +      +     +
   +     +      +     +
   +     +      +     +
   +     +      +     +      +++++++
   +     +      +     +      +     +
   +     +      +     +      +     +
++++     ++++++++     ++++++++     ++++
+                                     +
+                                     +
+                                     +
+                                     +
+                                     +
++++     ++++++++     ++++++++     ++++
   +     +      +     +      +     +
   +     +      +     +      +     +
   +++++++      +++++++      +++++++" );

	final cCliffTest6 = parseInput(
	"10
	4
	3
	+++
	 ++
	  +" );

	final cCliffTest6Result = parseResult(
"   ++++      ++++      ++++
   +  +      +  +      +  +
   +  +      +  +      +  +
++++  ++++++++  ++++++++  ++++
+                            +
+                            +
++++  ++++++++  ++++++++  ++++
   +  +      +  +      +  +
   +  +      +  +      +  +
   ++++      +  +      +  +
             +  +      +  +
             +  +      +  +
             +  +      +  +
          ++++  ++++++++  ++++
          +                  +
          +                  +
          ++++  ++++++++  ++++
             +  +      +  +
             +  +      +  +
             ++++      +  +
                       +  +
                       +  +
                       +  +
                    ++++  ++++
                    +        +
                    +        +
                    ++++  ++++
                       +  +
                       +  +
                       ++++" );

	final CXTest7 = parseInput(
	"7
	3
	3
	+ +
	 +
	+ +" );

	final CXTest7Result = parseResult(
"  +++           +++
  + +           + +
+++ +++       +++ +++
+     +       +     +
+++ +++       +++ +++
  + +           + +
  +++           +++
         +++
         + +
       +++ +++
       +     +
       +++ +++
         + +
         +++
  +++           +++
  + +           + +
+++ +++       +++ +++
+     +       +     +
+++ +++       +++ +++
  + +           + +
  +++           +++" );

	final ticTacCTest8 = parseInput(
	"10
	6
	3
	+++
	+++
	+++" );

	final ticTacCTest8Result = parseResult(
"  ++++++    ++++++    ++++++
  +    +    +    +    +    +
+++    ++++++    ++++++    +++
+                            +
+                            +
+                            +
+                            +
+++    ++++++    ++++++    +++
  +    +    +    +    +    +
  +    +    +    +    +    +
  +    +    +    +    +    +
  +    +    +    +    +    +
+++    ++++++    ++++++    +++
+                            +
+                            +
+                            +
+                            +
+++    ++++++    ++++++    +++
  +    +    +    +    +    +
  +    +    +    +    +    +
  +    +    +    +    +    +
  +    +    +    +    +    +
+++    ++++++    ++++++    +++
+                            +
+                            +
+                            +
+                            +
+++    ++++++    ++++++    +++
  +    +    +    +    +    +
  ++++++    ++++++    ++++++" );

	final cCheckTest9 = parseInput(
	"8
	4
	4
	    +
	   +
	+ +
	 +" );

	final cCheckTest9Result = parseResult(
"                                  ++++
                                  +  +
                                +++  +++
                                +      +
                                +      +
                                +++  +++
                                  +  +
                                  ++++
                          ++++
                          +  +
                        +++  +++
                        +      +
                        +      +
                        +++  +++
                          +  +
                          ++++
  ++++            ++++
  +  +            +  +
+++  +++        +++  +++
+      +        +      +
+      +        +      +
+++  +++        +++  +++
  +  +            +  +
  ++++            ++++
          ++++
          +  +
        +++  +++
        +      +
        +      +
        +++  +++
          +  +
          ++++" );

	final cCheckersTest10 = parseInput(
	"9
	3
	4
	++
	++
	  ++
	  ++" );

	final cCheckersTest10Result = parseResult(
"   +++      +++
   + +      + +
   + +      + +
++++ ++++++++ ++++
+                +
++++ ++++++++ ++++
   + +      + +
   + +      + +
   + +      + +
   + +      + +
   + +      + +
   + +      + +
++++ ++++++++ ++++
+                +
++++ ++++++++ ++++
   + +      + +
   + +      + +
   +++      +++
                     +++      +++
                     + +      + +
                     + +      + +
                  ++++ ++++++++ ++++
                  +                +
                  ++++ ++++++++ ++++
                     + +      + +
                     + +      + +
                     + +      + +
                     + +      + +
                     + +      + +
                     + +      + +
                  ++++ ++++++++ ++++
                  +                +
                  ++++ ++++++++ ++++
                     + +      + +
                     + +      + +
                     +++      +++" );

	final cSharpSharpTest11 = parseInput(
	"9
	5
	2
	++ ++
	++ ++" );

	final cSharpSharpTest11Result = parseResult(
"  +++++    +++++             +++++    +++++
  +   +    +   +             +   +    +   +
+++   ++++++   +++         +++   ++++++   +++
+                +         +                +
+                +         +                +
+                +         +                +
+++   ++++++   +++         +++   ++++++   +++
  +   +    +   +             +   +    +   +
  +   +    +   +             +   +    +   +
  +   +    +   +             +   +    +   +
  +   +    +   +             +   +    +   +
+++   ++++++   +++         +++   ++++++   +++
+                +         +                +
+                +         +                +
+                +         +                +
+++   ++++++   +++         +++   ++++++   +++
  +   +    +   +             +   +    +   +
  +++++    +++++             +++++    +++++" );

	final cSharpPlusSharpTest12 = parseInput(
	"9
	3
	3
	++
	+++++
	   ++" );

	final cSharpPlusSharpTest12Result = parseResult(
"   +++      +++
   + +      + +
   + +      + +
++++ ++++++++ ++++
+                +
++++ ++++++++ ++++
   + +      + +
   + +      + +
   + +      + +
   + +      + +      +++      +++      +++
   + +      + +      + +      + +      + +
   + +      + +      + +      + +      + +
++++ ++++++++ ++++++++ ++++++++ ++++++++ ++++
+                                           +
++++ ++++++++ ++++++++ ++++++++ ++++++++ ++++
   + +      + +      + +      + +      + +
   + +      + +      + +      + +      + +
   +++      +++      +++      + +      + +
                              + +      + +
                              + +      + +
                              + +      + +
                           ++++ ++++++++ ++++
                           +                +
                           ++++ ++++++++ ++++
                              + +      + +
                              + +      + +
                              +++      +++" );

	final cPyramidTest13 = parseInput(
	"8
	4
	3
	  +
	 +++
	+++++" );

	final cPyramidTest13Result = parseResult(
"                  ++++
                  +  +
                +++  +++
                +      +
                +      +
                +++  +++
                  +  +
                  +  +
          ++++    +  +    ++++
          +  +    +  +    +  +
        +++  ++++++  ++++++  +++
        +                      +
        +                      +
        +++  ++++++  ++++++  +++
          +  +    +  +    +  +
          +  +    +  +    +  +
  ++++    +  +    +  +    +  +    ++++
  +  +    +  +    +  +    +  +    +  +
+++  ++++++  ++++++  ++++++  ++++++  +++
+                                      +
+                                      +
+++  ++++++  ++++++  ++++++  ++++++  +++
  +  +    +  +    +  +    +  +    +  +
  ++++    ++++    ++++    ++++    ++++" );

	final greaterThanCTest14 = parseInput(
	"10
	4
	5
	+
	 +
	  +
	 +
	+" );

	final greaterThanCTest14Result = parseResult(
"   ++++
   +  +
   +  +
++++  ++++
+        +
+        +
++++  ++++
   +  +
   +  +
   ++++
             ++++
             +  +
             +  +
          ++++  ++++
          +        +
          +        +
          ++++  ++++
             +  +
             +  +
             ++++
                       ++++
                       +  +
                       +  +
                    ++++  ++++
                    +        +
                    +        +
                    ++++  ++++
                       +  +
                       +  +
                       ++++
             ++++
             +  +
             +  +
          ++++  ++++
          +        +
          +        +
          ++++  ++++
             +  +
             +  +
             ++++
   ++++
   +  +
   +  +
++++  ++++
+        +
+        +
++++  ++++
   +  +
   +  +
   ++++" );

	final GiantCTest15 = parseInput(
	"31
	13
	1
	+" );

	final GiantCTest15Result = parseResult(
"         +++++++++++++
         +           +
         +           +
         +           +
         +           +
         +           +
         +           +
         +           +
         +           +
++++++++++           ++++++++++
+                             +
+                             +
+                             +
+                             +
+                             +
+                             +
+                             +
+                             +
+                             +
+                             +
+                             +
++++++++++           ++++++++++
         +           +
         +           +
         +           +
         +           +
         +           +
         +           +
         +           +
         +           +
         +++++++++++++" );

	final oneThickCTest16 = parseInput(
	"30
	24
	1
	+" );

	final oneThickCTest16Result = parseResult(
"   ++++++++++++++++++++++++
   +                      +
   +                      +
++++                      ++++
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
+                            +
++++                      ++++
   +                      +
   +                      +
   ++++++++++++++++++++++++" );

	final CUTest17 = parseInput(
	"7
	3
	5
	+  +
	+  +
	+  +
	+  +
	++++" );

	final CUTest17Result = parseResult(
"  +++                  +++
  + +                  + +
+++ +++              +++ +++
+     +              +     +
+++ +++              +++ +++
  + +                  + +
  + +                  + +
  + +                  + +
  + +                  + +
+++ +++              +++ +++
+     +              +     +
+++ +++              +++ +++
  + +                  + +
  + +                  + +
  + +                  + +
  + +                  + +
+++ +++              +++ +++
+     +              +     +
+++ +++              +++ +++
  + +                  + +
  + +                  + +
  + +                  + +
  + +                  + +
+++ +++              +++ +++
+     +              +     +
+++ +++              +++ +++
  + +                  + +
  + +                  + +
  + +    +++    +++    + +
  + +    + +    + +    + +
+++ ++++++ ++++++ ++++++ +++
+                          +
+++ ++++++ ++++++ ++++++ +++
  + +    + +    + +    + +
  +++    +++    +++    +++" );

	final youCanCForeverTest18 = parseInput(
	"7
	3
	20
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+
	+" );

	final youCanCForeverTest18Result = parseResult(
"  +++
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  +++" );

	final ICUTest19 = parseInput(
	"5
	3
	11
	 +
	 +
	 +
	
	 ++
	+
	 ++
	
	+ +
	+ +
	 +" );

	final ICUTest19Result = parseResult(
"      +++
     ++ ++
     +   +
     ++ ++
      + +
      + +
     ++ ++
     +   +
     ++ ++
      + +
      + +
     ++ ++
     +   +
     ++ ++
      +++





      +++  +++
     ++ ++++ ++
     +        +
     ++ ++++ ++
      +++  +++
 +++
++ ++
+   +
++ ++
 +++
      +++  +++
     ++ ++++ ++
     +        +
     ++ ++++ ++
      +++  +++





 +++       +++
++ ++     ++ ++
+   +     +   +
++ ++     ++ ++
 + +       + +
 + +       + +
++ ++     ++ ++
+   +     +   +
++ ++     ++ ++
 +++       +++
      +++
     ++ ++
     +   +
     ++ ++
      +++" );

	final cNakeSnakeTest20 = parseInput(
	"7
	3
	11
	++
	 +
	++
	+
	++
	 +
	++
	+
	++
	 +
	++" );

	final cNakeSnakeTest20Result = parseResult(
"  +++    +++
  + +    + +
+++ ++++++ +++
+            +
+++ ++++++ +++
  + +    + +
  +++    + +
         + +
         + +
       +++ +++
       +     +
       +++ +++
         + +
         + +
  +++    + +
  + +    + +
+++ ++++++ +++
+            +
+++ ++++++ +++
  + +    + +
  + +    +++
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +    +++
  + +    + +
+++ ++++++ +++
+            +
+++ ++++++ +++
  + +    + +
  +++    + +
         + +
         + +
       +++ +++
       +     +
       +++ +++
         + +
         + +
  +++    + +
  + +    + +
+++ ++++++ +++
+            +
+++ ++++++ +++
  + +    + +
  + +    +++
  + +
  + +
+++ +++
+     +
+++ +++
  + +
  + +
  + +    +++
  + +    + +
+++ ++++++ +++
+            +
+++ ++++++ +++
  + +    + +
  +++    + +
         + +
         + +
       +++ +++
       +     +
       +++ +++
         + +
         + +
  +++    + +
  + +    + +
+++ ++++++ +++
+            +
+++ ++++++ +++
  + +    + +
  +++    +++" );

	final cLegsTest21 = parseInput(
	"7
	3
	4
	   +
	+  +
	+  ++
	++" );

	final cLegsTest21Result = parseResult(
"                       +++
                       + +
                     +++ +++
                     +     +
                     +++ +++
                       + +
                       + +
  +++                  + +
  + +                  + +
+++ +++              +++ +++
+     +              +     +
+++ +++              +++ +++
  + +                  + +
  + +                  + +
  + +                  + +    +++
  + +                  + +    + +
+++ +++              +++ ++++++ +++
+     +              +            +
+++ +++              +++ ++++++ +++
  + +                  + +    + +
  + +                  +++    +++
  + +    +++
  + +    + +
+++ ++++++ +++
+            +
+++ ++++++ +++
  + +    + +
  +++    +++" );

	final cYouTuesdayTest22 = parseInput(
	"8
	4
	5
	+ +
	+ +
	+++
	 +
	 +" );

	final cYouTuesdayTest22Result = parseResult(
"  ++++            ++++
  +  +            +  +
+++  +++        +++  +++
+      +        +      +
+      +        +      +
+++  +++        +++  +++
  +  +            +  +
  +  +            +  +
  +  +            +  +
  +  +            +  +
+++  +++        +++  +++
+      +        +      +
+      +        +      +
+++  +++        +++  +++
  +  +            +  +
  +  +            +  +
  +  +    ++++    +  +
  +  +    +  +    +  +
+++  ++++++  ++++++  +++
+                      +
+                      +
+++  ++++++  ++++++  +++
  +  +    +  +    +  +
  ++++    +  +    ++++
          +  +
          +  +
        +++  +++
        +      +
        +      +
        +++  +++
          +  +
          +  +
          +  +
          +  +
        +++  +++
        +      +
        +      +
        +++  +++
          +  +
          ++++" );

	final cManTest23 = parseInput(
	"7
	5
	4
	 ++
	+  +
	+  +
	 ++" );

	final cManTest23Result = parseResult(
"        +++++  +++++
       ++   ++++   ++
       +            +
       +            +
       +            +
       ++   ++++   ++
        +++++  +++++
 +++++                +++++
++   ++              ++   ++
+     +              +     +
+     +              +     +
+     +              +     +
++   ++              ++   ++
 +   +                +   +
 +   +                +   +
++   ++              ++   ++
+     +              +     +
+     +              +     +
+     +              +     +
++   ++              ++   ++
 +++++                +++++
        +++++  +++++
       ++   ++++   ++
       +            +
       +            +
       +            +
       ++   ++++   ++
        +++++  +++++" );
}
