package view;

typedef FrameViewData = {
    // States
    var positions:Map<Int, Coord>;
    var messages:Map<Int, String>;
    var controlled:List<Int>;
    var pushed:List<Int>;
    var shielded:List<Int>;

    // Diffs
    var mana:Map<Int, Int>;
    var baseHealth:Map<Int, Int>;
    var mobHealth:Map<Int, Int>;

    // Events
    var spawns:List<EntityData>;
    var attacks:List<Attack>;
    var baseAttacks:List<BaseAttack>;
    var spellUses:List<SpellUse>;

}