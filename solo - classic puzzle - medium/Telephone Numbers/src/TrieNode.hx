class TrieNode {
	
	// the "key" value will be the character in sequence
	final key:Int;
	// we keep a reference to parent
	public var parent:TrieNode;
	// we have map of children
	public var numChildren = 0;
	public final children:Map<Int, TrieNode> = [];
	// check to see if the node is at the isEnd
	public var isEnd = false;

	public function new( key:Int, ?parent:TrieNode ) {
		this.key = key;
		this.parent = parent;
	}

	public function getDigits() {
		final output = [];
		
		var node = this;
		while( node != Trie.ROOT ) {
			output.unshift( node.key );
			node = node.parent;
		}

		return output;
	}
}