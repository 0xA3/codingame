package game;

abstract class GameEntity {
	static var ENTITY_COUNT = 0;

	public final id:Int;
    public var position:Vector;
    public var type:Int;
    public var activeControls:List<Vector>;
    public var shieldDuration:Int;
    public var pushed:Bool;

	public function new( id:Int, position:Vector, type:Int ) {
		this.id = id;
		this.position = position;
		this.type = type;
		activeControls = new List<Vector>();
		shieldDuration = 0;
	}

	function applyControl( destination:Vector ) activeControls.add( destination );
	public function applyShield() shieldDuration = Config.SPELL_PROTECT_DURATION + 1;
	public function getOwner() return null;
	public function hasActiveShield() return shieldDuration > 0 && shieldDuration < Config.SPELL_PROTECT_DURATION + 1;
	public function hadActiveShield() return shieldDuration > 0 && shieldDuration < Config.SPELL_PROTECT_DURATION;
	public function gotPushed() return pushed;
	public function isControlled() return !activeControls.isEmpty();
	public function pushTo( position:Vector ) this.position = position;
	
}