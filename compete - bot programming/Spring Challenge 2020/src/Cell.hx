enum abstract Cell(Int) {
	var Unknown;
	var Wall;
	var Empty;
	var Food;
	var Superfood;
	var Friend;
	var Enemy;
}
	 
class CellPrint {
	public static function print( c:Cell ) {
		return switch c {
			case Unknown: "Unknown";
			case Wall: "Wall";
			case Empty: "Empty";
			case Food: "Food";
			case Superfood: "Superfood";
			case Friend: "Friend";
			case Enemy: "Enemy";
		}
	}
}
