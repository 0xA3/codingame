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

	public function addAction( a:TAction ) actions.unshift( a );

	public function execute( t:Int, opponent:Ai ) {
		for( command in commands ) {
			// trace( '${me.name} command $command' );
			switch command {
				case Always( a ):
					// trace( '${me.name} Always ${getAction( a )}' );
					return getAction( a );
				case MyPrevious( previousAction, a ):
					if(lastAction == previousAction ) {
						// trace( '${me.name} MyPrevious $previousAction ${getAction( a )}' );
						return getAction( a );
					}
				case OpponentPrevious( previousAction, a ):
					if( opponent.lastAction == previousAction ) {
						// trace( '${me.name} OpponentPrevious $previousAction ${getAction( a )}' );
						return getAction( a );
					}
				case MyMost(dominatingAction, a):
					if(getDominatingAction( dominatingAction )) {
						// trace( '${me.name} MyMost $dominatingAction ${getAction( a )}' );
						return getAction( a );
					}
				case OpponentMost(dominatingAction, a):
						// trace( '${me.name} OpponentMost $dominatingAction ${getAction( a )}' );
						if( opponent.getDominatingAction( dominatingAction )) {
						return getAction( a );
					}
				case OpponentLast( n, dominatingAction, a ):
					if( opponent.getDominatingActionOfLast( n, dominatingAction )) {
						// trace( '${me.name} OpponentLast $n $dominatingAction ${getAction( a )}' );
						return getAction( a );
					}
				case Start( a ):
					if( t == 0 ) {
						// trace( '${me.name} Start ${getAction( a )}' );
						return getAction( a );
					}
				case MyWin( a ):
					if(score > opponent.score ) {
						// trace( '${me.name} MyWin ${getAction( a )}' );
						return getAction( a );
					}
			}
		}
		throw 'Error: no action found';
	}
	
	function getAction( a:TAction ) {
		return switch a {
			case Cooperate: Cooperate;
			case Defect: Defect;
			case Random: lcg.rand() == 0 ? Defect : Cooperate;
		}
	}
}