package view;

class CellData {
	
	public var q:Int;
	public var r:Int;
	public var richness:Int;
	public var index:Int;
	public var owner:Int;
	public var type:Int;
	public var ants:Array<Int> = [];

	public function new() {}

	public function toString() return 'q: $q, r: $r, richness: $richness, index: $index, owner: $owner, type: $type, ants: $ants';
}