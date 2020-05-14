enum abstract Cell(Int) {
	var Unknown;
	var Wall;
	var Empty;
	var Food;
	var Superfood;
	// var Enemy;
	// var TargetEnemy;
	// var Friend;
	// var TargetFriend;
}
	 
class CellPrint {
	public static function print( c:Cell ) {
		return switch c {
			case Unknown: "Unknown";
			case Wall: "Wall";
			case Empty: "Empty";
			case Food: "Food";
			case Superfood: "Superfood";
			// case Enemy: "Enemy";
			// case TargetEnemy: "TargetEnemy";
			// case Friend: "Friend";
			// case TargetFriend: "TargetFriend";
		}
	}
}
