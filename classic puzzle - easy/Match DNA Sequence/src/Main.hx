import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;

using Lambda;

function main() {

	final delta = parseInt( readline() );
	final gene = readline();
	final n = parseInt( readline() );
	var chrs = [for( _ in 0...n ) readline()];
	
	final result = process( delta, gene, chrs );
	print( result );
}

function process( delta:Int, gene:String, chrs:Array<String> ) {

	return "";
}
