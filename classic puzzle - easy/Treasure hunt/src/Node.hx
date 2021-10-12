@:structInit class Node {

	static inline var ZERO = "0".code;

	public final visited:Array<Bool>;
	public final pos:Int;
	public var gold:Int;

	public function collect( s:String ) {
		visited[pos] = true;
		final code = s.charCodeAt( 0 ) - ZERO;
		gold += code > 0 && code < 10 ? code : 0;
	}

	public function getNeighbor( neighborPos:Int ):Node return { visited: visited.copy(), pos: neighborPos, gold: gold }
}