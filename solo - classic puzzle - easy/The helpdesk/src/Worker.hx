import CodinGame.printErr;

class Worker {
	
	static final BREAK_TIME = 10;

	final id:Int;
	final efficiency:Float;
	final worktime:Int;
	
	public var customers = 0;
	public var breaks = 0;
	var timeWithoutABreak = 0.0;

	var endtime = 0.0;

	public function new( id:Int, efficiency:Float, worktime:Int ) {
		this.id = id;
		this.efficiency = efficiency;
		this.worktime = worktime;
	}

	public function getEndtime() {
		return timeWithoutABreak < worktime ? endtime : endtime + BREAK_TIME;
	}

	public function assignCustomer( helptime:Int ) {
		if( timeWithoutABreak >= worktime ) {
			endtime += BREAK_TIME;
			breaks++;
			timeWithoutABreak = 0;
			if( id == 4 ) printErr( 'takes a break  totalbreaks $breaks' );
		}
		final customerTime = helptime / efficiency;
		customers++;
		endtime += customerTime;
		timeWithoutABreak += customerTime;
		if( id == 4 ) printErr( 'assignCustomer $helptime  efficiency $efficiency  endTime $endtime  timeWithoutABreak ${timeWithoutABreak}' );
	}

	public function toString() return '$customers $breaks';
}