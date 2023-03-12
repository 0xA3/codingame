package test;

import Main.Input;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Basic shapes", { Main.process( basicShapes ).should.be( basicShapesResult ); });
			it( "Basic shapes width 1", { Main.process( basicShapesWidth1 ).should.be( basicShapesWidth1Result ); });
			it( "Basic shapes but different size", { Main.process( basicShapesButDifferentSize ).should.be( basicShapesButDifferentSizeResult ); });
			it( "Bob is cool", { Main.process( bobIsCool ).should.be( bobIsCoolResult ); });
			it( "REVERSE !", { Main.process( reverse ).should.be( reverseResult ); });
			it( "A+", {	Main.process( aPlus ).should.be( aPlusResult ); });
			it( "S+", {	Main.process( sPlus ).should.be( sPlusResult ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final lsize = parseInt( lines[0] );
		final rheight = parseInt( lines[1] );
		final rwidth = parseInt( lines[2] );
		final theight = parseInt( lines[3] );
		final characters = lines[4].split(" ");
		final shapes = lines[5].split(" ");
		
		final input:Input = { lsize: lsize, rheight: rheight, rwidth: rwidth, theight: theight, characters: characters, shapes: shapes }
		
		return input;
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final basicShapes = parseInput(
		"15
		5
		12
		6
		X # @
		LINE RECTANGLE TRIANGLE" );
	
	final basicShapesResult = parseResult(
		"XXXXXXXXXXXXXXX

		############
		#          #
		#          #
		#          #
		############
		
		@
		@@
		@ @
		@  @
		@   @
		@@@@@@" );
	
	final basicShapesWidth1 = parseInput(
		"1
		1
		1
		1
		X # @
		LINE RECTANGLE TRIANGLE" );
	
	final basicShapesWidth1Result = parseResult(
		"X

		#
		
		@" );
		

	final basicShapesButDifferentSize = parseInput(
		"99
		7
		1
		10
		# | >
		LINE RECTANGLE TRIANGLE" );
	
	final basicShapesButDifferentSizeResult = parseResult(
		"###################################################################################################

		|
		|
		|
		|
		|
		|
		|
		
		>
		>>
		> >
		>  >
		>   >
		>    >
		>     >
		>      >
		>       >
		>>>>>>>>>>" );

	final bobIsCool = parseInput(
		"7
		2
		3
		0
		1 3 5
		LINE FORM RECTANGLE" );
	
	final bobIsCoolResult = parseResult(
		"FORM IS NOT A SHAPE

		1111111
		
		333
		333" );
	
	final reverse = parseInput(
		"15
		5
		12
		6
		X # @
		LINE RECTANGLE REVERSE_TRIANGLE" );
	
	final reverseResult = parseResult(
		"XXXXXXXXXXXXXXX

		############
		#          #
		#          #
		#          #
		############
		
		@@@@@@
		@   @
		@  @
		@ @
		@@
		@" );
	
	final aPlus = parseInput(
		"15
		5
		12
		6
		X # @
		LINE RECTANGLE TRIANGLE REVERSE_TRIANGLE OUPSI" );
	
	final aPlusResult = parseResult(
		"OUPSI IS NOT A SHAPE

		XXXXXXXXXXXXXXX
		
		############
		#          #
		#          #
		#          #
		############
		
		@
		@@
		@ @
		@  @
		@   @
		@@@@@@
		
		@@@@@@
		@   @
		@  @
		@ @
		@@
		@" );
	
	final sPlus = parseInput(
		"12
		30
		10
		21
		# \\ +
		LINE BANANA RECTANGLE TRIANGLE REVERSE_TRIANGLE" );
	
	final sPlusResult = parseResult(
		"BANANA IS NOT A SHAPE

		############
		
		\\\\\\\\\\\\\\\\\\\\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\        \\
		\\\\\\\\\\\\\\\\\\\\
		
		+
		++
		+ +
		+  +
		+   +
		+    +
		+     +
		+      +
		+       +
		+        +
		+         +
		+          +
		+           +
		+            +
		+             +
		+              +
		+               +
		+                +
		+                 +
		+                  +
		+++++++++++++++++++++
		
		+++++++++++++++++++++
		+                  +
		+                 +
		+                +
		+               +
		+              +
		+             +
		+            +
		+           +
		+          +
		+         +
		+        +
		+       +
		+      +
		+     +
		+    +
		+   +
		+  +
		+ +
		++
		+" );
}
