import haxe.ds.Option;
import Parser.Expr;

class Interp {
	
	public static function execute( exprs:Array<Expr> ) {
		var i = 0;
		var output = "";
		for( expr in exprs ) {
			switch expr {
				case Text( s ): output += s;
				case Clauses( c ):
					output += c[ i % c.length ];
					i++;
			}
		}
		return output;
	}
}