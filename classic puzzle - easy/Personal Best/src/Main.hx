import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseFloat;
import Std.parseInt;

using Lambda;
using StringTools;

function main() {

	final gymnasts = readline().split( "," );
	final categories = readline().split( "," );
	final n = parseInt( readline() );
	final rows = [for( i in 0...n ) readline()];
			
	final result = process( gymnasts, categories, rows );
	print( result );
}

function process( gymnasts:Array<String>, categories:Array<String>, rows:Array<String> ) {

	final gymnastResults:Map<String, ResultsDataset> = [];
	for( row in rows ) {
		final cols = row.split( "," );
		final name = cols[0];
		
		if( !gymnastResults.exists( name )) gymnastResults.set( name, [ "bars" => [], "beam" => [], "floor" =>[]] );
		
		final d = gymnastResults[name];
		d["bars"].push(  parseFloat( cols[1] ));
		d["beam"].push( parseFloat( cols[2] ));
		d["floor"].push( parseFloat( cols[3] ));
	}
	
	for( gr in gymnastResults ) for( r in gr ) r.sort(( a, b ) -> a < b ? 1 : -1 );

	final bests = [];
	for( gymnast in gymnasts ) {
		final cat = [];
		for( category in categories ) {
			// trace( '$gymnast $category ${gymnastResults[gymnast][category]}' );
			cat.push( gymnastResults[gymnast][category][0] );
		}
		bests.push( cat );
	}

	final output = bests.map( cat -> cat.join( "," )).join( "\n" );

	return output;
}

typedef ResultsDataset = Map<String, Array<Float>>;
