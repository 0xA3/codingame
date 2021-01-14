package test;

import Main;
import Std.parseInt;

using buddy.Should;
using StringTools;
using Lambda;

@:access(Main)
class Tests extends buddy.BuddySuite {
	
	public function new() {
		
		describe( "Test process", {
			
			it( "Test 1", {
				Main.process( test1 ).should.be( "It was me!" );
			});
			
			it( "Test 2", {
				Main.process( test2 ).should.be( "Charles did it!" );
			});
			
			it( "Test 3", {
				Main.process( test3 ).should.be( "Charles did it!" );
			});
			
			it( "Test 4", {
				Main.process( test4 ).should.be( "Lance did it!" );
			});
			
			it( "Test 5", {
				Main.process( test5 ).should.be( "Ben did it!" );
			});
			
			it( "Test 6", {
				Main.process( test6 ).should.be( "Bob did it!" );
			});
			
			it( "Test 7", {
				Main.process( test7 ).should.be( "Hank did it!" );
			});
			
			it( "Test 8", {
				Main.process( test8 ).should.be( "Dylan did it!" );
			});
			
			
		});

	}

	static function parseInput( input:String ) {
		final lines = input.split( "\n" );
		final words = [for( i in 1...lines.length) lines[i].trim()];
		return words;
	}

	final test1 = parseInput(
	"4
	Tom: I was in the church with Bob.
	Jane: I was in the garden with Joyce.
	Bob: I was in the church with Tom.
	Joyce: I was in the garden with Jane." );
	
	final test2 = parseInput(
	"3
	Jordan: I was in the greenhouse with Ryan.
	Ryan: I was in the greenhouse with Jordan.
	Charles: I was in the greenhouse with Ryan and Jordan." );
	
	final test3 = parseInput(
	"5
	Henry: I was in the garden with Jenny and Penny and Bill.
	Bill: I was in the garden with Jenny and Penny and Henry.
	Jenny: I was in the garden with Penny and Henry and Bill.
	Charles: I was in the garden with Penny and Henry and Bill and Jenny.
	Penny: I was in the garden with Henry and Bill and Jenny." );
	
	final test4 = parseInput(
	"2
	Lance: I was in the garden with Lily.
	Lily: I was in the garden, alone." );
	
	final test5 = parseInput(
	"3
	Jane: I was in the school, alone.
	Lois: I was in the garden, alone.
	Ben: I was in the church with Jane and Lois." );
	
	final test6 = parseInput(
	"3
	Tom: I was in the garden with Lily.
	Lily: I was in the garden with Tom.
	Bob: I was in the garden, alone." );
	
	final test7 = parseInput(
	"4
	Bob: I was in the pub with Sue.
	Sue: I was in the pub with Bob.
	Dylan: I was in the garden, alone.
	Hank: I was in the pub with Sue and Bob." );
	
	final test8 = parseInput(
	"4
	Alice: I was in the church with Bob.
	Bob: I was in the church with Alice.
	Charlie: I was in the garden, alone.
	Dylan: I was in the church, alone." );
	
}

