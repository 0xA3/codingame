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
	
	final imported:Map<String, Bool> = [];
		
	var isImportError = false;
	for( i in 0...imports.length ) {
		final library1 = imports[i];
		// trace( '$i import $library1' );
		imported.set( library1, true );
		if( dependencies.exists( library1 )) {
			// trace( 'dependencies ${dependencies[library1]}' );
			for( library2 in dependencies[library1] ) {
				if( !imported.exists( library2 )) {
					outputLines.push( 'Import error: tried to import $library1 but $library2 is required.' );
					isImportError = true;
					break;
				}
			}
		}
		if( isImportError ) break;
	}

	if( isImportError ) {
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
