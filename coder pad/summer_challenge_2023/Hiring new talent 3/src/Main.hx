import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;

@:keep function mergeFiles( fileContents:Array<String> ) {
	final lines = [];
	for( fileContent in fileContents ) {
		final fileLines = fileContent.split( "\n" );
		for( fl in fileLines ) {
			lines.push( fl );
		}
	}
	final studentDatasetsMap:Map<String, Map<String, String>> = [];

	for( line in lines ) {
		final pairs = line.split( ";" );
		var name = "";
		final datasets:Map<String, String> = [];
		for( i in 0...pairs.length ) {
			final parts = pairs[i].split( "=" );
			if( parts[0] == "Name" ) name = parts[1];
			else datasets.set( parts[0], parts[1] );
		}
		if( !studentDatasetsMap.exists( name )) studentDatasetsMap.set( name, [] );

		final studentDataset = studentDatasetsMap[name];
		for( key => value in datasets ) studentDataset.set( key, value );
	}

	var studentDatasetsArray = [];
	for( name => datasets in studentDatasetsMap ) {
		
		final datasetsArray = [for( key => value in datasets ) { key: key, value: value }];
		datasetsArray.sort(( a, b ) -> {
			if( a.key < b.key ) return -1;
			if( a.key > b.key ) return 1;
			return 0;
		});
		final line = 'Name=$name' + ( datasetsArray.length > 0 ? ";" + datasetsArray.map( kv -> '${kv.key}=${kv.value}').join( ";" ) : "" );
		studentDatasetsArray.push( line );
	}

	studentDatasetsArray.sort(( a, b ) -> {
		if( a < b ) return -1;
		if( a > b ) return 1;
		return 0;
	});
	
	final output = studentDatasetsArray.join( "\n" );

	return output;
}
