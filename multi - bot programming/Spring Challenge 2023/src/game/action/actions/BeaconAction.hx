package game.action.actions;

import game.action.ActionType;

class BeaconAction extends Action {
	
	var cellIndex:Int;
	var power:Int;

	public function new( cellIndex:Int, power:Int ) {
		super( BEACON );
		this.cellIndex = cellIndex;
		this.power = power;
	}

    public function getCellIndex() return cellIndex;
    public function setCellIndex( cellIndex:Int ) this.cellIndex = cellIndex;

    public function getPower() return power;
    public function setPower( power:Int ) this.power = power;

}