package game;

import gameengine.core.AbstractMultiplayerPlayer;

class Player extends AbstractMultiplayerPlayer {

	public final name:String;

	public final heros:Array<Hero> = [];
	public var mana = Configuration.STARTING_MANA;
	public var manaChanged = true;
	public var baseHealthChanged = true;
	public var baseHealth = Configuration.STARTING_BASE_HEALTH;
	public var spottet:Map<Int, Bool> = [];
	public var manaGainedOutsideOfBase(default, null) = 0;

	public function new( index:Int, ?name:String ) {
		this.index = index;
		this.name = name == null ? "Nobody" : name;
	}

	public function getExpectedOutputLines() return heros.length;
	public function addHero( hero:Hero ) heros.push( hero );

	public function gainMana( amount:Array<Int> ) {
		mana += amount[0];
		manaGainedOutsideOfBase += amount[1];
		if (Configuration.MAX_MANA > 0) {
            if (mana > Configuration.MAX_MANA) {
                mana = Configuration.MAX_MANA;
            }
            if (manaGainedOutsideOfBase > Configuration.MAX_MANA) {
                manaGainedOutsideOfBase = Configuration.MAX_MANA;
            }
        }
        manaChanged = true;
	}

	public function manaHasChanged() return manaChanged;

	public function resetViewData() {
        manaChanged = false;
        baseHealthChanged = false;
	}

	public function spendMana( amount:Int ) {
		mana -= amount;
		manaChanged = true;
	}

	public function damageBase() {
		this.baseHealth--;
        if (this.baseHealth < 0) {
            this.baseHealth = 0;
        }
        baseHealthChanged = true;
	}

	public function baseHealthHasChanged() {
        return baseHealthChanged;
    }

	public function toString() {
		return '$name index $index';
	}
}