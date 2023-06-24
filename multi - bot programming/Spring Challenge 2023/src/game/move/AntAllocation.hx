package game.move;

class AntAllocation {
	
	final antIndex:Int;
	final beaconIndex:Int;
	final amount:Int;

	public function new( antIndex:Int, beaconIndex:Int, amount:Int ) {
		this.antIndex = antIndex;
		this.beaconIndex = beaconIndex;
		this.amount = amount;
	}
	
	public function getAntIndex() {
		return antIndex;
	}

	public function getBeaconIndex() {
		return beaconIndex;
	}

	public function getAmount() {
		return amount;
	}
}