using Lambda;

class Interpreter {
	
	final resistors:Map<String, Float>;

	public function new( resistors:Map<String,Float> ) {
		this.resistors = resistors;
	}

	public function execute( ast:Expr ) {
		return calculate( ast );
	}

	function calculate( expr:Expr ):Float {
		switch expr {
			case Series( exprs ): return exprs.fold(( e, sum ) -> sum + calculate( e ), 0.0 );
			case Parallel( exprs ): return 1 / exprs.fold(( e, sum ) -> sum + 1 / calculate( e ), 0.0 );
			case Resistor( name ): return resistors[name];
		}
	}

}