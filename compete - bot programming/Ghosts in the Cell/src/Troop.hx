class Troop {
	
	public final startFactory:Int;
	public final targetFactory:Int;
	public final cyborgs:Int;
	public final arrives:Int;

	public function new( startFactory:Int, targetFactory:Int, cyborgs:Int, arrives:Int ) {
		this.startFactory = startFactory;
		this.targetFactory = targetFactory;
		this.cyborgs = cyborgs;
		this.arrives = arrives;
	}

	public static function sortByArrives( t1:Troop, t2:Troop ) {
		final a1 = t1.arrives;
		final a2 = t2.arrives;
		if( a1 > a2 ) return -1;
		if( a1 < a2 ) return 1;
		return 0;
	}
}