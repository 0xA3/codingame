typedef Block = {
	var l:Array<Block>;
	var r:Array<Block>;
}

class Parser {
	
	var expressions:Array<String>;
	var lineNo:Int;
	
	public function new() {}

	public function parse( expressions:Array<String> ) {
		this.expressions = expressions;
		lineNo = 0;
		return parseExpression();
	}

	function parseExpression() {
		final blocks:Array<Block> = [];
		while( true ) { // trace( 'parseExpression $lineNo' );
			var tk = token();
			switch tk {
				case "if": blocks.push( parseIf());
				case "else": throw "Error: unexpected 'else'";
				case "endif": throw "Error: unexpected 'endif'";
				case "end": break;
			}
		}
		return blocks;
	}

	function parseIf() {
		final ifContent:Array<Block> = [];
		while( true ) { // trace( 'parseIf content $lineNo' );
			var tk = token();
			switch tk {
				case "if": ifContent.push( parseIf());
				case "else":
					final elseContent = parseElse();
					final Block:Block = { l: ifContent, r:elseContent };
					return Block;
				case "endif": throw "Error: unexpected 'endif'";
				case "end": throw "Error: unexpected 'end'";
			}
		}
	}

	function parseElse() {
		final elseContent:Array<Block> = [];
		while( true ) { // trace( 'parseElse content $lineNo' );
			var tk = token();
			switch tk {
				case "if": elseContent.push( parseIf());
				case "else": throw "Error: unexpected 'else'";
				case "endif": return elseContent;
				case "end": throw "Error: unexpected 'end'";
			}
		}
	}

	function token() {
		var tk = expressions[lineNo]; // trace( ': $tk :' );
		lineNo++;
		return tk;
	}
}