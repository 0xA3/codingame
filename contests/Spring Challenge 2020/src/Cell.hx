enum Cell {
	Unknown;
	Wall;
	Empty;
	Food;
	Superfood;
	EnemyPac( enemyPac:Pac );
	MyPac;
	MyDestination;
}

// enum abstract Cell(Int) {
// 	var Unknown;
// 	var Wall;
// 	var Empty;
// 	var Food;
// 	var Superfood;
// 	var Enemy;
// 	var MyPac;
// 	var MyDestination;
// }

// class CellPrint {
// 	public static function print( c:Cell ) {
// 		return switch c {
// 			case Unknown: "Unknown";
// 			case Wall: "Wall";
// 			case Empty: "Empty";
// 			case Food: "Food";
// 			case Superfood: "Superfood";
// 			case Enemy: "Enemy";
// 			case MyPac: "MyPac";
// 			case MyDestination: "MyDestination";
// 		}
// 	}
// }