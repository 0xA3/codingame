import TAction;

class Ai {
	
	public final name:String;
	public final commands:Array<TCommand>;
	final lcg:LinearCongruentalGenerator;

	public var score = 0;
	public var actions:Array<TAction> = [];
	
	@:isVar public var lastAction(get, never):TAction;
	function get_lastAction() return actions.length > 0 ? actions[0] : throw 'Error: no last action';
	
	public function new( name:String, commands:Array<TCommand>, lcg:LinearCongruentalGenerator ) {
		this.name = name;
		this.commands = commands;
		this.lcg = lcg;
	}

	public function getDominatingAction( a:TAction ) return getDominatingActionOfLast( actions.length, a );
	
	public function getDominatingActionOfLast( count:Int, a:TAction ) {
		final n = count > actions.length ? actions.length : count;
		
		var actionCount = 0;
		for( i in 0...n ) if( actions[i] == a ) actionCount++;
		return actionCount / n > 0.5;
	}

	public function getAction( a:TAction ) {
		return switch a {
			case Cooperate: Cooperate;
			case Defect: Defect;
			case Random: lcg.rand() == 0 ? Defect : Cooperate;
		}
	}

	public function addAction( a:TAction ) actions.unshift( a );

}