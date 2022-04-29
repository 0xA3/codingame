package game;

import gameengine.core.AbstractMultiplayerPlayer;

class Player extends AbstractMultiplayerPlayer {

	public final name:String;
	public var basePosition:Vector;

	public final heros:Array<Hero> = [];
	public var mana = Config.STARTING_MANA;
	public var manaChanged = true;
	public var baseHealthChanged = true;
	public var baseHealth = Config.STARTING_BASE_HEALTH;
	public var spottet:Map<Int, Bool> = [];
	public var manaGainedOutsideOfBase(default, null) = 0;


	public function new( index:Int, name:String, baseX:Int, baseY:Int ) {
		this.index = index;
		this.name = name;
		basePosition = new Vector( baseX, baseY );
	}

	override public function init() {
		super.init();
		heros.splice( 0, heros.length );
		mana = Config.STARTING_MANA;
		manaChanged = true;
		baseHealthChanged = true;
		baseHealth = Config.STARTING_BASE_HEALTH;
		spottet.clear();
		manaGainedOutsideOfBase = 0;
	}

	public function getExpectedOutputLines() return heros.length;
	public function addHero( hero:Hero ) heros.push( hero );

	public function gainMana( amount:Array<Int> ) {
		mana += amount[0];
		manaGainedOutsideOfBase += amount[1];
		if (Config.MAX_MANA > 0) {
            if (mana > Config.MAX_MANA) {
                mana = Config.MAX_MANA;
            }
            if (manaGainedOutsideOfBase > Config.MAX_MANA) {
                manaGainedOutsideOfBase = Config.MAX_MANA;
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