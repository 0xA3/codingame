import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Parser.Expr;
import Std.parseInt;
import Std.string;

using Lambda;

class Main {
	
	static var assignmentsMap:Map<String, Assignment> = [];

	static function main() {
		
		final n = parseInt( readline() );
		final assignments = [for( i in 0...n ) readline()];
		final x = readline();

		final result = process( assignments, x );
		print( result );
	}

	static function process( assignmentStrings:Array<String>, x:String ) {
		assignmentsMap.clear();
		assignmentsMap = mapAssignments( assignmentStrings );
		
		final parser = new Parser();
		final ast = parser.parse( x );

		final result = processExpr( ast );

		return string( result );
	}

	static function mapAssignments( assignmentStrings:Array<String> ) {
		for( assignmentString in assignmentStrings ) {
			final bracketOpen = assignmentString.indexOf( "[" );
			final key = assignmentString.substr( 0, bracketOpen );
			final assignment = parseAssignmentString( assignmentString, bracketOpen );
			assignmentsMap.set( key, assignment );
		}
		return assignmentsMap;
	}

	static function parseAssignmentString( assignmentString:String, bracketOpen:Int ) {
		final dots = assignmentString.indexOf( ".." );
		final bracketClose = assignmentString.indexOf( "]" );
		final equal = assignmentString.indexOf( "=" );
		final start = parseInt( assignmentString.substring( bracketOpen + 1, dots ));
		final end = parseInt( assignmentString.substring( dots + 2, bracketClose ));
		final values = assignmentString.substr( equal + 2 ).split(" ").map( s -> parseInt( s ));
		final a:Assignment = { start: start, end: end, values:values };
		return a;
	}

	static function processExpr( ast:Expr ) {
		switch ast {
			case EArray( identifier, index ):
				final index = processExpr( index );
				return getElement( identifier, index );
			case EMinus( expr ): return -processExpr( expr );
			case EIndex( i ): return i;
		}
	}

	static function getElement( identifier:String, index:Int ) {
		if( !assignmentsMap.exists( identifier )) throw 'Error: no array $identifier';
		final assignment = assignmentsMap[identifier];
		final realIndex = index - assignment.start;
		if( realIndex < 0 ) throw 'Error: index $index - start ${assignment.start} = ${realIndex} is < 0';
		if( realIndex > assignment.values.length ) throw 'Error: index $index - start ${assignment.start} = ${realIndex} is > values length ${assignment.values.length}';
		return assignment.values[realIndex];
	}

}

typedef Assignment = {
	final start:Int;
	final end:Int;
	final values:Array<Int>;
}