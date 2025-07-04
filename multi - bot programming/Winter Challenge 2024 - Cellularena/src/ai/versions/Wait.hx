package ai.versions;

import ai.contexts.Action;
import ai.data.Cell;
import ai.data.TAction;
import xa3.math.Pos;

using Lambda;

class Wait {
	
	public var aiId = "Wait";
	
	var myRootIds:Array<Int>;
	final outputs:Array<String> = [];

	public function new() { }
	
	public function setGlobalInputs( positions:Array<Array<Pos>>, cells:Map<Pos, Cell>, width:Int, height:Int ) {
	}
	
	public function setInputs(
		a:Int,
		b:Int,
		c:Int,
		d:Int,
		requiredActionsCount:Int,
		myRootIds:Array<Int>,
		myCells:Array<Cell>,
		harvestedProteins:Map<Pos, Bool>,
		myMoves:Array<Cell>,
		oppMoves:Array<Cell>
	) {
		this.myRootIds = myRootIds;
	}

	public function process() {
		outputs.splice( 0, outputs.length );
		for( rootId in myRootIds ) outputs.push( Action.toString( TAction.Wait ));
		
		return outputs.join( "\n" );
	}
}
