class Table {
	
	final columnNames:Array<String>;
	final columnMap:Map<String,Int>;
	final content:Array<Array<String>>;

	function new( columnNames:Array<String>, columnMap:Map<String,Int>, content:Array<Array<String>> ) {
		this.columnNames = columnNames;
		this.columnMap = columnMap;
		this.content = content;
	}

	public static function create( tableHeader:String, tableRows:Array<String> ) {
		final columnNames = tableHeader.split(" ");
		final columnMap = [for( i in 0...columnNames.length ) columnNames[i] => i];
		final content = tableRows.map( row -> row.split(" "));
	
		return new Table( columnNames, columnMap, content );
	}
	
	public function copy() {
		final columnMapCopy = [for( columnName => Index in columnMap ) columnName => Index];
		final contentCopy = [for( row in content ) [for( v in row ) v]];
		return new Table( columnNames.copy(), columnMapCopy, contentCopy );
	}

	public function select( inputColumnNames:Array<String> ) {
		if( inputColumnNames.length == 1 && inputColumnNames[0] == "*" ) return copy();
		final invalidInputColumnNames = inputColumnNames.filter( columnName -> !columnMap.exists( columnName ));
		if( invalidInputColumnNames.length > 0 ) throw 'Error: table has no columns $invalidInputColumnNames';
		
		final colIds = inputColumnNames.map( columnName -> columnMap[columnName] );
		
		final newColumnMap = [for( i in 0...inputColumnNames.length ) inputColumnNames[i] => i];
		final newContent = [for( row in content ) [for( col in colIds ) row[col]]];

		return new Table( inputColumnNames, newColumnMap, newContent );
	}

	public function filter( columnName:String, columnValue:String ) {
		if( !columnMap.exists( columnName )) throw 'Error: table has no column $columnName';

		final colId = columnMap[columnName];
		final newContent = content.filter( row -> row[colId] == columnValue );

		return new Table( columnNames, columnMap, newContent );
	}

	public function orderBy( columnName:String, order:Order ) {
		if( !columnMap.exists( columnName )) throw 'Error: table has no column $columnName';
		final copy = this.copy();
		final colId = columnMap[columnName];
		copy.sort( colId, order );
		
		return copy;
	}

	function sort( colId:Int, order:Order ) {
		final fOrder = order == Asc ? 1 : -1;
		
		content.sort(( a, b ) -> {
			final va = a[colId];
			final vb = b[colId];
			
			final floatVA = Std.parseFloat( va );
			final floatVB = Std.parseFloat( vb );
			
			if( Math.isNaN( floatVA ) || Math.isNaN( floatVB )) {
				if( va < vb ) return -1 * fOrder;
				if( va > vb ) return 1 * fOrder;
				return 0;
			} else {
				if( floatVA < floatVB ) return -1 * fOrder;
				if( floatVA > floatVB ) return 1 * fOrder;
				return 0;
			}
		});
	}

	public function toString() {
		return columnNames.join(" ") + "\n" + content.map( row -> row.join(" ")).join( "\n" );
	}
	
}