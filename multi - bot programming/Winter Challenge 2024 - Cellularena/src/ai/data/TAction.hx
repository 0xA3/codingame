package ai.data;

enum TAction {
	NotPossible;
	Grow( id:Int, x:Int, y:Int, type:TCell, direction:TDir, text:String );
	Spore( id:Int, x:Int, y:Int, text:String );
	Wait;
}