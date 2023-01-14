package data;

typedef HumanDataset = {
	final id:Int;
	final isAlive:Bool;
	final x:Int;
	final y:Int;
}

typedef MutHumanDataset = {
	final id:Int;
	var isAlive:Bool;
	final x:Int;
	final y:Int;
}
