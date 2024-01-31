import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Statement;
import Std.parseInt;

using Lambda;
using StringTools;

typedef StatementPosition = {
	final statement:Statement;
	final start:Int;
	final end:Int;
}

function main() {

	final n = parseInt( readline());
	final sqlFile = [for( _ in 0...n ) readline()].join( "\n" );

	final result = process( sqlFile );
	print( result );
}

function process( sqlFile:String ) {
	final sqlLowerCase = sqlFile.toLowerCase();
	final statementPositions = [for( statement in [Insert, Begin, Comment] )
		findAll( sqlLowerCase, statement )].flatten();

	statementPositions.sort(( a, b ) -> a.start - b.start );
	final inserts = statementPositions.filter( sp -> sp.statement == Insert );
	final others = statementPositions.filter( sp -> sp.statement != Insert );
	// for( sp in statementPositions ) trace( '${sp.statement} ${sp.position}' );

	final removes = [];
	for( insert in inserts ) {
		var isRemove = true;
		for( other in others ) {
			if( insert.start > other.start && insert.end <= other.end ) {
				isRemove = false;
				break;
			}
		}
		if( isRemove ) removes.push( insert );
	}

	// for( remove in removes ) trace( 'removes ${remove.start}-${remove.end}' );
	if( removes.length == 0 ) return sqlFile;

	var pos = 0;
	var output = "";
	for( remove in removes ) {
		output += sqlFile.substring( pos, remove.start );
		pos = remove.end + 1;
	}
	if( pos < sqlFile.length ) output += sqlFile.substr( pos );

	while( output.charAt( output.length - 1 ) == "\n" ) output = output.substr( 0, output.length - 1 );

	return output;
}

function findAll( s:String, statement:Statement ) {
	var sstatement = stringOf( statement );
	var pos = -1;
	final statementPositions = [];
	while( true ) {
		pos = s.indexOf( sstatement, pos + 1 );
		if( pos != -1 ) {
			final endPos = switch statement {
				case Insert: {
					final insertEnd = s.indexOf( stringOf( Semikolon ), pos + 1 );
					s.charAt( insertEnd + 1 ) == "\n" ? insertEnd + 1 : insertEnd;
				}
				case Begin: s.indexOf( stringOf( End ), pos + 1 );
				case Comment: {
					final eol = s.indexOf( stringOf( Eol ), pos + 1 );
					eol == -1 ? s.length : eol;
				}
				default: throw 'Error: no endPos for statement $statement';
			}
			
			final statementPosition:StatementPosition = { statement: statement, start: pos, end: endPos }
			// trace( '$statement $pos - $endPos' );
			statementPositions.push( statementPosition );
		}
		else break;

	}

	return statementPositions;
}

function find( s:String, statement:String, startIndex:Int ) {
	return s.indexOf( statement, startIndex );
}

function stringOf( statement:Statement ) {
	return switch statement {
		case Insert: "insert ";
		case Begin: "begin";
		case End: "end;";
		case Semikolon: ";";
		case Comment: "--";
		case Eol: "\n";
	}
}
