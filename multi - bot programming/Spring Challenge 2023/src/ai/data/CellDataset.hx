package ai.data;

typedef CellDataset = {
	final type:Int;
	final neighbors:Array<Int>;

	var resources:Int;
	var myAnts:Int;
	var oppAnts:Int;
}