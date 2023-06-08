package ai.data;

@:structInit class CellDataset {
	public final type:Int;
	public final neighbors:Array<Int>;

	public var resources:Int;
	public var myAnts:Int;
	public var oppAnts:Int;

	public static function create( type:Int, neighbors:Array<Int> ) {
		final cellDataset:CellDataset = {
			type: type,
			neighbors: neighbors,
			resources: 0,
			myAnts: 0,
			oppAnts: 0
		}
		return cellDataset;
	}
}