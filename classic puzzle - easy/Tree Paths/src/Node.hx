class Node {

	public final id:Int;
	public var parent:Node;
	public var left:Node;
	public var right:Node;

	public function new( id:Int ) {
		this.id = id;
	}
}