package test;

import Main.parseComment;
import Std.parseInt;

using StringTools;
using buddy.Should;

@:access(Main)
class TestProcess extends buddy.BuddySuite{

	public function new() {

		describe( "Test process", {
			it( "Simple example", { Main.process( simpleExample ).should.be( simpleExampleResult ); });
			it( "Likes count", { Main.process( likesCount ).should.be( likesCountResult ); });
			it( "Tie - Followed", { Main.process( tieFollowed ).should.be( tieFollowedResult ); });
			it( "Pinned - All priorities", { Main.process( pinnedAllPriorities ).should.be( pinnedAllPrioritiesResult ); });
			it( "Replies", { Main.process( replies ).should.be( repliesResult ); });
			it( "Followed in replies", { Main.process( followedInReplies ).should.be( followedInRepliesResult ); });
		});
	}

	static function parseInput( input:String ) {
		final lines = input.replace( "\t", "" ).replace( "\r", "" ).split( "\n" );
		final n = parseInt( lines[0] );
		var comments = [for( i in 0...n ) lines[i + 1]];
			
		return comments;
	}
	
	static function parseResult( input:String ) {
		return input.replace( "\t", "" ).replace( "\r", "" );
	}

	final simpleExample = parseInput(
	"2
	user1|05:00|0|none
	user2|06:00|0|none" );

	final simpleExampleResult = parseResult(
	"user2|06:00|0|none
	user1|05:00|0|none" );

	final likesCount = parseInput(
	"3
	user3|12:00|0|none
	user2|15:00|1|none
	user1|13:00|2|none" );

	final likesCountResult = parseResult(
	"user1|13:00|2|none
	user2|15:00|1|none
	user3|12:00|0|none" );

	final tieFollowed = parseInput(
	"5
	user5|10:03|5|none
	user9|09:12|0|Followed
	user1|10:50|6|none
	user3|10:50|6|none
	user10|21:32|10|none" );

	final tieFollowedResult = parseResult(
	"user9|09:12|0|Followed
	user10|21:32|10|none
	user1|10:50|6|none
	user3|10:50|6|none
	user5|10:03|5|none" );

	final pinnedAllPriorities = parseInput(
	"3
	user5|11:00|10|Followed
	user6|10:00|0|Pinned
	user4|11:00|0|none" );

	final pinnedAllPrioritiesResult = parseResult(
	"user6|10:00|0|Pinned
	user5|11:00|10|Followed
	user4|11:00|0|none" );

	final replies = parseInput(
	"5
	user1|20:00|1|none
	    user2|22:21|2|none
	    user3|21:22|3|none
	user5|12:00|2|none
	user2|09:00|0|Pinned" );

	final repliesResult = parseResult(
	"user2|09:00|0|Pinned
	user5|12:00|2|none
	user1|20:00|1|none
	    user3|21:22|3|none
	    user2|22:21|2|none" );

	final followedInReplies = parseInput(
	"7
	user1|12:00|5|Pinned
	    user102|22:53|94|none
	    user2|12:00|4|Followed
	    user2|13:00|5|Followed
	user102|12:12|9|Followed
	    user102|12:12|9|Followed
	    user3|17:43|10|Followed" );

	final followedInRepliesResult = parseResult(
	"user1|12:00|5|Pinned
	    user2|13:00|5|Followed
	    user2|12:00|4|Followed
	    user102|22:53|94|none
	user102|12:12|9|Followed
	    user3|17:43|10|Followed
	    user102|12:12|9|Followed" );
}
