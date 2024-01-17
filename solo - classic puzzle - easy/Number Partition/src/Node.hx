class Node {
	public final value:Int;
	public final sum:Int;
	public final parent:Null<Node>;

	public function new( value:Int, sum:Int, ?parent:Node ) {
		this.value = value;
		this.sum = sum;
		this.parent = parent;
	}

	public function toString() return 'value: $value, sum: $sum' + ( parent == null ? "" : ", parent" );
}