package view;

typedef FrameViewData = {
	// States
    var positions:Map<Int, Coord>;
    var messages:Map<Int, String>;
    var controlled:Array<Int>;
    var pushed:Array<Int>;
    var shielded:Array<Int>;

    // Diffs
    var mana:Array<Int>;
    var baseHealth:Array<Int>;
    var mobHealth:Map<Int, Int>;

    // Events
    var spawns:Array<EntityData>;
    var attacks:Array<Attack>;
    var baseAttacks:Array<BaseAttack>;
    var spellUses:Array<SpellUse>;

}