import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.int;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final nImp = parseInt( readline());
	final imports = [for( _ in 0...nImp ) readline()];
	
	final nDep = parseInt( readline());
	final dependencies = [for( _ in 0...nDep ) readline()];

	final result = process( imports, dependencies );
	print( result );
}

function process( importLines:Array<String>, dependencyLines:Array<String> ) {
	final imports = importLines.map( s -> { final parts = s.split(" "); return parts[1]; });
	final dependencies:Map<String, Array<String>> = [];
	for( d in dependencyLines ) {
		final parts = d.split(" ").map( s -> s.replace( ",", "" ));
		final lib = parts[0];
		if( !dependencies.exists( lib )) dependencies.set( lib, [] );
		
		final libs = [for( i in 2...parts.length ) parts[i]];
		libs.sort(( a, b ) -> a < b ? -1 : 1 );
		for( dLib in libs ) dependencies[lib].push( dLib );
	}
	
	var outputLines = [];
	
	final importer = new Importer( imports, dependencies );
	importer.process();

	if( importer.errorPosition != -1 ) {
		outputLines.push( 'Import error: tried to import ${importer.errorLibrary} but ${importer.missingDependency} is required.' );
	
		var repeats = 0;
		while( repeats < imports.length ) {
			final imports2 = reorder( imports, importer.errorPosition, importer.missingDependency );

			final importer = new Importer( imports2, dependencies );
			importer.process();

			if( importer.errorPosition == -1 ) {
				outputLines.push( 'Suggest to change import order:' );
				for( lib in imports2 ) outputLines.push( 'import $lib' );
				break;
			}
			
			repeats++;
		}


		if( repeats == imports.length ) outputLines.push( "Fatal error: interdependencies." );

	}
	
	return outputLines.length == 0
	? "Compiled successfully!"
	: outputLines.join( "\n" );
}

function reorder( imports:Array<String>, position:Int, missingDependency:String ) {
	final errorLibrary = imports[position];
	final dependencyPosition = imports.indexOf( missingDependency );
	final reordered = [
		imports.slice( 0, position ),
		imports.slice( position + 1, dependencyPosition + 1 ),
		[errorLibrary],
		imports.slice( dependencyPosition + 1 )
	];
	trace( 'reorder $imports  move pos $position $errorLibrary after $dependencyPosition $missingDependency  $reordered' );
	return reordered.flatten();
}