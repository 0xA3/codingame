enum Expr {
	Series( exprs:Array<Expr> );
	Parallel( exprs:Array<Expr> );
	Resistor( name:String );
}