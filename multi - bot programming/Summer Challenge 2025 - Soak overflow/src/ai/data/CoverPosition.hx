package ai.data;

import ya.Set;

class CoverPosition {
	
	public final value:Int;
	public final from:Set<Pos>;

	public function new( value:Int, from:Set<Pos> ) {
		this.value = value;
		this.from = from;
	}
}