package ai.versions;

import CodinGame.printErr;
import ai.contexts.Action;
import ai.contexts.OutputTCell.output;
import ai.contexts.Type;
import ai.data.Cell;
import ai.data.Node;
import ai.data.NodePool;
import ai.data.TAction;
import ai.data.TCell;
import ai.data.TDir;
import ai.data.TGrow;
import ai.data.TState;
import haxe.ds.ArraySort;
import xa3.math.Pos;

using xa3.MathUtils;

class Ai6 {
	
	static inline var ME = 1;
	static inline var OPP = 0;
	static inline var NO_OWNER = -1;

	public var aiId = "Ai5 harvest, grow and attack";

	final states = [Defend, HarvestA, HarvestB, HarvestC, Attack, HarvestD, Grow, TState.Wait];
	
	final proteinCellTypes = [TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];
	final borderCellNeighborTypes = [TCell.Empty => true, TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];

	var positions:Array<Array<Pos>>;
	var cells:Map<Pos, Cell>;
	var width:Int;
	var height:Int;

	var requiredActionsCount:Int;
	var entities:Array<Cell>;
	var myCells:Map<Int, Array<Cell>>;
	var myRoots:Array<Cell>;
	var harvestedProteins:Map<Pos, Bool>;
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
	final myBorderCells:Map<Int, Array<Cell>> = [];
	final harvestedProteinTypes = [TCell.A => 0, TCell.B => 0, TCell.C => 0, TCell.D => 0];

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
		myRoots:Array<Cell>,
		myCells:Map<Int, Array<Cell>>,
		harvestedProteins:Map<Pos, Bool>,
		oppMoves:Array<Cell>
	) {
		this.requiredActionsCount = requiredActionsCount;
		this.myRoots = myRoots;
		this.myCells = myCells;
		this.oppMoves = oppMoves;
		this.harvestedProteins = harvestedProteins;
		
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	public function process() {
		turn++;

		initBorderCells();
		initHarvestedProteinTypes();
		// for( cell in oppCells ) printErr( 'opp cells: pos: ${cell.pos}, type: ${output( cell.type )}' );
		// for( cell in myBorderCells ) printErr( 'border cells: pos: ${cell.pos}, type: ${output( cell.type )}' );

		final actions = [];
		// for( i in 0...requiredActionsCount ) {
		for( root in myRoots ) {
			final borderCells = myBorderCells[root.organId];
			if( borderCells == null ) throw 'ERROR: myBorderCells[${root.organId}] == null';
			
			stateId = 0;
			while( stateId < states.length ) {
				final state = states[stateId];
				// printErr( 'state: $state' );
				var action = TAction.NotPossible;
				switch( state ) {
					case Attack: action = getAttackCommand( root, borderCells );
					case Defend: action = getDefendCommand( root, borderCells );
					case Grow: action = getGrowCommand( root, borderCells );
					case HarvestA: if( harvestedProteinTypes[TCell.A] < myRoots.length ) {
						action = getHarvestCommand( TCell.A, root, borderCells );
					}
					case HarvestB: if( harvestedProteinTypes[TCell.B] < myRoots.length ) {
						action = getHarvestCommand( TCell.B, root, borderCells );
					}
					case HarvestC: if( harvestedProteinTypes[TCell.C] < myRoots.length ) {
						action = getHarvestCommand( TCell.C, root, borderCells );
					}
					case HarvestD: if( harvestedProteinTypes[TCell.D] < myRoots.length ) {
						action = getHarvestCommand( TCell.D, root, borderCells );
					}
					
					default: action = TAction.Wait;
				}
				if( action != TAction.NotPossible ) {
					actions.push( action );
					break;
				}
				stateId++;
			}
		}

		final outputs = actions.map( action -> Action.toString( action));

		return outputs.join( "\n" );
	}
	
	function getAttackCommand( root:Cell, borderCells:Array<Cell> ) {
		final nodes = findOppCellNodes( borderCells );
		// printErr( 'nodes positions:\n${getNodesPositions( nodes )}' );
		if( nodes.length == 0 ) {
			return TAction.NotPossible;
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
			if( node.distance < 3 ) {
				final attackNode = node.distance == 1 ? node : node.parent;
				final attackPos = attackNode.cell.pos;
				// printErr( 'grow tentacle at $attackPos' );
				
				final attackDirection = getDirection( attackPos, node.cell.pos );
				
				nodePool.addNodesHierarchy( nodes );
				return TAction.Grow( attackNode.startCellId, attackPos.x, attackPos.y, TGrow.Tentacle, attackDirection, "" );
			} else {
				final neighborNode = backtrack( node );
				
				nodePool.addNodesHierarchy( nodes );
				return TAction.Grow( neighborNode.startCellId, neighborNode.cell.pos.x, neighborNode.cell.pos.y, TGrow.Basic, TDir.X, '' );
			}
		}
	}

	function getDefendCommand( root:Cell, borderCells:Array<Cell> ) {
		for( cell in oppMoves ) {

		}

		return TAction.NotPossible;
	}

	function getGrowCommand( root:Cell, borderCells:Array<Cell> ) {
		for( i in -borderCells.length + 1...1 ) {
			final cell = borderCells[-i];
			for( neighbor in cell.neighbors ) {
				if( borderCellNeighborTypes.exists( neighbor.type ) && !harvestedProteins[neighbor.pos] ) {
					return TAction.Grow( cell.organId, neighbor.pos.x, neighbor.pos.y, TGrow.Basic, TDir.X, "" );
				}
			}
		}
		
		return TAction.NotPossible;
	}

	function getHarvestCommand( harvestType:TCell, root:Cell, borderCells:Array<Cell> ) {
		final node = findCellNode( borderCells, harvestType );
		if( node == Node.NO_NODE ) {
			return TAction.NotPossible;
		} else {
			if( node.distance == 2 ) {
				final harvesterNode = node.parent;
				final harvesterPos = harvesterNode.cell.pos;
				final havesterDirection = getDirection( harvesterPos, node.cell.pos );
				
				nodePool.addNodeHerarchy( node );
				return TAction.Grow( harvesterNode.startCellId, harvesterPos.x, harvesterPos.y, TGrow.Harvester, havesterDirection, "" );
			} else {
				final neighborNode = backtrack( node );
				
				nodePool.addNodeHerarchy( node );
				return TAction.Grow( neighborNode.startCellId, neighborNode.cell.pos.x, neighborNode.cell.pos.y, TGrow.Basic, TDir.X, '' );
			}
		}
	}

	inline function initBorderCells() {
		final bc = [for( cells in myCells ) for( cell in cells )'${cell.pos}'].join(" ");
		for( rootId => cellsOfRoot in myCells ) {
			if( !myBorderCells.exists( rootId )) myBorderCells[rootId] = [];
			final borderCells = myBorderCells[rootId];
			borderCells.splice( 0, borderCells.length );
	
			for( i in -cellsOfRoot.length + 1...1 ) {
				final cell = cellsOfRoot[-i];
				final neighbors = cell.neighbors;
				for( neighbor in neighbors ) {
					if( borderCellNeighborTypes.exists( neighbor.type ) && !harvestedProteins[neighbor.pos] ) {
						borderCells.push( cell );
						break;
					}
				}
			}
			final bc = [for( cell in borderCells ) '${cell.pos}'].join(" ");
			printErr( 'border cells: $bc' );
		}
	}

	inline function initHarvestedProteinTypes() {
		for( type => count in harvestedProteinTypes ) harvestedProteinTypes[type] = 0;
		
		for( pos in harvestedProteins.keys() ) {
			final proteinCell = cells[pos];
			harvestedProteinTypes[proteinCell.type]++;
		}
		// for( type => count in harvestedProteinTypes ) printErr( 'type: $type, count: $count' );
	}

	function findCellNode( borderCells:Array<Cell>, type:TCell, owner = NO_OWNER ) {
		resetVisited();

		final frontier = new List<Node>();
		for( cell in borderCells ) {
			final startNode = nodePool.get( cell.organId, cell, 0 );
			frontier.add( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentCell = currentNode.cell;
			// printErr( 'currentNode pos: ${currentNode.cell.pos}' );

			if( currentCell.type == type && currentCell.owner == owner ) {
				nodePool.addNodeList( frontier );
				return currentNode;
			}
			
			final nextDistance = currentNode.distance + 1;
			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				// printErr( 'neighbor type: ${neighbor.type}, pos: ${neighbor.pos}, nextDistance: $nextDistance' );
				if( visited[y][x] || harvestedProteins[neighbor.pos] || neighbor.owner != NO_OWNER ) continue;
				if( neighbor.type == type && nextDistance == 1 ) continue;
				if( checkForFrontOfOppTentacle( neighbor )) continue;

				frontier.add( nodePool.get( currentCell.organId, neighbor, nextDistance, currentNode ));
				visited[y][x] = true;
			}
		}
		printErr( 'Node with ${Type.toString( type )} not found' );
		return Node.NO_NODE;
	}
	
	function findOppCellNodes( borderCells:Array<Cell> ) {
		resetVisited();
		
		final nodes = [];
		final frontier = new List<Node>();
		for( cell in borderCells ) {
			final startNode = nodePool.get( cell.organId, cell, 0 );
			frontier.add( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
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
				if( checkForFrontOfOppTentacle( neighbor )) continue;
				
				frontier.add( nodePool.get( currentNode.startCellId, neighbor, nextDistance, currentNode ));
				visited[y][x] = true;
			}
		}
		
		return nodes;
	}
	
	function checkForFrontOfOppTentacle( cell:Cell ) {
		for( neighbor in cell.neighbors ) {
			if( neighbor.owner == OPP && neighbor.type == TCell.Tentacle ) {
				final dir = getDirection( neighbor.pos, cell.pos );
				if( dir == neighbor.organDir ) return true;
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

}