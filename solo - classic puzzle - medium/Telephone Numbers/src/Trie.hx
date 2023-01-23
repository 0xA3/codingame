class Trie {
	
	public final root = new TrieNode( -1 );

	public var count = 0;
	public function new() { }

	// inserts a number into the trie.
	public function insert( digits:Array<Int> ) {
		var node = root; // we start at the root

		// for every digit in the number
		for( i in 0...digits.length ) {
			final digit = digits[i];
			// check to see if digit node exists in children
			if( !node.children.exists( digit )) {
				// if it doesn't exist, we then create it with the node as parent
				node.children.set( digit, new TrieNode( digit, node ));
				node.numChildren++;
				count++;
			}
			// proceed to the next depth in the trie
			node = node.children[digit];

			// finally, we check to see if it's the last word
			// if it is, we set the end flag to true
			if( i == digits.length - 1 ) node.isEnd = true;
		}
	}

	// check if it contains a whole number
	public function contains( digits:Array<Int> ) {
		var node = root;

		// for every digit in the number
		for( i in 0...digits.length ) {
			final digit = digits[i];
			// check to see if digit node exists in children
			if( node.children.exists( digit )) {
				// if it exists, proceed to the next depth of the trie
				node = node.children[digit];
			} else {
				// doesn't exist, return false since it's not a valid word
				return false;
			}
		}

		// we finished going through all the digits, but is it a whole number?
		return node.isEnd;
	}

	// returns every number with given prefix
	public function find( prefix:Array<Int> ) {
		var node = root;
		
		final output = [];
		// for every digit in the prefix
		for( i in 0...prefix.length ) {
			final digit = prefix[i];
			// make sure prefix actually has digits
			if( node.children.exists( digit )) {
				node = node.children[digit];
			} else {
				// there's none. just return it
				return output;
			}
		}
		// recursively find all numbers in the node
		findAllNumbers( node, output );

		return output;
	}

	// recursive function to find all words in the given node
	function findAllNumbers( node:TrieNode, a:Array<Int> ) {
		// base case, if node is at a number, push to output
		if( node.isEnd ) node.getDigits().concat( a );
		// iterate through each children, call recursive findAllNumbers
		for( child in node.children ) findAllNumbers( child, a );
	}

	public function remove( digits:Array<Int> ) {
		if( digits.length == 0 ) return;
		// call remove word on root node
		removeNumber( root, digits );
	}

	// recursively finds and removes a word
	function removeNumber( node:TrieNode, digits:Array<Int> ) {
		// check if current node contains the word
		if( node.isEnd && node.getDigits().join( "" ) == digits.join( "" )) {
			// check and see if node has children
			final hasChildren = node.numChildren > 0;
			// if has children we only want to un-flag the end node that marks end of a word.
            // this way we do not remove words that contain/include supplied word
			if( hasChildren ) node.isEnd = false;
			else {
				// remove word by getting parent and setting children to empty dictionary
				node.parent.children.clear();
				node.parent.numChildren = 0;
			}
			
			return true;
		}
		// recursively remove word from all children
		for( child in node.children ) removeNumber( child, digits );

		return false;
	}
}