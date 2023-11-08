enum Expr {
	ClearScreen( character:String );
	Forward( times:Int );
	PenUp;
	PenDown;
	SetPc( pens:Array<String> );
	Right( angle:Int );
	Left( angle:Int );
	Repeat( times:Int, commands:Array<Expr> );
}