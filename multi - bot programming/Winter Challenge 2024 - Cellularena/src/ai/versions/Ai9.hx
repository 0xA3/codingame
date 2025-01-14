package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.contexts.CellType;
import ai.contexts.OutputTCell.output;
import ai.contexts.OutputTCell;
import ai.contexts.OutputTDir;
import ai.data.Cell;
import ai.data.IdAction;
import ai.data.Maximum;
import ai.data.Node;
import ai.data.NodePool;
import ai.data.OrganCosts;
import ai.data.TAction;
import ai.data.TCell;
import ai.data.TDir;
import ai.data.TState;
// import algorithm.MinPriorityQueue;
import haxe.ds.ArraySort;
import xa3.math.Pos;

using Lambda;
using xa3.MathUtils;

class Ai9 {
	
	static inline var ME = 1;
	static inline var OPP = 0;
	static inline var NO_OWNER = -1;

	public var aiId = "Ai9 add sporer";

	final states = [Defend, HarvestA, HarvestB, HarvestC, Attack, HarvestD, Grow, TState.Wait];
	final states2 = [Defend, HarvestA, HarvestB, HarvestC, HarvestD, Attack, Grow, TState.Wait];
	
	final proteinCellTypes = [TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];
	final borderCellNeighborTypes = [TCell.Empty => true, TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];
	final bestOrganOrder = [TCell.Basic, TCell.Sporer, TCell.Harvester, TCell.Tentacle];
	final organCosts = [
		TCell.Basic => new OrganCosts( 1, 0, 0, 0 ),
		TCell.Sporer => new OrganCosts( 0, 1, 0, 1 ),
		TCell.Harvester => new OrganCosts( 0, 0, 1, 1 ),
		TCell.Tentacle => new OrganCosts( 0, 1, 1, 0 ),
		TCell.Root => new OrganCosts( 1, 1, 1, 1 ),
		TCell.NoCell => new OrganCosts( 0, 0, 0, 0 )
	];

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
	// var actionsNum = 0;
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
		for( i in 0...myRootIds.length ) {
			final rootId = myRootIds[i];
			final statesList = i == 0 ? states : states2;
			var idAction = IdAction.NOT_POSSIBLE;
			for( state in statesList ) {
				printErr( 'rootId: $rootId, check: $state' );
				switch( state ) {
					case Attack: idAction = getAttackCommand( rootId );
					case Defend: idAction = getDefendCommand( rootId );
					case Grow: idAction = getGrowCommand( rootId );
					case HarvestA: if( income[TCell.A] == 0 ) idAction = getHarvestCommand( rootId, TCell.A);
					case HarvestB: if( income[TCell.B] == 0 ) idAction = getHarvestCommand( rootId, TCell.B );
					case HarvestC: if( income[TCell.C] == 0 ) idAction = getHarvestCommand( rootId, TCell.C );
					case HarvestD: if( income[TCell.D] == 0 ) idAction = getHarvestCommand( rootId, TCell.D );
					case Wait: // no-op
				}
					
				// printErr( 'idAction $idAction' );
				final action = idAction.action;
				if( action != TAction.NotPossible ) {
					final rootId = idAction.rootId;
					if( !actions.exists( rootId )) actions.set( rootId, action );
					consumeProteins( action );
					break;
				}
			}
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
	
	function consumeProteins( action:TAction ) {
		final cost = switch action {
			case Grow( _, _, _, type, _, _ ): organCosts[type];
			case Spore( _, _, _, _ ): organCosts[TCell.Root];
			default: organCosts[TCell.NoCell];
		}
		a -= cost.a;
		b -= cost.b;
		c -= cost.c;
		d -= cost.d;
	}

	function getAttackCommand( rootId:Int ) {
		if( !canGrowTentacle()) return IdAction.NOT_POSSIBLE;
		
		final nodes = findPathsToOpp();
		// printErr( 'nodes positions:\n${getNodesPositions( nodes )}' );
		if( nodes.length == 0 ) {
			return return IdAction.NOT_POSSIBLE;
		} else {
			// if( canGrowOrgans( TCell.Sporer, TCell.Root )) {
				final sporerNode = createSporerNode( nodes );
				if( sporerNode != Node.NO_NODE ) nodes.unshift( sporerNode );
			// }

			ArraySort.sort( nodes, ( a, b ) -> {
				if( a.rootId != rootId ) return 1;
				if( b.rootId != rootId ) return -1;
				if( a.distance < b.distance ) return -1;
				if( a.distance > b.distance ) return 1;
				return 0;
			});

			final node = nodes[0];
			if( node.a < 0 || node.b < 0 || node.c < 0 || node.d < 0 ) {
				printErr( 'Attack not possible' );
				return IdAction.NOT_POSSIBLE;
			}

			// printErr( 'attack ${node.cell.pos}, distance: ${node.distance}, type: ${CellType.toString( node.cell.type )}' );
			if( node.distance < 5 ) {
				final attackDirectionNode = backtrack( node, 2 );
				final attackNode = attackDirectionNode.parent;
				// printErr( 'attackNode: ${attackNode.cell.pos}, distance: ${attackNode.distance}, type: ${CellType.toString( attackNode.cell.type )}' );
				final attackPos = attackNode.cell.pos;
				// printErr( 'grow tentacle at $attackPos' );
				
				final attackDirection = getDirection( attackPos, attackDirectionNode.cell.pos );
				
				nodePool.addNodesHierarchy( nodes );
				return new IdAction( node.rootId, TAction.Grow( attackNode.startCellId, attackPos.x, attackPos.y, TCell.Tentacle, attackDirection, "" ));
			} else {
				final node2 = backtrack( node, 2 );
				// printErr( 'node2: ${node2.cell.pos}, distance: ${node2.distance}, type: ${CellType.toString( node2.tCell )}' );
				final nextNode = node2.parent;
				// printErr( 'nextNode: ${nextNode.cell.pos}, distance: ${nextNode.distance}, type: ${CellType.toString( nextNode.tCell )}' );
				
				nodePool.addNodesHierarchy( nodes );
				if( nextNode.tCell == TCell.Root ) {
					return new IdAction( node.rootId, TAction.Spore( nextNode.startCellId, node2.cell.pos.x, node2.cell.pos.y, '' ));
				} else {
					return growWithNeighborProteinCheck( node.rootId, node.startCellId, nextNode.cell, nextNode.tCell, node2.dirToCell );
				}
			}
		}
	}

	function getDefendCommand( rootId:Int ) {
		if( !canGrowTentacle()) return IdAction.NOT_POSSIBLE;
		resetVisited();
		for( oppCell in oppMoves ) {
			// printErr( 'check oppCell ${oppCell.pos} with neighbors ' + [for( neighbor in oppCell.neighbors ) '${neighbor.pos}'].join( " " ));
			for( neighbor in oppCell.neighbors ) {
				if(
					visited[neighbor.pos.y][neighbor.pos.x] ||
					// neighbor.owner == OPP ||
					// neighbor.type == TCell.Wall  ||
					checkForFrontOfTentacle( neighbor, ME ) ||
					checkForFrontOfTentacle( neighbor, OPP )
				) continue;
				// printErr( 'check neighbors of ${neighbor.pos}' );
				
				visited[neighbor.pos.y][neighbor.pos.x] = true;
				for( neighborsNeighbor in neighbor.neighbors ) {
					// printErr( 'check neighbors neighbor ${neighborsNeighbor.pos}, owner: ${neighborsNeighbor.owner}' );
					if(
						visited[neighborsNeighbor.pos.y][neighborsNeighbor.pos.x] ||
						// neighborsNeighbor.owner == OPP ||
						// neighborsNeighbor.type == TCell.Wall  ||
						checkForFrontOfTentacle( neighborsNeighbor, ME ) ||
						checkForFrontOfTentacle( neighborsNeighbor, OPP )
					) continue;
					
					visited[neighborsNeighbor.pos.y][neighborsNeighbor.pos.x] = true;
					if( neighborsNeighbor.owner == ME && neighborsNeighbor.organRootId == rootId ) {
						// printErr( 'attack ${oppCell.pos} from my cell ${neighborsNeighbor.pos}' );
						final pathNode = findPath( neighborsNeighbor, oppCell );
						if( pathNode == Node.NO_NODE ) return IdAction.NOT_POSSIBLE;
						
						final attackNode = pathNode.parent;
						final attackPos = attackNode.cell.pos;
						final attackDirection = getDirection( attackPos, oppCell.pos );
						
						nodePool.addNodeHerarchy( pathNode );
						return new IdAction( attackNode.rootId, TAction.Grow( attackNode.startCellId, attackPos.x, attackPos.y, TCell.Tentacle, attackDirection, '' ));
					}
				}
			}
		}

		return IdAction.NOT_POSSIBLE;
	}

	function getGrowCommand( rootId:Int ) {
		for( i in -myBorderCells.length + 1...1 ) {
			final cell = myBorderCells[-i];
			if( cell.organRootId != rootId ) continue;
			for( neighbor in cell.neighbors ) {
				if( borderCellNeighborTypes.exists( neighbor.type ) && !harvestedProteins[neighbor.pos] && !checkForFrontOfTentacle( neighbor, OPP )) {
					return new IdAction( cell.organRootId, TAction.Grow( cell.organId, neighbor.pos.x, neighbor.pos.y, TCell.Basic, TDir.X, "" ));
				}
			}
		}
		
		return return IdAction.NOT_POSSIBLE;
	}

	function getHarvestCommand( rootId:Int, harvestType:TCell ) {
		final nodes = findPathsToProteins( harvestType );
		if( nodes.length == 0 ) {
			return return IdAction.NOT_POSSIBLE;
		} else {
			if( canGrowOrgans( [TCell.Root, TCell.Harvester] )) {
				final sporerNode = createSporerNode( nodes );
				if( sporerNode != Node.NO_NODE ) nodes.unshift( sporerNode );
			}

			ArraySort.sort( nodes, ( a, b ) -> {
				if( a.rootId != rootId ) return 1;
				if( b.rootId != rootId ) return -1;
				if( a.distance < b.distance ) return -1;
				if( a.distance > b.distance ) return 1;
				return 0;
			});

			final node = nodes[0];
			
			// printErr( 'harvest cell ${CellType.toString( harvestType )}, pos: ${node.cell.pos}, distance: ${node.distance}' );
			if( node.distance == 2 ) {
				final harvesterNode = node.parent;
				final harvesterPos = harvesterNode.cell.pos;
				// printErr( 'harvesterPos: ${harvesterPos}, harvesterType: ${CellType.toString( harvesterNode.tCell )}, havesterDirection: ${OutputTDir.toString( node.dirToCell )}' );
				nodePool.addNodesHierarchy( nodes );
				if( canGrowHarvester()) {
					return new IdAction( node.rootId, TAction.Grow( harvesterNode.startCellId, harvesterPos.x, harvesterPos.y, harvesterNode.tCell, node.dirToCell, "" ));
				} else return IdAction.NOT_POSSIBLE;

			} else {
				final node2 = backtrack( node, 2 );
				// printErr( 'node2: ${node2.cell.pos}, distance: ${node2.distance}, type: ${CellType.toString( node2.tCell )}' );
				final nextNode = node2.parent;
				// printErr( 'nextNode: ${nextNode.cell.pos}, distance: ${nextNode.distance}, type: ${CellType.toString( nextNode.tCell )}' );
				// printErr( 'grow ${OutputTCell.output( nextNode.tCell )} direction: ${OutputTDir.toString( node2.dirToCell )}, pos: ${nextNode.cell.pos}' );
				
				nodePool.addNodesHierarchy( nodes );
				if( nextNode.tCell == TCell.Root ) {
					return new IdAction( node.rootId, TAction.Spore( nextNode.startCellId, nextNode.cell.pos.x, nextNode.cell.pos.y, '' ));
				} else {
					return growWithNeighborProteinCheck( node.rootId, node.startCellId, nextNode.cell, nextNode.tCell, node2.dirToCell );
				}
			}
		}
	}

	function growWithNeighborProteinCheck( rootId:Int, startCellId:Int, cell:Cell, type:TCell, direction:TDir ) {
		// printErr( 'neighborPositions: ' + [for( neighbor in cell.neighbors ) neighbor.pos].join(" "));
		if( canGrowHarvester( 2 )) {
			for( neighbor in cell.neighbors ) {
				if( proteinCellTypes.exists( neighbor.type ) && !harvestedProteins.exists( neighbor.pos )) {
					final neighborDirection = getDirection( cell.pos, neighbor.pos );
					// printErr( 'neighbor protein at ${neighbor.pos} direction ${neighborDirection}' );
					if( neighborDirection != direction ) {
						// printErr( 'found neighbor protein at ${neighbor.pos}' );
						return new IdAction( rootId, TAction.Grow( startCellId, cell.pos.x, cell.pos.y, TCell.Harvester, neighborDirection, '' ));
					}
				}
			}
		}
		return new IdAction( rootId, TAction.Grow( startCellId, cell.pos.x, cell.pos.y, type, direction, '' ));
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
		// final frontier = new MinPriorityQueue<Node>( Node.compare );
		final frontier = new List<Node>();
		for( cell in myBorderCells ) {
			final startNode = nodePool.get( cell.organRootId, cell.organId, cell, cell.type, TDir.X, 0, a, b, c, d );
			frontier.add( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentCell = currentNode.cell;
			// printErr( 'currentNode pos: ${currentNode.cell.pos}, type: ${CellType.toString( currentNode.tCell )}, distance: ${currentNode.distance}' );

			if( currentCell.type == type && currentCell.owner == owner && currentNode.distance > 1 ) {
				if( currentNode.parent != null ) {
					// printErr( 'parent ${currentNode.parent.cell.pos} tCell ${CellType.toString( currentNode.parent.tCell )}' );
					currentNode.parent.refund( organCosts[currentNode.parent.tCell] );
					currentNode.parent.tCell = TCell.Harvester;
					currentNode.parent.pay( organCosts[TCell.Harvester] );
					currentNode.copyProteinsFrom( currentNode.parent );
				}
				
				nodes.push( currentNode );
				// printErr( 'protein ${CellType.toString( type )} found at ${currentNode.cell.pos}, distance: ${currentNode.distance}' );
			}
			
			final nextDistance = currentNode.distance + 1;
			final straightLinePos = getStraightLinePos( currentNode.cell.pos, currentNode.dirToCell );
			currentCell.neighbors.sort(( a, b ) -> {
				if( a.pos == straightLinePos ) return -1;
				if( b.pos == straightLinePos ) return 1;
				return 0;
			});

			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				// printErr( 'neighbor type: ${CellType.toString( neighbor.type )}, pos: ${neighbor.pos}, nextDistance: $nextDistance' );
				if( visited[y][x] || harvestedProteins[neighbor.pos] || neighbor.owner != NO_OWNER ) continue;
				if( checkForFrontOfTentacle( neighbor, OPP )) continue;

				final dirToCell = getDirection( currentNode.cell.pos, neighbor.pos );
				final dirCount = currentNode.dirToCell == dirToCell ? currentNode.dirCount + 1 : 1;
				final bestOrgan = getBestOrgan( currentNode.a, currentNode.b, currentNode.c, currentNode.d );
				// printErr( 'bestOrgan: ${CellType.toString( bestOrgan )}' );
				// if( bestOrgan == TCell.NoCell ) continue;

				final organCost = organCosts[bestOrgan];
				final a1 = currentNode.a - organCost.a + income[A] * nextDistance;
				final b1 = currentNode.b - organCost.b + income[B] * nextDistance;
				final c1 = currentNode.c - organCost.c + income[C] * nextDistance;
				final d1 = currentNode.d - organCost.d + income[D] * nextDistance;
				frontier.add( nodePool.get( currentNode.rootId, currentNode.startCellId, neighbor, bestOrgan, dirToCell, dirCount, a1, b1, c1, d1, nextDistance, currentNode ));
				visited[y][x] = true;
			}
		}
		if( nodes.length == 0 ) printErr( 'Path to ${CellType.toString( type )} not found' );
		
		return nodes;
	}
	
	function findPathsToOpp() {
		resetVisited();
		
		final nodes = [];
		// final frontier = new MinPriorityQueue<Node>( Node.compare );
		final frontier = new List<Node>();
		for( cell in myBorderCells ) {
			final startNode = nodePool.get( cell.organRootId, cell.organId, cell, cell.type, TDir.X, 0, a, b, c, d );
			frontier.add( startNode );
			// printErr( 'startNode pos: ${startNode.cell.pos}' );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentCell = currentNode.cell;
			
			if( currentCell.owner == OPP ) {
				if( currentNode.parent != null ) {
					currentNode.parent.refund( organCosts[currentNode.parent.tCell] );
					currentNode.parent.tCell = TCell.Tentacle;
					currentNode.parent.pay( organCosts[TCell.Tentacle] );
					currentNode.copyProteinsFrom( currentNode.parent );
				}
				currentNode.dirCount = 0;
				nodes.push( currentNode );
				// printErr( 'opp cell ${CellType.toString( currentCell.type )} found at ${currentNode.cell.pos}, distance: ${currentNode.distance}' );
			}
			
			final nextDistance = currentNode.distance + 1;
			
			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				if( visited[y][x] || harvestedProteins[neighbor.pos] || neighbor.owner == ME ) continue;
				if( neighbor.owner == OPP && nextDistance == 1 ) continue;
				if( checkForFrontOfTentacle( neighbor, OPP )) continue;
				
				final dirToCell = getDirection( currentNode.cell.pos, neighbor.pos );
				final dirCount = currentNode.dirToCell == dirToCell ? currentNode.dirCount + 1 : 1;
				// final bestOrgan = getBestOrgan( currentNode.a, currentNode.b, currentNode.c, currentNode.d );
				final bestOrgan = TCell.Basic;
				// printErr( 'bestOrgan: ${CellType.toString( bestOrgan )}' );
				// if( bestOrgan == TCell.NoCell ) continue;

				final organCost = organCosts[bestOrgan];
				final a1 = currentNode.a - organCost.a + income[A] * nextDistance;
				final b1 = currentNode.b - organCost.b + income[B] * nextDistance;
				final c1 = currentNode.c - organCost.c + income[C] * nextDistance;
				final d1 = currentNode.d - organCost.d + income[D] * nextDistance;
				frontier.add( nodePool.get( currentNode.rootId, currentNode.startCellId, neighbor, bestOrgan, dirToCell, dirCount, a1, b1, c1, d1, nextDistance, currentNode ));
				visited[y][x] = true;
			}
		}
		
		if( nodes.length == 0 ) printErr( 'Path to Opp not found' );

		return nodes;
	}
	
	function findPath( start:Cell, end:Cell ) {
		resetVisited();

		final frontier = new List<Node>();
		final startNode = nodePool.get( start.organRootId, start.organId, start, start.type, start.organDir, 0, a, b, c, d );
		frontier.add( startNode );
		
		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentCell = currentNode.cell;
			// printErr( 'currentNode pos: ${currentNode.cell.pos}' );
			if( currentCell == end ) return currentNode;
			
			final nextDistance = currentNode.distance + 1;
			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				if( visited[y][x] || harvestedProteins[neighbor.pos] || neighbor.owner == ME ) continue;
				if( checkForFrontOfTentacle( neighbor, OPP )) continue;
				
				final dirToCell = getDirection( currentNode.cell.pos, neighbor.pos );
				final tCell = TCell.Basic;
				
				frontier.add( nodePool.get( currentNode.rootId, currentNode.startCellId, neighbor, tCell, dirToCell, 0, a, b, c, d, nextDistance, currentNode ));
				visited[y][x] = true;
			}
		}
		printErr( 'Path from ${start.pos} to ${end.pos} not found' );
		return Node.NO_NODE;
	}

	function checkForFrontOfTentacle( cell:Cell, owner:Int ) {
		if( isInFrontOfTentacles[owner].exists( cell.pos )) return true;
		for( neighbor in cell.neighbors ) {
			if( neighbor.owner == owner && neighbor.type == TCell.Tentacle ) {
				final dir = getDirection( neighbor.pos, cell.pos );
				if( dir == neighbor.organDir ) {
					isInFrontOfTentacles[owner].set( cell.pos, true );
					return true;
				}
			}
		}
		return false;
	}
	
	function createSporerNode( nodes:Array<Node> ) {
		final maxDirCountNodes = [];
		for( node in nodes ) {
			final firstMaxDirCount = getFirstMaxDirCount( node );
			if( firstMaxDirCount != Maximum.NO_MAXIMUM ) maxDirCountNodes.push({ node: node, firstMax: firstMaxDirCount.max, index:firstMaxDirCount.index });
		}

		ArraySort.sort( maxDirCountNodes, ( a, b ) -> {
			final deltaA = a.node.distance - a.firstMax;
			final deltaB = b.node.distance - b.firstMax;
			if( deltaA < deltaB ) return -1;	// sort for smaller delta
			if( deltaA > deltaB ) return 1;
			if( a.node.distance > b.node.distance ) return -1; // sort for larger distance
			if( a.node.distance < b.node.distance ) return 1;
			if( a.index < b.index ) return -1;	// sort for smaller index
			if( a.index > b.index ) return 1;
			return 0;
		});

		// for( maxDirCountNode in maxDirCountNodes ) {
			// printErr( 'createSporerNode: ${maxDirCountNode.node.cell.pos} distance: ${maxDirCountNode.node.distance} max ${maxDirCountNode.firstMax} index ${maxDirCountNode.index}  delta ${maxDirCountNode.node.distance - maxDirCountNode.firstMax}' );
		// }

		if( maxDirCountNodes.length == 0 ) return Node.NO_NODE;
		
		final firstMaxDirCountNode = maxDirCountNodes[0];
		final sporerNode = createSporerPath( firstMaxDirCountNode.node, firstMaxDirCountNode.index, firstMaxDirCountNode.firstMax );
		
		return sporerNode;
	}

	function getFirstMaxDirCount( node:Node ) {
		// printErr( 'getFirstMaxDirCount of node ${node.cell.pos}' );
		final maximums:Array<Maximum> = [];
		var tempNode = node;
		final minCount = tempNode.tCell == TCell.Sporer ? 3 : 4;
		var dirCount = 0;
		// var positions = [];
		while( tempNode != null ) {
			// printErr( 'tempNode pos: ${tempNode.cell.pos} distance ${tempNode.distance} dirCount: ${tempNode.dirCount}' );
			if( tempNode.dirCount > dirCount && tempNode.dirCount >= minCount ) {
				// printErr( 'push max ${tempNode.dirCount} index ${tempNode.distance}' );
				maximums.push( new Maximum( tempNode.dirCount, tempNode.distance ));
			}
			// positions.push( tempNode.cell.pos );
			dirCount = tempNode.dirCount;
			tempNode = tempNode.parent;
		}
		maximums.reverse();
		// positions.reverse();
		// printErr( 'node positions ' + positions.join(" ") );
		if( maximums.length == 0 ) return Maximum.NO_MAXIMUM;
		final firstIndex = maximums[0].index;
		final fistMax = maximums[0].max;
		final maxDirStartIndex = firstIndex - fistMax;
		
		// printErr( 'cell ${node.cell.pos} maxDirStartIndex: $maxDirStartIndex' );
		if( maxDirStartIndex > 2 ) return Maximum.NO_MAXIMUM; // too far in the future
		
		return maximums[0];
	}

	function createSporerPath( node:Node, firstMaxIndex:Int, firstMaxValue:Int ) {
		final path = unfoldNode( node );
		// printErr( 'path ' + [for( pathNode in path ) pathNode.cell.pos].join( " " ));
		// for( pathNode in path ) printErr( 'pathNode: ${pathNode.cell.pos}, distance: ${pathNode.distance}, dirCount: ${pathNode.dirCount}' );
		
		final lineStart = firstMaxIndex - firstMaxValue;
		if( lineStart < 0 ) throw 'ERROR: lineStart < 0';
		final lineStartCell = path[lineStart].cell;
		// printErr( 'lineStart: $lineStart, pos: ${lineStartCell.pos}, type: ${CellType.toString( lineStartCell.type )}' );
		var lineStartIndex = 0;
		switch( lineStartCell.type ) {
			case TCell.Sporer:
				// printErr( 'Sporer is already built. canGrowRoot ${canGrowRoot()}' );
				if( !canGrowRoot() ) return Node.NO_NODE;
			case TCell.Empty, TCell.A, TCell.B, TCell.C, TCell.D:
				// printErr( 'build on line start after corner' );
				if( !canGrowOrgans( [TCell.Sporer, TCell.Root] )) return Node.NO_NODE;
				path[lineStartIndex].tCell = TCell.Sporer;
			default:
				// printErr( 'lineStart contains cell of type: ${CellType.toString( lineStartCell.type )}' );
				if( !canGrowOrgans( [TCell.Sporer, TCell.Root] )) return Node.NO_NODE;
				lineStartIndex = 1;
				path[lineStartIndex].tCell = TCell.Sporer;
		}

		var lineEndIndex = firstMaxIndex;
		final lineEndCell = path[lineEndIndex].cell;
		// printErr( 'lineEnd: $lineEndIndex, pos: ${lineEndCell.pos}, type: ${CellType.toString( lineEndCell.type )}' );
		// printErr( 'path length: ${path.length}' );
		final spliceStart = lineStartIndex + 1;
		var spliceEnd = 0;
		if( lineEndIndex == path.length - 1 ) {
			// printErr( 'target cell is on lineEnd' );
			spliceEnd = lineEndIndex - 3;
		} else if( lineEndIndex == path.length - 2 ) {
			// printErr( 'target cell is cell directly after lineEnd' );
			spliceEnd = lineEndIndex - 2;
		} else {
			// printErr( 'target cell is before line end' );
			spliceEnd = lineEndIndex - 2;

		}
		path.splice( spliceStart, spliceEnd );

		path[spliceStart].tCell = TCell.Root;
		
		for( i in spliceStart...path.length ) {
			final pathNode = path[i];
			pathNode.distance = path[i - 1].distance + 1;
			pathNode.parent = path[i - 1];
		}
		// printErr( 'sporer path' );
		// for( pathNode in path ) printErr( 'pathNode: ${pathNode.cell.pos}, type: ${CellType.toString( pathNode.tCell )}, distance: ${pathNode.distance}' + ( pathNode.parent == null ? '' : ', parent: ${pathNode.parent.cell.pos}' ));

		return path[path.length - 1];
	}

	function unfoldNode( node:Node ) {
		final path = [];
		var tempNode = node;
		while( tempNode != null ) {
			path.push( nodePool.getCopy( tempNode ));
			tempNode = tempNode.parent;
		}
		path.reverse();
		
		// for( i in 1...path.length ) {
			// path[i].parent = path[i - 1];
		// }

		// output //////////////////////////////////////////////
		// var positions = [];
		// for( node in listPath ) {
		// 	printErr( '$node' );
		// }
		// // printErr( 'node positions: ' + positions.join(" ") );
		////////////////////////////////////////////////////////
		return path;
	}


	function backtrack( node:Node, to = 1 ) {
		if( node.distance < to ) throw 'ERROR: node.distance < to';
		if( node.distance == to ) return node;
		var tempNode = node;
		while( tempNode.distance > to ) {
			tempNode = tempNode.parent;
			// printErr( 'backtrack tempNode: ${tempNode.cell.pos}, distance: ${tempNode.distance}, type: ${CellType.toString( tempNode.cell.type )}' );
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

	function getStraightLinePos( pos:Pos, direction:TDir ) {
		switch ( direction ) {
			case TDir.S:
				final x = pos.x;
				final y = pos.y + 1;
				if( y < height ) return positions[y][x];
			case TDir.E:
				final x = pos.x + 1;
				final y = pos.y;
				if( x < width ) return positions[y][x];
			case TDir.N:
				final x = pos.x;
				final y = pos.y - 1;
				if( y >= 0 ) return positions[y][x];
			case TDir.W:
				final x = pos.x - 1;
				final y = pos.y;
				if( x >= 0 ) return positions[y][x];
			default: return pos;
		}
		return Pos.NO_POS;
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

	function getBestOrgan( a:Int, b:Int, c:Int, d:Int ) {
		for( organType in bestOrganOrder ) {
			final costs = organCosts[organType];
			if( a >= costs.a && b >= costs.b && c >= costs.c && d >= costs.d ) return organType;
		}
		return TCell.NoCell;
	}

	function canGrowOrgans( organs:Array<TCell> ) {
		final aFunds = a + income[TCell.A];
		final aCost = organs.fold(( o, sum ) -> sum + organCosts[o].a, 0 );
		if( aFunds < aCost ) return false;

		final bFunds = b + income[TCell.B];
		final bCost = organs.fold(( o, sum ) -> sum + organCosts[o].b, 0 );
		if( bFunds < bCost ) return false;

		final cFunds = c + income[TCell.C];
		final cCost = organs.fold(( o, sum ) -> sum + organCosts[o].c, 0 );
		if( cFunds < cCost ) return false;

		final dFunds = d + income[TCell.D];
		final dCost = organs.fold(( o, sum ) -> sum + organCosts[o].d, 0 );
		if( dFunds < dCost ) return false;
		
		return true;
	}

	inline function canGrowBasic( n = 1 ) return a >= n ? true : false;
	inline function canGrowHarvester( n = 1 ) return c >= n && d >= n ? true : false;
	inline function canGrowTentacle( n = 1 ) return b >= n && c >= n ? true : false;
	inline function canGrowSporer( n = 1 ) return b >= n && d >= n ? true : false;
	inline function canGrowRoot( n = 1 ) return a >= n && b >= n && c >= n && d >= n ? true : false;

}