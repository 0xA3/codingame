import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;

function main() {
	final p = parseInt( readline() );
	final properties = [for( _ in 0...p ) readline()];

	final n = parseInt( readline() );
	final persons = [for( _ in 0...n ) readline()];

	final f = parseInt( readline() );
	final formulas = [for( _ in 0...f ) readline()];

	final result = process( properties, persons, formulas );
	print( result );
}

function process( properties:Array<String>, persons:Array<String>, formulaInputs:Array<String> ) {
	final table = Table.create( persons, properties );
	final formulas = formulaInputs.map( formulaInput -> Formula.create( formulaInput ));

	final filtered = formulas.map( formula -> table.filter( formula ));
	final filteredNums = filtered.map( personDatasets -> personDatasets.length );

	return filteredNums.join( "\n" );
}
