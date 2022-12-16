package algorithm;

import haxe.ds.Vector;

class MaxPriorityQueue<T> {
	
	var pq:Vector<T>;
	var n:Int;
	final compare:( a:T, b:T ) -> Bool;

	/**
	* Initializes an empty priority queue with the given initial capacity.
	*
	* @param  initCapacity the initial capacity of this priority queue
	*/
	public function new( compare:( a:T, b:T ) -> Bool ) {
		this.compare = compare;
		pq = new Vector<T>( 1 );
		n = 0;
	}

	/**
	* Initializes a priority queue from the array of keys.
	*
	* Takes time proportional to the number of keys, using sink-based heap construction.
	*
	* @param  keys the array of keys
	*/	
	public function init( keys:Array<T> ) {
		n = keys.length;
		pq = new Vector<T>( keys.length + 1 );
		for( i in 0...n ) pq[i + 1] = keys[i];
		sort();
	}

	/**
	* Returns true if this priority queue is empty.
	*
	* @return {@code true} if this priority queue is empty;
	*         {@code false} otherwise
	*/
	public function isEmpty() return n == 0;

	/**
	* Returns the number of keys on this priority queue.
	*
	* @return the number of keys on this priority queue
	*/
	public function size() return n;

	/**
	* Returns a smallest key on this priority queue.
	*
	* @return a smallest key on this priority queue
	* @throws NoSuchElementException if this priority queue is empty
	*/
	public function max() {
		if( isEmpty()) throw "Priority queue underflow";
		return pq[1];
	}

	// helper function to double the size of the heap array
	function resize( capacity:Int ) {
		if( capacity <= n ) throw 'Capacity $capacity must be greater than n $n';
		final temp = new Vector<T>( capacity );
		for( i in 1... n+1 ) temp[i] = pq[i];
		pq = temp;
	}

	/**
	* Adds a new key to this priority queue.
	*
	* @param  x the key to add to this priority queue
	*/
	public function insert( x:T ) {
		// double size of array if necessary
		if( n == pq.length - 1 ) resize( 2 * pq.length );
		pq[++n] = x;
		// trace( 'pq[$n] = $x  ${pq.toArray()}' );
		swim( n );
	}

	/**
	 * Removes and returns a smallest key on this priority queue.
	 *
	 * @return a smallest key on this priority queue
	 * @throws NoSuchElementException if this priority queue is empty
	*/
	
	public function delMax() {
		if( isEmpty()) throw "Priority queue underflow";
		final max = pq[1];
		exch( 1, n-- );
		sink( 1 );
		pq[n+1] = null; // to avoid loiterig and help with garbage collection
		if(( n > 0 ) && ( n == ( pq.length - 1 ) / 4 )) resize( Std.int( pq.length / 2 ));
		return max;
	}
	
	/**
	 * sorts the priority queue.
	 *
	*/
	public function sort() {
		if( isEmpty()) return;
		for( k in -Std.int( n / 2 )...0 ) sink( -k );
	}

	/***************************************************************************
	* Helper functions to restore the heap invariant.
	***************************************************************************/
	
	function swim( k:Int ) {
		while( k > 1 && less( Std.int( k / 2 ), k )) {
			exch( k, Std.int( k / 2 ) );
			k = Std.int( k / 2 );
			// trace( 'pq ${pq.toArray()}' );
		}
	}

	function sink( k:Int ) {
		while( 2 * k <= n ) {
			var j = 2 * k;
			if( j < n && less( j, j + 1 )) j++;
			if( !less( k, j )) break;
			exch( k, j );
			k = j;
		}
	}

	/***************************************************************************
	* Helper functions for compares and swaps.
	***************************************************************************/

	function less( i:Int, j:Int ) {
		return compare( pq[j], pq[i] );
	}

	function exch( i:Int, j:Int ) {
		// trace( 'exch pq[$i]: ${pq[i]} with pq[$j]: ${pq[j]}' );
		final swap = pq[i];
		pq[i] = pq[j];
		pq[j] = swap;
	}

	// is pq[1..n] a max heap?
	function isMaxHeap() {
		for( i in 1...n + 1 ) if( pq[i] == null ) return false;
		for( i in n + 1...pq.length ) if( pq[i] != null ) return false;
		if( pq[0] != null ) return false;
		return isMaxHeapOrdered( 1 );
	}

	function isMaxHeapOrdered( k:Int ) {
		if( k > n ) return true;
		final left = 2 * k;
		final right = 2 * k + 1;
		if( left <= n && less( k, left )) return false;
		if( right <= n  && less( k, right )) return false;
		return isMaxHeapOrdered( left ) && isMaxHeapOrdered( right );
	}
}