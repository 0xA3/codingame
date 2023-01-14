class PathNode {
	
	public final id:Int;
	public final money:Int;
	public final neighbors:Array<Int> = [];
	public var moneyFromStart = 0;
	public var priority = 0;
	public var previous = -1;

	public function new( id:Int, money:Int, neighbors:Array<Int> ) {
		this.id = id;
		this.money = money;
		this.neighbors = neighbors;
	}

	public function toString() return '{ ${ previous != -1 ? Std.string( previous ) + "-" : ""}$id prio: $priority}';

	public static function compareMoneyFromStart( a:PathNode, b:PathNode ) {
		if( a.moneyFromStart > b.moneyFromStart ) return true;
		return false;
	}

}