package ai.data;

enum TAction {
	NotPossible;
	Grow( id:Int, x:Int, y:Int, type:TCell, direction:TDir, text:String );
	Wait;
}