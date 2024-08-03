import CodinGame.printErr;
import Main.ChampionStats;

class Champion {
	
	public final name:String;
	public final stats:ChampionStats;
	public final state:State;

	public var numberOfHitsMade = 0;
	public var damageReceived = 0;

	public function new( name:String, stats:ChampionStats, state:State ) {
		this.name = name;
		this.stats = stats;
		this.state = state;
	}

	public function punch( opp:Champion ) {
		opp.getHit( stats.punch );
		// printErr( '${opp.name} decreases by ${stats.punch}' );
		numberOfHitsMade++;
	}

	public function kick( opp:Champion ) {
		opp.getHit( stats.kick );
		// printErr( '${opp.name} decreases by ${stats.punch}' );
		numberOfHitsMade++;
	}

	public function special( opp:Champion ) {
		stats.special( this, opp );
		state.rage = 0;
		numberOfHitsMade++;
	}

	public function getHit( damage:Int ) {
		state.life -= damage;
		damageReceived += damage;
	}

	public function toString() return '$name: $state';
}