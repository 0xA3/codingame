package game.data;

using Lambda;

class State {
	
	static final restAction = new Action( -2, Rest );
	static final waitAction = new Action( -1, Wait );

	static final restCommand = Command.fromAction( restAction );
	static final waitCommand = Command.fromAction( waitAction );

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

	public final command:Command;
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
		?command:Command,
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

			this.command = command;
			this.actions = actions;
			this.depth = depth;
			this.parent = parent;
	}

	public function getChildStates() {
		final childStates:Array<State> = [];
		for( inputAction in actions ) {
			var isDoable = false;
			var times = 1;
			do {
				isDoable = inputAction.checkDoable( p1Inv0, p1Inv1, p1Inv2, p1Inv3, times );
				// trace( 'inputAction ${inputAction.type()} ${inputAction.actionId} $times - ${isDoable ? "doable" : "NOT doable"}' );
				if( isDoable ) {
					final childState = getChildState( inputAction, times );
					childState.score = childState.calculateScore( score );
					// trace( 'action ${childState.outputCommand()} score ${childState.score}' );
					childStates.push( childState );
				}
				times++;
				// trace( 'cast ${inputAction.actionType == Cast}  repeatable ${inputAction.repeatable}  isDoable $isDoable' );
			} while( inputAction.actionType == Cast && inputAction.repeatable && isDoable );
		}
		
		if( childStates.length > 0 ) return childStates;
		else {
			final waitState = getWaitState();
			waitState.score = waitState.calculateScore( score );
			return [waitState];
		}
	}

	inline function getChildState( inputAction:Action, times:Int ) {
		
		return switch inputAction.actionType {
			case Brew: executeBrew( inputAction );
			case Cast: executeCast( inputAction, times );
			case Learn: executeLearn( inputAction );
			case Rest: executeRest();
			case OpponentCast: throw "Error: OpponentCast has no child states";
			case Wait: throw "Error: Wait has no child states";
		}

	}

	inline function executeBrew( inputAction:Action ) {
		
		final childActions = actions.filter( a -> a != inputAction );

		final inv0 = p1Inv0 + inputAction.delta0;
		final inv1 = p1Inv1 + inputAction.delta1;
		final inv2 = p1Inv2 + inputAction.delta2;
		final inv3 = p1Inv3 + inputAction.delta3;
		final score = p1Score + inputAction.price;
		return new State(
			inv0, inv1, inv2, inv3, score,
			p1Potions + 1,
			p1Spells,
			p2Inv0, p2Inv1, p2Inv2, p2Inv3, p2Score, p2Potions, p2Spells,
			childActions,
			depth + 1,
			Command.fromAction( inputAction ),
			this
		);
	}

	inline function executeCast( inputAction:Action, times:Int ) {
		
		final childActions:Array<Action> = [];
		var hasRestAction = false;
		for( a in actions ) {
			if( a.actionType == Rest ) hasRestAction = true;
			if( a != inputAction ) childActions.push( a );
			if( a == inputAction ) childActions.push( a.setUncastable());
		}
		if( !hasRestAction ) childActions.push( restAction );

		final inv0 = p1Inv0 + inputAction.delta0 * times;
		final inv1 = p1Inv1 + inputAction.delta1 * times;
		final inv2 = p1Inv2 + inputAction.delta2 * times;
		final inv3 = p1Inv3 + inputAction.delta3 * times;
		final score = p1Score + inputAction.price;
		return new State(
			inv0, inv1, inv2, inv3, score,
			p1Potions,
			p1Spells,
			p2Inv0, p2Inv1, p2Inv2, p2Inv3, p2Score, p2Potions, p2Spells,
			childActions,
			depth + 1,
			Command.fromAction( inputAction, times ),
			this
		);
	}

	inline function executeLearn( inputAction:Action ) {
		
		final childActions:Array<Action> = [];
		for( a in actions ) {
			if( a == inputAction ) {
				final learnedAction = inputAction.convertToCastAction();
				childActions.push( learnedAction );
			}
			else {
				if( a.actionType == Learn && a.tomeIndex > inputAction.tomeIndex ) {
					final reducedAction =  inputAction.reduceTomeIndex();
					childActions.push( reducedAction );
				} else {
					childActions.push( a );
				}
			}
		}

		final inv0 = p1Inv0 - inputAction.tomeIndex;
		return new State(
			inv0, p1Inv1, p1Inv2, p1Inv3, p1Score,
			p1Potions,
			p1Spells + 1,
			p2Inv0, p2Inv1, p2Inv2, p2Inv3, p2Score, p2Potions, p2Spells,
			childActions,
			depth + 1,
			Command.fromAction( inputAction ),
			this
		);
	}

	inline function executeRest() {
		final childActions:Array<Action> = [];
		for( action in actions )	{
			switch action.actionType {
				case Rest: // don't include in childActions
				case Cast if( !action.castable ): childActions.push( action.setCastable());
				default: childActions.push( action );
			}
		}
		
		return new State(
			p1Inv0, p1Inv1, p1Inv2, p1Inv3, p1Score,
			p1Potions,
			p1Spells + 1,
			p2Inv0, p2Inv1, p2Inv2, p2Inv3, p2Score, p2Potions, p2Spells,
			childActions,
			depth + 1,
			restCommand,
			this
		);
	}

	inline function calculateScore( parentScore:Float ) {
		final stateScore = p1Score + p1Inv0 + p1Inv1 * 2 + p1Inv2 * 3 + p1Inv3 * 4 + p1Potions * 1.1 + p1Spells * 0.4;
		// trace( 'calculateScore $p1Score + $p1Inv0 + $p1Inv1 * 2 + $p1Inv2 * 3 + $p1Inv3 * 4 + $p1Potions * 1.1 + $p1Spells * 0.4 = $stateScore' );
		// trace( 'setScore to $parentScore * ${Math.log( 1 + stateScore )} = ${parentScore * Math.log( 1 + stateScore )}' );
		
		return parentScore * Math.log( 1 + stateScore );
		// return stateScore;
	}

	public function getWaitState() {
		return new State(
			p1Inv0, p1Inv1, p1Inv2, p1Inv3, p1Score, p1Potions, p1Spells,
			p2Inv0, p2Inv1, p2Inv2, p2Inv3, p2Score, p2Potions, p2Spells,
			[],
			depth + 1,
			waitCommand,
			this
		);
	}

	public function createRootState() {
		
		return new State(
			p1Inv0, p1Inv1, p1Inv2, p1Inv3, p1Score, p1Potions, p1Spells,
			p2Inv0, p2Inv1, p2Inv2, p2Inv3, p2Score, p2Potions, p2Spells,
			actions,
			0,
			command,
			this
		);
	}

	public function toString() {
		// return 'p1 inv $p1Inv0 $p1Inv1 $p1Inv2 $p1Inv3 score $p1Score potions $p1Potions spells $p1Spells depth $depth\nstatescore $score';
		final remainingActions = actions.map( a -> '${a.actionType} ${a.actionId}' ).join(", ");
		final thisAction = command == null ? "null" : '${command.actionType} ${command.actionId}';
		return 'depth: $depth, action: $thisAction, score: $score, remaining actions: $remainingActions';
	}

	public inline function outputCommand() {
		return command.output();
	}

	public function outputTree() {
		final spaces = [for( i in 0...depth ) " "].join("");
		final output = spaces + toString() + "\n";
		return parent == null ? output : parent.outputTree() + output;
		// return output;
	}

	public function p1Output() {
		return 'inv: $p1Inv0 $p1Inv1 $p1Inv2 $p1Inv3, score: $p1Score, potions: $p1Potions, spells: $p1Spells';
	}

	public function availablePotions() {
		return actions.fold(( action, sum ) -> action.actionType == Brew ? sum + 1 : sum, 0 );
	}
}