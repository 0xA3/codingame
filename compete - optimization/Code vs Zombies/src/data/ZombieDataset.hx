package data;

typedef ZombieDataset = {
	final id:Int;
	final isUndead:Bool;
	final x:Int;
	final y:Int;
	final xNext:Int;
	final yNext:Int;
}

typedef MutZombieDataset = {
	final id:Int;
	var isUndead:Bool;
	var x:Int;
	var y:Int;
	var xNext:Int;
	var yNext:Int;
}