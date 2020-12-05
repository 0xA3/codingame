package game.data;

using Lambda;

class State {
	
	static final restAction = new Action( -2, Rest );
	static final waitAction = new Action( -1, Rest );

	final p1Inv0:Int;
	final p1Inv1:Int;
	final p1Inv2:Int;
	final p1Inv3:Int;
	final p1Score:Int;
	final p1Potions:Int;
	final p1Spells:Int;

	final p2Inv0:Int;
	final p2Inv1:Int;
	final p2Inv2:Int;
	final p2Inv3:Int;
	final p2Score:Int;
	final p2Potions:Int;
	final p2Spells:Int;

	public final action:Action;
	final actions:Array<Action>;
	public final depth:Int;
	public final parent:State;
	
	public var score = 1.0;

	public function new(
		p1Inv0:Int,
		p1Inv1:Int,
		p1Inv2:Int,
		p1Inv3:Int,
		p1Score:Int,
		p1Potions:Int,
		p1Spells:Int,
	
		p2Inv0:Int,
		p2Inv1:Int,
		p2Inv2:Int,
		p2Inv3:Int,
		p2Score:Int,
		p2Potions:Int,
		p2Spells:Int,

		actions:Array<Action>,
		depth = 0,
		?action:Action,
		?parent:State

		) {
			this.p1Inv0 = p1Inv0;
			this.p1Inv1 = p1Inv1;
			this.p1Inv2 = p1Inv2;
			this.p1Inv3 = p1Inv3;
			this.p1Score = p1Score;
			this.p1Potions = p1Potions;
			this.p1Spells = p1Spells;

			this.p2Inv0 = p2Inv0;
			this.p2Inv1 = p2Inv1;
			this.p2Inv2 = p2Inv2;
			this.p2Inv3 = p2Inv3;
			this.p2Score = p2Score;
			this.p2Potions = p2Potions;
			this.p2Spells = p2Spells;

			this.action = action;
			this.actions = actions;
			this.depth = depth;
			this.parent = parent;
	}

	public function getChildStates() {
		final childStates:Array<State> = [];
		var learnTax = 0;
		for( action in actions ) {
			if( action.checkDoable( p1Inv0, p1Inv1, p1Inv2, p1Inv3, learnTax )) {
				final childState = getChildState( 1, action );
				childState.score = childState.calculateScore( score );
				// trace( 'action ${childState.actionOutput()} score ${childState.score}' );
				childStates.push( childState );
			}
			if( action.actionType == Learn ) learnTax++;
		}
		
		return childStates.length == 0 ? [getWaitState()] : childStates;
	}

	function getChildState( playerNo:Int, actionToExecute:Action ) {
		
		final childStateActions = switch actionToExecute.actionType {
			case Brew: actions.filter( a -> a != actionToExecute );
			case Cast: getCastChildActions( actionToExecute );
			case Learn: getLearnChildActions( actionToExecute );
			case Rest: getRestChildActions();
			case OpponentCast: throw "Error: no childStates of OpponentCast actions";
			case Wait: throw "Error: no childStates of Wait actions";
		}
		
		switch playerNo {
			case 1:
				final inv0 = p1Inv0 + actionToExecute.delta0;
				final inv1 = p1Inv1 + actionToExecute.delta1;
				final inv2 = p1Inv2 + actionToExecute.delta2;
				final inv3 = p1Inv3 + actionToExecute.delta3;
				final score = p1Score + actionToExecute.price;
				return new State(
					inv0, inv1, inv2, inv3, score,
					actionToExecute.actionType == Brew ? p1Potions + 1 : p1Potions,
					actionToExecute.actionType == Learn ? p1Spells + 1 : p1Spells,
					p2Inv0, p2Inv1, p2Inv2, p2Inv3, p2Score, p2Potions, p2Spells,
					childStateActions,
					depth + 1,
					actionToExecute,
					this
				);
			case 2:
				final inv0 = p2Inv0 + actionToExecute.delta0;
				final inv1 = p2Inv1 + actionToExecute.delta1;
				final inv2 = p2Inv2 + actionToExecute.delta2;
				final inv3 = p2Inv3 + actionToExecute.delta3;
				final score = p1Score + actionToExecute.price;
				return new State(
					p1Inv0, p1Inv1, p1Inv2, p1Inv3, p1Score, p1Potions, p1Spells,
					inv0, inv1, inv2, inv3, score,
					actionToExecute.actionType == Brew ? p2Potions + 1 : p2Potions,
					actionToExecute.actionType == Learn ? p2Spells + 1 : p2Spells,
					childStateActions,
					depth + 1,
					actionToExecute,
					this
				);
			default: throw "Error: playerNo must be 1 or 2";
		}
	}

	inline function getCastChildActions( actionToExecute:Action ) {
		final childStateActions:Array<Action> = [];
		var hasWaitAction = false;
		for( a in actions ) {
			if( a.actionType == Wait ) hasWaitAction = true;
			if( a != actionToExecute ) childStateActions.push( a );
			if( a == actionToExecute ) childStateActions.push( a.cloneUncastable());
		}
		if( !hasWaitAction ) childStateActions.push( waitAction );
		return childStateActions;
	}

	inline function getLearnChildActions( actionToExecute:Action ) {
		final childStateActions = actions.filter( a -> a != actionToExecute );
		childStateActions.push( actionToExecute.cloneAsCastAction());
		return childStateActions;
	}

	inline function getRestChildActions() {
		final childStateActions:Array<Action> = [];
		for( a in actions )	{
			if( a.actionType == Cast && !a.castable ) childStateActions.push( a.cloneCastable());
			else childStateActions.push( a );
		}
		return childStateActions;
	}

	inline function calculateScore( parentScore:Float ) {
		final stateScore = p1Score + p1Inv0 + p1Inv1 * 2 + p1Inv2 * 3 + p1Inv3 * 4 + p1Potions * 1.1 + p1Spells * 0.4;
		return parentScore * Math.log( stateScore );
	}

	public function getWaitState() {
		return new State(
			p1Inv0, p1Inv1, p1Inv2, p1Inv3, p1Score, p1Potions, p1Spells,
			p2Inv0, p2Inv1, p2Inv2, p2Inv3, p2Score, p2Potions, p2Spells,
			[],
			depth + 1,
			waitAction,
			this
		);
	}

	public function createRootState() {
		
		return new State(
			p1Inv0, p1Inv1, p1Inv2, p1Inv3, p1Score, p1Potions, p1Spells,
			p2Inv0, p2Inv1, p2Inv2, p2Inv3, p2Score, p2Potions, p2Spells,
			actions,
			0,
			action,
			this
		);
	}

	public function toString() {
		// return 'p1 inv $p1Inv0 $p1Inv1 $p1Inv2 $p1Inv3 score $p1Score potions $p1Potions spells $p1Spells depth $depth\nstatescore $score';
		final remainingActions = actions.map( a -> '${a.actionType} ${a.actionId}' ).join(", ");
		final thisAction = action == null ? "null" : '${action.actionType} ${action.actionId}';
		return 'depth: $depth, action: $thisAction, score: $score, remaining actions: $remainingActions';
	}

	public function actionOutput() {
		return switch action.actionType {
			case Wait: 'WAIT';
			case Rest: 'REST';
			default: '${action.type()} ${action.actionId}';
		}
	}

	public function p1Output() {
		return 'inv: $p1Inv0 $p1Inv1 $p1Inv2 $p1Inv3, score: $p1Score, potions: $p1Potions, spells: $p1Spells';
	}

	public function getNoOfPotionsLeft() {
		return actions.fold(( action, sum ) -> action.actionType == Brew ? sum + 1 : sum, 0 );
	}
}