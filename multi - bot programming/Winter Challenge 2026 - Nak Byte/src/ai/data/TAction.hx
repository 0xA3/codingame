package ai.data;

//actions are "MOVE x y | SHOOT id | THROW x y | HUNKER_DOWN | MESSAGE text"

enum TAction {
	// None;
	HunkerDown;
	Message( text:String );
	Move( x:Int, y:Int );
	Shoot( id:Int );
	Throw( x:Int, y:Int );
}