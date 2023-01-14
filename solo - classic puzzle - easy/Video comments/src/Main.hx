import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import haxe.ds.ArraySort;

using Lambda;
using StringTools;

inline var PINNED = "Pinned";
inline var FOLLOWED = "Followed";
inline var NONE = "none";

function main() {

	final n = parseInt( readline() );
	var comments = [for( _ in 0...n ) readline()];
	
	final result = process( comments );
	print( result );
}

function process( commentStrings:Array<String> ) {

	final comments:Array<Comment> = [];
	for( s in commentStrings ) {
		final comment = parseComment( s );
		if( s.charAt( 0 ) == " " ) {
			comments[comments.length - 1].replies.push( comment );
		} else {
			comments.push( comment );
		}
	}

	ArraySort.sort( comments, sortComment );
	for( comment in comments ) ArraySort.sort( comment.replies, sortComment );

	return outputComments( comments );
}

function sortComment( a:Comment, b:Comment ) {
	if( a.priority == PINNED && b.priority != PINNED ) return -1;
	if( a.priority != PINNED && b.priority == PINNED ) return 1;
	
	if( a.priority == FOLLOWED && b.priority != FOLLOWED ) return -1;
	if( a.priority != FOLLOWED && b.priority == FOLLOWED ) return 1;

	if( a.likes < b.likes ) return 1;
	if( a.likes > b.likes ) return -1;

	if( a.date < b.date ) return 1;
	if( a.date > b.date ) return -1;

	return 0;
}

function parseComment( s:String ):Comment {
	final parts = s.split( "|" );
	return {
		name: parts[0].trim(),
		date: parts[1],
		likes: parseInt( parts[2] ),
		priority: parts[3],
		replies: []
	}
}

function outputComments( comments:Array<Comment> ) {
	var outputs = [];
	for( comment in comments ) {
		outputs.push( commentToString( comment ));
		for( reply in comment.replies ) {
			outputs.push( "    " + commentToString( reply ));
		}
	}
	return outputs.join( "\n" );
}

function commentToString( comment:Comment ) return '${comment.name}|${comment.date}|${comment.likes}|${comment.priority}';

typedef Comment = {
	final name:String;
	final date:String;
	final likes:Int;
	final priority:String;
	final replies:Array<Comment>;
}
