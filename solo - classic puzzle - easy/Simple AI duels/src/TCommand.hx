enum TCommand {
	Always( a:TAction );
	MyPrevious( previousAction:TAction, a:TAction );
	OpponentPrevious( previousAction:TAction, a:TAction );
	MyMost( dominatingAction:TAction, a:TAction );
	OpponentMost( dominatingAction:TAction, a:TAction );
	OpponentLast( n:Int, dominatingAction:TAction, a:TAction );
	Start( a:TAction );
	MyWin( a:TAction );
}