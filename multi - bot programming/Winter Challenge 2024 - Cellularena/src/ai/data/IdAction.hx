package ai.data;

class IdAction {
	
	public static final NOT_POSSIBLE = new IdAction( -1, TAction.NotPossible );
	
	public var rootId:Int;
	public var action:TAction;
	
	public function new( rootId:Int, action:TAction ) {
		this.rootId = rootId;
		this.action = action;
	}

	public function toString() return 'rootId: $rootId, action: $action';
}