package game.action;

enum Action {
	BEACON( cellIndex:Int, power:Int );
	LINE( from:Int, to:Int, ants:Int );
	MESSAGE( message:String );
	WAIT;
	NONE;
}