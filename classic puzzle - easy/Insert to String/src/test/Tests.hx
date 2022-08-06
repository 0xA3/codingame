package test;

import Std.parseInt;

using buddy.Should;
using StringTools;

@:access(Main)
class Tests extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Hello, world!", {
				final ip = helloWorld;
				Main.process( ip.s, ip.rawChanges ).should.be( helloWorldResult );
			});
			it( "Add missing text", {
				final ip = addMissingText;
				Main.process( ip.s, ip.rawChanges ).should.be( addMissingTextResult );
			});
			it( "Complete code snippet", {
				final ip = completeCodeSnippet;
				Main.process( ip.s, ip.rawChanges ).should.be( completeCodeSnippetResult );
			});
			it( "Add text to punctuation", {
				final ip = addTextToPunctuation;
				Main.process( ip.s, ip.rawChanges ).should.be( addTextToPunctuationResult );
			});
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final s = lines[0];
		final changeCount = parseInt( lines[1] );
		final rawChanges = [for( i in 0...changeCount ) lines[i + 2]];
	
		return { s: s, rawChanges: rawChanges }
	}

	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	static final helloWorld = parseInput(
	"Hello world
	4
	0|11|!
	0|5|,\\n
	0|7| w
	0|10|\\n" );

	static final helloWorldResult = parseResult(
	"Hello,
	 w worl
	d!" );
	
	
	static final addMissingText = parseInput(
	"He said that . To which I replied .
	2
	0|13|I'm not good enough for the job
	0|34|\"Your lose!\"" );

	static final addMissingTextResult = parseResult(
	"He said that I'm not good enough for the job. To which I replied \"Your lose!\"." );
	
	
	static final completeCodeSnippet = parseInput(
	"main\\nHello World}
	4
	0|0|void 
	1|0|  Console.WriteLine(\"
	0|4|()\\n{
	1|11|\");\\n" );

	static final completeCodeSnippetResult = parseResult(
	"void main()
	{
	  Console.WriteLine(\"Hello World\");
	}" );
	
	
	static final addTextToPunctuation = parseInput(
	"\",,,\\n\"\\n-
	5
	0|1|You've gotta dance like there's nobody watching
	0|2|\\nLove like you'll\\nnever be hurt
	0|3|\\nSing like there's nobody listening
	1|0|And live like it's heaven on earth.
	2|1| William W. Purkey" );

	static final addTextToPunctuationResult = parseResult(
	"\"You've gotta dance like there's nobody watching,
	Love like you'll
	never be hurt,
	Sing like there's nobody listening,
	And live like it's heaven on earth.\"
	- William W. Purkey" );
}
