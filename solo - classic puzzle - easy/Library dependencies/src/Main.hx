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
		for( dLib in libs ) dependencies[lib].push( dLib );
	}
	
	var outputLines = [];
	
	final importer = new Importer( imports, dependencies );
	importer.process();

	if( importer.errorPosition != -1 ) {
		outputLines.push( 'Import error: tried to import ${importer.errorLibrary} but ${importer.missingDependency} is required.' );
		
		imports.sort(( a, b ) -> a < b ? -1 : 1 );
		
		final sortedLibs = [];
		while( true ) {
			final possibleLibs = imports.filter( lib -> {
				if( dependencies.exists( lib )) {
					final requires = dependencies[lib];
					for( lib2 in requires ) {
						if( !sortedLibs.contains( lib2 )) return false;
					}
					return true;
				} else {
					return true;
				}
			});
			if( possibleLibs.length > 0 ) {
				final firstPossibleLib = possibleLibs[0];
				sortedLibs.push( firstPossibleLib );
				imports.remove( firstPossibleLib );
			}
			
			if( imports.length == 0 ) {
				outputLines.push( "Suggest to change import order:" );
				for( lib in sortedLibs ) outputLines.push( 'import $lib' );
				break;
			}
			
			if( possibleLibs.length == 0 && imports.length > 0 ) {
				outputLines.push( "Fatal error: interdependencies." );
				break;
			}
		}
	}
	
	return outputLines.length == 0
	? "Compiled successfully!"
	: outputLines.join( "\n" );
}
