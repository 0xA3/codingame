import haxe.ds.ArraySort;

class IndexedVector {
	
	public final index: Int;
	public final vector: Array<Int>;
	
	public function new( index:Int, vector:Array<Int> ) {
		this.index = index;
		this.vector = vector;
	}

	public function toString() return 'index: $index, vector: $vector';

	public static function sort( iVectors:Array<IndexedVector>, permutation:Array<Int> ) {
		if (permutation.length != iVectors[0].vector.length) {
			throw "Permutation length must match the dimension of the vectors.";
		}
	
		// Sort the iVectors based on the permutation
		ArraySort.sort( iVectors, ( a, b ) -> {
			for( index in permutation ) {
				if( a.vector[index] < b.vector[index] ) return -1;
				else if ( a.vector[index] > b.vector[index] ) return 1;
			}
			return 0;
		});
	
		return iVectors;
	}
}

