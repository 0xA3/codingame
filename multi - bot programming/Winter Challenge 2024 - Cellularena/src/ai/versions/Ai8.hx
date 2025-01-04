package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.contexts.OutputTCell.output;
import ai.contexts.Type;
import ai.data.Cell;
import ai.data.IdAction;
import ai.data.Node;
import ai.data.NodePool;
import ai.data.TAction;
import ai.data.TCell;
import ai.data.TDir;
import ai.data.TGrow;
import ai.data.TState;
import algorithm.MinPriorityQueue;
import haxe.ds.ArraySort;
import xa3.math.Pos;

using xa3.MathUtils;

class Ai8 {
	
	static inline var ME = 1;
	static inline var OPP = 0;
	static inline var NO_OWNER = -1;

	public var aiId = "Ai8 add sporer";

	final states = [Defend, HarvestA, HarvestB, HarvestC, Attack, HarvestD, Grow, TState.Wait];
	
	final proteinCellTypes = [TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];
	final borderCellNeighborTypes = [TCell.Empty => true, TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];

	var positions:Array<Array<Pos>>;
	var cells:Map<Pos, Cell>;
	var width:Int;
	var height:Int;

	var requiredActionsCount:Int;
	var entities:Array<Cell>;
	var myCells:Array<Cell>;
	var myRootIds:Array<Int>;
	var harvestedProteins:Map<Pos, Bool>;
	var myMoves:Array<Cell>;
	var oppMoves:Array<Cell>;
	var a:Int;
	var b:Int;
	var c:Int;
	var d:Int;

	var turn:Int;
	var stateId:Int;
	var timestamp:Float;

	final nodePool = new NodePool();
	final visited:Array<Array<Bool>> = [];
	final myBorderCells:Array<Cell> = [];
	final income = [TCell.A => 0, TCell.B => 0, TCell.C => 0, TCell.D => 0];
	final isInFrontOfTentacles:Map<Int, Map<Pos, Bool>> = [ME => [], OPP => []];

	final actions:Map<Int, TAction> = [];
	final outputs:Array<String> = [];

	public function new() {	}

	public function setGlobalInputs( positions:Array<Array<Pos>>, cells:Map<Pos, Cell>, width:Int, height:Int ) {
		this.positions = positions;
		this.cells = cells;
		this.width = width;
		this.height = height;
		
		for( _ in 0...height ) visited.push( [for( _ in 0...width ) false] );

		turn = 0;
	}
	
	public function setInputs(
		a:Int,
		b:Int,
		c:Int,
		d:Int,
		requiredActionsCount:Int,
		myRootIds:Array<Int>,
		myCells:Array<Cell>,
		harvestedProteins:Map<Pos, Bool>,
		myMoves:Array<Cell>,
		oppMoves:Array<Cell>
	) {
		this.requiredActionsCount = requiredActionsCount;
		this.myRootIds = myRootIds;
		this.myCells = myCells;
		this.myMoves = myMoves;
		this.oppMoves = oppMoves;
		this.harvestedProteins = harvestedProteins;
		
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	public function process() {
		turn++;

		isInFrontOfTentacles[ME].clear();
		isInFrontOfTentacles[OPP].clear();

		initBorderCells();
		initHarvestedProteinTypes();
		// for( cell in oppCells ) printErr( 'opp cells: pos: ${cell.pos}, type: ${output( cell.type )}' );
		// for( cell in myBorderCells ) printErr( 'border cells: pos: ${cell.pos}, type: ${output( cell.type )}' );

		actions.clear();
		// for( i in 0...requiredActionsCount ) {
		stateId = 0;
		while( stateId < states.length ) {
			final state = states[stateId];
			printErr( 'state: $state' );
			var idAction = IdAction.NOT_POSSIBLE;
			switch( state ) {
				case Attack: idAction = getAttackCommand();
				case Defend: idAction = getDefendCommand();
				case Grow: idAction = getGrowCommand();
				case HarvestA: if( income[TCell.A] == 0 ) idAction = getHarvestCommand( TCell.A);
				case HarvestB: if( income[TCell.B] == 0 ) idAction = getHarvestCommand( TCell.B );
				case HarvestC: if( income[TCell.C] == 0 ) idAction = getHarvestCommand( TCell.C );
				case HarvestD: if( income[TCell.D] == 0 ) idAction = getHarvestCommand( TCell.D );
				case Wait: // no-op
			}
			// printErr( 'idAction $idAction' );
			final action = idAction.action;
			if( action != TAction.NotPossible ) {
				final rootId = idAction.rootId;
				actions.set( rootId, action );
				break;
			}
			stateId++;
		}

		outputs.splice( 0, outputs.length );
		
		for( rootId in myRootIds ) {
			// printErr( 'rootId: $rootId, actions[rootId]: ${actions[rootId]}' );
			if( actions.exists( rootId ) ) {
				outputs.push( Action.toString( actions[rootId] ));
			} else {
				outputs.push( Action.toString( TAction.Wait ));
			}
		}
		return outputs.join( "\n" );
	}
	
	function getAttackCommand() {
		if( !canGrowTentacle()) return IdAction.NOT_POSSIBLE;
		
		final nodes = findPathsToOpp();
		// printErr( 'nodes positions:\n${getNodesPositions( nodes )}' );
		if( nodes.length == 0 ) {
			return return IdAction.NOT_POSSIBLE;
		} else {
			ArraySort.sort( nodes, ( a, b ) -> {
				if( a.distance < b.distance ) return -1;
				if( a.distance > b.distance ) return 1;
				return 0;
			});
			// var node = Node.NO_NODE;
			// if( nodes.length > 1 ) {
			// 	final distanceToRoot0 = getDistanceToRoot( nodes[0].cell );
			// 	final distanceToRoot1 = getDistanceToRoot( nodes[1].cell );
			// }
			final node = nodes[0];
			// printErr( 'attack ${node.cell.pos}, distance: ${node.distance}, type: ${Type.toString( node.cell.type )}' );
			if( node.distance < 5 ) {
				final attackDirectionNode = backtrack( node, 2 );
				final attackNode = attackDirectionNode.parent;
				// printErr( 'attackNode: ${attackNode.cell.pos}, distance: ${attackNode.distance}, type: ${Type.toString( attackNode.cell.type )}' );
				final attackPos = attackNode.cell.pos;
				// printErr( 'grow tentacle at $attackPos' );
				
				final attackDirection = getDirection( attackPos, attackDirectionNode.cell.pos );
				
				nodePool.addNodesHierarchy( nodes );
				return new IdAction( node.rootId, TAction.Grow( attackNode.startCellId, attackPos.x, attackPos.y, TGrow.Tentacle, attackDirection, "" ));
			} else {
				final neighborNode = backtrack( node );
				
				nodePool.addNodesHierarchy( nodes );
				return new IdAction( node.rootId, TAction.Grow( neighborNode.startCellId, neighborNode.cell.pos.x, neighborNode.cell.pos.y, TGrow.Basic, TDir.X, '' ));
			}
		}
	}

	function getDefendCommand() {
		if( !canGrowTentacle()) return IdAction.NOT_POSSIBLE;
		resetVisited();
		for( oppCell in oppMoves ) {
			// printErr( 'check oppCell ${oppCell.pos} with neighbors ' + [for( neighbor in oppCell.neighbors ) '${neighbor.pos}'].join( " " ));
			for( neighbor in oppCell.neighbors ) {
				if(
					visited[neighbor.pos.y][neighbor.pos.x] ||
					neighbor.owner != NO_OWNER ||
					neighbor.type == TCell.Wall  ||
					checkForFrontOfTentacle( neighbor, ME ) ||
					checkForFrontOfTentacle( neighbor, OPP )
				) continue;
				// printErr( 'check neighbor ${neighbor.pos}' );
				
				visited[neighbor.pos.y][neighbor.pos.x] = true;
				for( neighborsNeighbor in neighbor.neighbors ) {
					if(
						visited[neighborsNeighbor.pos.y][neighborsNeighbor.pos.x] ||
						neighborsNeighbor.owner != NO_OWNER ||
						neighborsNeighbor.type == TCell.Wall  ||
						checkForFrontOfTentacle( neighborsNeighbor, ME ) ||
						checkForFrontOfTentacle( neighborsNeighbor, OPP )
					) continue;
					// printErr( 'check neighbors neighbor ${neighborsNeighbor.pos}, owner: ${neighborsNeighbor.owner}' );
					
					visited[neighborsNeighbor.pos.y][neighborsNeighbor.pos.x] = true;
					if( neighborsNeighbor.owner == ME ) {
						printErr( 'attack ${oppCell.pos} from my cell ${neighborsNeighbor.pos}' );
						final pathNode = findPath( neighborsNeighbor, oppCell );
						if( pathNode == Node.NO_NODE ) return IdAction.NOT_POSSIBLE;
						
						final attackNode = pathNode.parent;
						final attackPos = attackNode.cell.pos;
						final attackDirection = getDirection( attackPos, oppCell.pos );
						
						nodePool.addNodeHerarchy( pathNode );
						return new IdAction( attackNode.rootId, TAction.Grow( attackNode.startCellId, attackPos.x, attackPos.y, TGrow.Tentacle, attackDirection, '' ));
					}
				}
			}
		}

		return IdAction.NOT_POSSIBLE;
	}

	function getGrowCommand() {
		for( i in -myBorderCells.length + 1...1 ) {
			final cell = myBorderCells[-i];
			for( neighbor in cell.neighbors ) {
				if( borderCellNeighborTypes.exists( neighbor.type ) && !harvestedProteins[neighbor.pos] && !checkForFrontOfTentacle( neighbor, OPP )) {
					return new IdAction( cell.organRootId, TAction.Grow( cell.organId, neighbor.pos.x, neighbor.pos.y, TGrow.Basic, TDir.X, "" ));
				}
			}
		}
		
		return return IdAction.NOT_POSSIBLE;
	}

	function getHarvestCommand( harvestType:TCell ) {
		final nodes = findPathsToProteins( harvestType );
		if( nodes.length == 0 ) {
			return return IdAction.NOT_POSSIBLE;
		} else {
			ArraySort.sort( nodes, ( a, b ) -> {
				if( a.distance < b.distance ) return -1;
				if( a.distance > b.distance ) return 1;
				return 0;
			});

			final node = nodes[0];
			// printErr( 'getHarvestCommand ${Type.toString( harvestType )}, node: ${node.cell.pos}, distance: ${node.distance}' );
			if( node.distance == 2 ) {
				final harvesterNode = node.parent;
				final harvesterPos = harvesterNode.cell.pos;
				final havesterDirection = getDirection( harvesterPos, node.cell.pos );
				
				nodePool.addNodesHierarchy( nodes );
				if( canGrowHarvester()) {
					return new IdAction( node.rootId, TAction.Grow( harvesterNode.startCellId, harvesterPos.x, harvesterPos.y, TGrow.Harvester, havesterDirection, "" ));
				} else return IdAction.NOT_POSSIBLE;

			} else {
				final neighborNode = backtrack( node );
				// printErr( 'backtrack node: ${neighborNode.cell.pos}' );
				nodePool.addNodesHierarchy( nodes );
				return new IdAction( node.rootId, TAction.Grow( neighborNode.startCellId, neighborNode.cell.pos.x, neighborNode.cell.pos.y, TGrow.Basic, TDir.X, '' ));
			}
		}
	}

	inline function initBorderCells() {
		// final bc = [for( cell in myCells ) '${cell.pos}'].join(" ");
		myBorderCells.splice( 0, myBorderCells.length );
		for( i in -myCells.length + 1...1 ) {
			final cell = myCells[-i];
			final neighbors = cell.neighbors;
			for( neighbor in neighbors ) {
				if( borderCellNeighborTypes.exists( neighbor.type ) && !harvestedProteins[neighbor.pos] ) {
					myBorderCells.push( cell );
					break;
				}
			}
		}
		// final bc = [for( cell in myBorderCells ) '${cell.pos}'].join(" ");
		// printErr( 'border cells: $bc' );
	}

	inline function initHarvestedProteinTypes() {
		for( type => count in income ) income[type] = 0;
		
		for( pos in harvestedProteins.keys() ) {
			final proteinCell = cells[pos];
			income[proteinCell.type]++;
		}
		// for( type => count in income ) printErr( 'type: $type, count: $count' );
	}

	function findPathsToProteins( type:TCell, owner = NO_OWNER ) {
		resetVisited();

		final nodes = [];
		final frontier = new MinPriorityQueue<Node>( Node.compare );
		for( cell in myBorderCells ) {
			final startNode = nodePool.get( cell.organRootId, cell.organId, cell, cell.type, cell.organDir, a, b, c, d );
			frontier.insert( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.delMin();
			final currentCell = currentNode.cell;
			// printErr( 'currentNode pos: ${currentNode.cell.pos}' );

			if( currentCell.type == type && currentCell.owner == owner && currentNode.distance > 1 ) {
				nodes.push( currentNode );
				// printErr( 'protein ${Type.toString( type )} found at ${currentNode.cell.pos}' );
			}
			
			final nextDistance = currentNode.distance + 1;
			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				// printErr( 'neighbor type: ${Type.toString( neighbor.type )}, pos: ${neighbor.pos}, nextDistance: $nextDistance' );
				if( visited[y][x] || harvestedProteins[neighbor.pos] || neighbor.owner != NO_OWNER ) continue;
				if( checkForFrontOfTentacle( neighbor, OPP )) continue;

				final dirToNeighbor = getDirection( currentNode.cell.pos, neighbor.pos );
				final tCell = TCell.Basic;
				final a1 = a - 1 + income[TCell.A];
				
				if( a1 <= 0 ) continue;
				frontier.insert( nodePool.get( currentNode.rootId, currentNode.startCellId, neighbor, TCell.Basic, dirToNeighbor, a1, b, c, d, nextDistance, currentNode ));
				visited[y][x] = true;
			}
		}
		if( nodes.length == 0 ) printErr( 'Path to ${Type.toString( type )} not found' );
		
		return nodes;
	}
	
	function findPathsToOpp() {
		resetVisited();
		
		final nodes = [];
		final frontier = new MinPriorityQueue<Node>( Node.compare );
		for( cell in myBorderCells ) {
			final startNode = nodePool.get( cell.organRootId, cell.organId, cell, cell.type, cell.organDir, a, b, c, d );
			frontier.insert( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.delMin();
			final currentCell = currentNode.cell;
			
			if( currentCell.owner == OPP ) {
				nodes.push( currentNode );
				// printErr( 'found node, type: ${currentCell.type}' );
			}
			
			final nextDistance = currentNode.distance + 1;
			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				if( visited[y][x] || harvestedProteins[neighbor.pos] || neighbor.owner == ME ) continue;
				if( neighbor.owner == OPP && nextDistance == 1 ) continue;
				if( checkForFrontOfTentacle( neighbor, OPP )) continue;
				
				final dirToNeighbor = getDirection( currentNode.cell.pos, neighbor.pos );
				final tCell = TCell.Basic;
				final nextA = a - 1 + income[TCell.A];

				frontier.insert( nodePool.get( currentNode.rootId, currentNode.startCellId, neighbor, tCell, dirToNeighbor, a, b, c, d, nextDistance, currentNode ));
				visited[y][x] = true;
			}
		}
		
		if( nodes.length == 0 ) printErr( 'Path to Opp not found' );

		return nodes;
	}
	
	function findPath( start:Cell, end:Cell ) {
		resetVisited();

		final frontier = new MinPriorityQueue<Node>( Node.compare );
		final startNode = nodePool.get( start.organRootId, start.organId, start, start.type, start.organDir, a, b, c, d );
		frontier.insert( startNode );
		
		while( !frontier.isEmpty() ) {
			final currentNode = frontier.delMin();
			final currentCell = currentNode.cell;
			// printErr( 'currentNode pos: ${currentNode.cell.pos}' );
			if( currentCell == end ) return currentNode;
			
			final nextDistance = currentNode.distance + 1;
			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				if( visited[y][x] || harvestedProteins[neighbor.pos] || neighbor.owner == ME ) continue;
				if( checkForFrontOfTentacle( neighbor, OPP )) continue;
				
				final dirToNeighbor = getDirection( currentNode.cell.pos, neighbor.pos );
				final tCell = TCell.Basic;
				final nextA = a - 1 + income[TCell.A];
				
				frontier.insert( nodePool.get( currentNode.rootId, currentNode.startCellId, neighbor, tCell, dirToNeighbor, nextDistance, a, b, c, d, currentNode ));
				visited[y][x] = true;
			}
		}
		printErr( 'Path from ${start.pos} to ${end.pos} not found' );
		return Node.NO_NODE;
	}

	function checkForFrontOfTentacle( cell:Cell, owner:Int ) {
		if( isInFrontOfTentacles[owner].exists( cell.pos )) return true;
		for( neighbor in cell.neighbors ) {
			if( neighbor.owner == OPP && neighbor.type == TCell.Tentacle ) {
				final dir = getDirection( neighbor.pos, cell.pos );
				if( dir == neighbor.organDir ) {
					isInFrontOfTentacles[owner].set( cell.pos, true );
					return true;
				}
			}
		}
		return false;
	}

	function backtrack( node:Node, to = 1 ) {
		if( node.distance < to ) throw 'ERROR: node.distance < to';
		if( node.distance == to ) return node;
		var tempNode = node;
		while( tempNode.distance > to ) {
			tempNode = tempNode.parent;
			// printErr( 'backtrack tempNode: ${tempNode.cell.pos}, distance: ${tempNode.distance}, type: ${Type.toString( tempNode.cell.type )}' );
		}

		return tempNode;
	}

	function getDirection( pos1:Pos, pos2:Pos ) {
		if( pos1.y < pos2.y ) return TDir.S;
		if( pos1.x < pos2.x ) return TDir.E;
		if( pos1.y > pos2.y ) return TDir.N;
		if( pos1.x > pos2.x ) return TDir.W;
		return TDir.X;
	}

	function resetVisited() for( y in 0...height ) for( x in 0...width ) visited[y][x] = false;

	function getNodesPositions( nodes:Array<Node> ) {
		final positions = [];
		for( node in nodes ) {
			final posRow = [];
			var tempNode = node;
			while( tempNode != null ) {
				posRow.push( tempNode.cell.pos );
				tempNode = tempNode.parent;
			}
			positions.push( posRow );
		}
		return positions.map( posRow -> posRow.join( "," )).join( "\n" );
	}

	inline function canGrowBasic() return a > 0 ? true : false;
	inline function canGrowHarvester() return c > 0 && d > 0 ? true : false;
	inline function canGrowTentacle() return b > 0 && c > 0 ? true : false;
	inline function canGrowSporer() return b > 0 && d > 0 ? true : false;
	inline function canGrowRoot() return a > 0 && b > 0 && c > 0 && d > 0 ? true : false;

}