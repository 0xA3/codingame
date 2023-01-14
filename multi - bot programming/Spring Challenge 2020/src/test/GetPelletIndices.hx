package test;

class GetPelletIndices {
	
	public static function get( lines:Array<String>, pelletChar:String ) {
		final width = lines.length > 0 ? lines[0].length : throw "Error: empty array";
		final a = lines.map( line -> line.split(""));
		
		final indices:Array<Int> = [];
		for( y in 0...a.length ) {
			final line = a[y];
			if( line.length != width ) throw 'Error: line $y length should be $width but is ${line.length}';
			for( x in 0...line.length ) {
				if( line[x] == pelletChar ) indices.push( y * width + x );
			}
		}
		return indices;
	}
	
}