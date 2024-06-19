package ai.data;

class Node {
	
	public static final NO_NODE = new Node();

	public var action = "";
	public final hurdleDataset = new HurdleDataset();
	public final archeryDataset = new ArcheryDataset();
	public final skatingDataset = new SkatingDataset();
	public final divingDataset = new DivingDataset();
	public var parent:Node = NO_NODE;

	public function new() {	}

	public function reset() {
		parent = NO_NODE;
		hurdleDataset.reset();
		archeryDataset.reset();
		skatingDataset.reset();
		divingDataset.reset();
	}
}