import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Interp.execute;
import Std.parseInt;

using Lambda;

function main() {

	final sqlQuery = readline();
	final rows = parseInt( readline() );
	final tableHeader = readline();
	final tableRows = [for( i in 0...rows) readline()];
				
	final result = process( sqlQuery, tableHeader, tableRows );
	print( result );
}

function process( sqlQuery:String, tableHeader:String, tableRows:Array<String> ) {
	final parser = new Parser();
	final commands = parser.parse( sqlQuery );
	final table = Table.create( tableHeader, tableRows );
	
	final processedTable = execute( commands, table );
	
	return processedTable.toString();
}
