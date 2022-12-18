package viewer;

enum abstract Events(Int) {
	var BUILD = 0;
	var MOVE = 1;
	var JUMP = 2;
	var SPAWN = 3;
	var FIGHT = 4;
	var CELL_DAMAGE = 7;
	var RECYCLER_FALL = 8;
	var CELL_OWNER_SWAP = 9;
	var UNIT_FALL = 10;
	var MATTER_COLLECT = 11;
}