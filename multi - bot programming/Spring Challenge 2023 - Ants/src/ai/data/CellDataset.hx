package ai.data;

@:structInit class CellDataset {
	
	public static final NO_CELL_DATASET:CellDataset = { type: -1, neighbors: [] };
	
	public final type:Int;
	public final neighbors:Array<Int>;

	public var resources = 0;
	public var myAnts = 0;
	public var oppAnts = 0;

	public static function create( type:Int, neighbors:Array<Int>, resources = 0 ) {
		final cellDataset:CellDataset = {
			type: type,
			neighbors: neighbors,
			resources: resources,
		}
		return cellDataset;
	}
}