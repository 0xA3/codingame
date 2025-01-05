package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.contexts.CellType;
import ai.contexts.OutputTCell.output;
import ai.contexts.OutputTCell;
import ai.contexts.OutputTDir;
import ai.data.Cell;
import ai.data.IdAction;
import ai.data.Node;
import ai.data.NodePool;
import ai.data.TAction;
import ai.data.TCell;
import ai.data.TDir;
import ai.data.TState;
// import algorithm.MinPriorityQueue;
import haxe.ds.ArraySort;
import xa3.math.Pos;

using xa3.MathUtils;

class Ai9 {
	
	static inline var ME = 1;
	static inline var OPP = 0;
	static inline var NO_OWNER = -1;

	public var aiId = "Ai9 add sporer";

	final states = [Defend, HarvestA, HarvestB, HarvestC, Attack, HarvestD, Grow, TState.Wait];
	
	final proteinCellTypes = [TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];
	final borderCellNeighborTypes = [TCell.Empty => true, TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];
	final bestOrganOrder = [TCell.Basic, TCell.Sporer, TCell.Harvester, TCell.Tentacle];
	final organCosts = [
		TCell.Basic => { a: 1, b: 0, c: 0, d: 0 },
		TCell.Sporer => { a: 0, b: 1, c: 0, d: 1 },
		TCell.Harvester => { a: 0, b: 0, c: 1, d: 1 },
		TCell.Tentacle => { a: 0, b: 1, c: 1, d: 0 }
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
				return new IdAction( node.rootId, TAction.Grow( attackNode.startCellId, attackPos.x, attackPos.y, TCell.Tentacle, attackDirection, "" ));
			} else {
				final node2 = backtrack( node, 2 );
				final nextNode = node2.parent;
				
				nodePool.addNodesHierarchy( nodes );
				return growWithNeighborProteinCheck( node.rootId, node.startCellId, nextNode.cell, nextNode.tCell, node2.dirToCell );
				
				// return new IdAction( node.rootId, TAction.Grow( nextNode.startCellId, nextNode.cell.pos.x, nextNode.cell.pos.y, TCell.Basic, TDir.X, '' ));
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
						return new IdAction( attackNode.rootId, TAction.Grow( attackNode.startCellId, attackPos.x, attackPos.y, TCell.Tentacle, attackDirection, '' ));
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
					return new IdAction( cell.organRootId, TAction.Grow( cell.organId, neighbor.pos.x, neighbor.pos.y, TCell.Basic, TDir.X, "" ));
				}
			}
		}
		
		return return IdAction.NOT_POSSIBLE;
	}

	function getHarvestCommand( harvestType:TCell ) {
		final nodes = findPathsToProteins( harvestType );
		// if( turn == 1 ) unfoldNodes( nodes );
		if( nodes.length == 0 ) {
			return return IdAction.NOT_POSSIBLE;
		} else {
			ArraySort.sort( nodes, ( a, b ) -> {
				if( a.distance < b.distance ) return -1;
				if( a.distance > b.distance ) return 1;
				return 0;
			});

			final node = nodes[0];
			// printErr( 'getHarvestCommand ${Type.toString( harvestType )}, pos: ${node.cell.pos}, distance: ${node.distance}' );
			if( node.distance == 2 ) {
				final harvesterNode = node.parent;
				final harvesterPos = harvesterNode.cell.pos;
				// printErr( 'harvesterPos: ${harvesterPos}, harvesterType: ${Type.toString( harvesterNode.tCell )}, havesterDirection: ${OutputTDir.toString( node.dirToCell )}' );
				nodePool.addNodesHierarchy( nodes );
				if( canGrowHarvester()) {
					return new IdAction( node.rootId, TAction.Grow( harvesterNode.startCellId, harvesterPos.x, harvesterPos.y, harvesterNode.tCell, node.dirToCell, "" ));
				} else return IdAction.NOT_POSSIBLE;

			} else {
				final node2 = backtrack( node, 2 );
				final nextNode = node2.parent;
				printErr( 'grow ${OutputTCell.output( nextNode.tCell )} direction: ${OutputTDir.toString( node2.dirToCell )}, pos: ${nextNode.cell.pos}' );
				
				nodePool.addNodesHierarchy( nodes );
				return growWithNeighborProteinCheck( node.rootId, node.startCellId, nextNode.cell, nextNode.tCell, node2.dirToCell );
				
				// return new IdAction( node.rootId, TAction.Grow( nextNode.startCellId, nextNode.cell.pos.x, nextNode.cell.pos.y, nextNode.tCell, node2.dirToCell, '' ));
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
			final startNode = nodePool.get( cell.organRootId, cell.organId, cell, cell.type, cell.organDir, 0, a, b, c, d );
			frontier.add( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentCell = currentNode.cell;
			// printErr( 'currentNode pos: ${currentNode.cell.pos}, type: ${Type.toString( currentNode.tCell )}, distance: ${currentNode.distance}' );

			if( currentCell.type == type && currentCell.owner == owner && currentNode.distance > 1 ) {
				currentNode.tCell = type;
				currentNode.parent.tCell = TCell.Harvester;
				nodes.push( currentNode );
				printErr( 'protein ${CellType.toString( type )} found at ${currentNode.cell.pos}, distance: ${currentNode.distance}' );
				// printErr( 'build ${Type.toString( currentNode.parent.tCell )} at ${currentNode.parent.cell.pos} with direction ${OutputTDir.toString( currentNode.dirToCell )}' );
			}
			
			final nextDistance = currentNode.distance + 1;
			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				// printErr( 'neighbor type: ${Type.toString( neighbor.type )}, pos: ${neighbor.pos}, nextDistance: $nextDistance' );
				if( visited[y][x] || harvestedProteins[neighbor.pos] || neighbor.owner != NO_OWNER ) continue;
				if( checkForFrontOfTentacle( neighbor, OPP )) continue;

				final dirToCell = getDirection( currentNode.cell.pos, neighbor.pos );
				final dirCount = currentNode.dirToCell == dirToCell ? currentNode.dirCount + 1 : 1;
				final bestOrgan = getBestOrgan( currentNode.a, currentNode.b, currentNode.c, currentNode.d );
				// printErr( 'bestOrgan: ${Type.toString( bestOrgan )}' );
				if( bestOrgan == TCell.NoCell ) continue;

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
			final startNode = nodePool.get( cell.organRootId, cell.organId, cell, cell.type, cell.organDir, 0, a, b, c, d );
			frontier.add( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentCell = currentNode.cell;
			
			if( currentCell.owner == OPP ) {
				currentNode.parent.tCell = TCell.Tentacle;
				nodes.push( currentNode );
				// printErr( 'opp cell ${Type.toString( currentCell.type )} found at ${currentNode.cell.pos}, distance: ${currentNode.distance}' );
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
				final bestOrgan = getBestOrgan( currentNode.a, currentNode.b, currentNode.c, currentNode.d );
				// printErr( 'bestOrgan: ${Type.toString( bestOrgan )}' );
				if( bestOrgan == TCell.NoCell ) continue;

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

		// final frontier = new MinPriorityQueue<Node>( Node.compare );
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
				final nextA = currentNode.a - 1 + income[TCell.A];
				
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
	
	// function unfoldNodes( nodes:Array<Node> ) {
	// 	final paths = [];
	// 	for( node in nodes ) {
	// 		final listPath = new List<Node>();
	// 		var tempNode = node;
	// 		while( tempNode != null ) {
	// 			listPath.push( tempNode );
	// 			tempNode = tempNode.parent;
	// 		}
	// 		paths.push( listPath );

	// 		// output //////////////////////////////////////////////
	// 		var positions = [];
	// 		for( node in listPath ) {
	// 			positions.push( node.cell.pos );
	// 		}
	// 		printErr( 'node positions: ' + positions.join(" ") );
	// 		////////////////////////////////////////////////////////
	// 	}
	// 	return paths;
	// }

	// function createSporerPath( path:Array<Node> ) {
	// 	var maxStraightLength = 0;
	// 	var staightLength = 0;
	// 	var tempDir = TDir.X;
	// 	for( i in 1...path.length ) {
	// 		final dir = getDirection( path[i-1].cell.pos, path[i].cell.pos );
	// 		if( dir == tempDir ) {
	// 			staightLength++;
	// 			if( staightLength > maxStraightLength ) maxStraightLength = staightLength;
	// 		} else {
	// 			tempDir = dir;
	// 			staightLength = 0;
	// 		}
	// 	}
			
	// }

	// function outputNodeHierarchy( node:Node ) {
	// 	var tempNode = node;
	// 	var positions = [];
	// 	while( tempNode != null ) {
	// 		positions.push( tempNode.cell.pos );
	// 		printErr( 'outputNodeHierarchy node: ${tempNode.cell.pos}' );
	// 		tempNode = tempNode.parent;
	// 	}
	// 	printErr( 'node positions: ' + positions.join(" ") );
	// }

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

	function getBestOrgan( a:Int, b:Int, c:Int, d:Int ) {
		for( organType in bestOrganOrder ) {
			final costs = organCosts[organType];
			if( a >= costs.a && b >= costs.b && c >= costs.c && d >= costs.d ) return organType;
		}
		return TCell.NoCell;
	}

	inline function canGrowBasic( n = 1 ) return a >= n ? true : false;
	inline function canGrowHarvester( n = 1 ) return c >= n && d >= n ? true : false;
	inline function canGrowTentacle( n = 1 ) return b >= n && c >= n ? true : false;
	inline function canGrowSporer( n = 1 ) return b >= n && d >= n ? true : false;
	inline function canGrowRoot( n = 1 ) return a >= n && b >= n && c >= n && d >= n ? true : false;

}