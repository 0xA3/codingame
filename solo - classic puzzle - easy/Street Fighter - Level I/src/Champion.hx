import CodinGame.printErr;
import Constants.ChampionStats;

class Champion {
	
	public final name:String;
	public final stats:ChampionStats;

	public var life:Int;
	public var rage = 0;
	public var numberOfHitsMade = 0;
	public var damageReceived = 0;

	public function new( name:String, stats:ChampionStats, life:Int ) {
		this.name = name;
		this.stats = stats;
		this.life = life;
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
		rage = 0;
		numberOfHitsMade++;
	}

	public function getHit( damage:Int ) {
		life -= damage;
		damageReceived += damage;
	}

	public function toString() return '$name: life $life  rage $rage';
}