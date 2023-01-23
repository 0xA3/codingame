import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;
using StringTools;
using xa3.StringUtils;

function main() {

	final lengthOfLine = parseInt( readline() );
	final n = parseInt( readline() );
	final entries = [for( _ in 0...n ) readline()];
	
	final result = process( lengthOfLine, entries );
	print( result );
}

function process( lengthOfLine:Int, inputEntries:Array<String> ) {
	final entries = inputEntries.map( inputEntry -> parseEntry( inputEntry ));

	final outputs = [];
	final chapterIndex = [];
	for( entry in entries ) {
		if( chapterIndex.length <= entry.level ) chapterIndex[entry.level] = 1;
		for( i in entry.level + 1...chapterIndex.length ) chapterIndex[i] = 1;
		final index = chapterIndex[entry.level];
		var indexString = '$index';
		final spaces = " ".repeat( entry.level * 4 );
		final textLength = spaces.length + indexString.length + 1 + entry.name.length + entry.page.length;
		final dots = ".".repeat( lengthOfLine - textLength );
		
		final line = '$spaces$indexString ${entry.name}$dots${entry.page}';
		outputs.push( line );

		chapterIndex[entry.level]++;
	}

	return outputs.join( "\n" );
}

function parseEntry( inputEntry:String ) {
	final parts = inputEntry.split(" ");
	final level = parts[0].count( ">" );
	final name = parts[0].substr( level );
	final page = parts[1];

	final entry:Entry = { level: level, name: name, page: page }
	
	return entry;
}

typedef Entry = {
	final level:Int;
	final name:String;
	final page:String;
}
