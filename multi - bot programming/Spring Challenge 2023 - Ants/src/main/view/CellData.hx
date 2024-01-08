package main.view;

@:structInit class CellData {
	
	public final q:Int;
	public final r:Int;
	public var richness:Int;
	public final index:Int;
	public var owner:Int;
	public var type:Int;
	public var ants:Array<Int> = [];

	public function toString() return 'q: $q, r: $r, richness: $richness, index: $index, owner: $owner, type: $type, ants: $ants';
}