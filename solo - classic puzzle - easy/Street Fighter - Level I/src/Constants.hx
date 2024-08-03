typedef ChampionStats = {
	final life:Int;
	final punch:Int;
	final kick:Int;
	final special:( Champion, Champion )->Void;
}

class Constants {
	
	public static final championsConstants:Map<String, ChampionStats> = [
		"KEN" => {
			life: 25,
			punch: 6,
			kick: 5,
			special: ( attacker, opp ) -> opp.getHit( attacker.rage * 3 )
		},
		"RYU" => {
			life: 25,
			punch: 4,
			kick: 5,
			special: ( attacker, opp ) -> opp.getHit( attacker.rage * 4 )
		},
		"TANK" => {
			life: 50,
			punch: 2,
			kick: 2,
			special: ( attacker, opp ) -> opp.getHit( attacker.rage * 2 )
		},
		"VLAD" => {
			life: 30,
			punch: 3,
			kick: 3,
			special: ( attacker, opp ) -> {
				opp.getHit( 2 * ( attacker.rage + opp.rage ));
				opp.rage = 0;
			}
		},
		"JADE" => {
			life: 20,
			punch: 2,
			kick: 7,
			special: ( attacker, opp ) -> opp.getHit( attacker.numberOfHitsMade * attacker.rage )
		},
		"ANNA" => {
			life: 18,
			punch: 9,
			kick: 1,
			special: ( attacker, opp ) -> opp.getHit( attacker.damageReceived * attacker.rage )
		},
		"JUN" => {
			life: 60,
			punch: 2,
			kick: 1,
			special: ( attacker, opp ) -> {
				opp.getHit( attacker.rage );
				attacker.life += attacker.rage;
			}
		}
	];
}