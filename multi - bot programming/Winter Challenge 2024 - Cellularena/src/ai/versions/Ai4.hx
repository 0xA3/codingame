package ai.versions;

import CodinGame.printErr;
import ai.contexts.OutputTCell.output;
import ai.data.Cell;
import ai.data.Node;
import ai.data.NodePool;
import ai.data.TCell;
import haxe.ds.ArraySort;
import xa3.math.Pos;

using xa3.MathUtils;

class Ai4 {
	
	static inline var ME = 1;
	static inline var OPP = 0;
	static inline var NO_OWNER = -1;

	public var aiId = "Ai4 harvest A proteins";

	final proteinCellTypes = [TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];
	final borderCellNeighborTypes = [ TCell.Empty => true, TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true];
	var playerIdx = 1;

	var positions:Array<Array<Pos>>;
	var cells:Map<Pos, Cell>;
	var width:Int;
	var height:Int;

	var requiredActionsCount:Int;
	var entities:Array<Cell>;
	var myCells:Map<Int, Array<Cell>>;
	var myRoots:Array<Cell>;
	var harvestedProteins:Map<Pos, Bool>;
	var oppCells:Array<Cell>;
	var a:Int;
	var b:Int;
	var c:Int;
	var d:Int;

	var turn:Int;

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
		oppCells:Array<Cell>
	) {
		this.requiredActionsCount = requiredActionsCount;
		this.myRoots = myRoots;
		this.myCells = myCells;
		this.oppCells = oppCells;
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

		final outputs = [];
		// for( i in 0...requiredActionsCount ) {
		for( root in myRoots ) {
			final borderCells = myBorderCells[root.organId];
			if( borderCells == null ) throw 'ERROR: myBorderCells[${root.organId}] == null';
			
			var harvestType = TCell.NoCell;
			if( harvestedProteinTypes[TCell.A] == 0 ) {
				harvestType = TCell.A;
				printErr( 'harvest Protein A' );
			} else if( harvestedProteinTypes[TCell.B] == 0 ) {
				harvestType = TCell.B;
				printErr( 'harvest Protein B' );
			} else if( harvestedProteinTypes[TCell.C] == 0 ) {
				harvestType = TCell.C;
				printErr( 'harvest Protein C' );
			} else if( harvestedProteinTypes[TCell.D] == 0 ) {
				harvestType = TCell.D;
				printErr( 'harvest Protein D' );
			}

			final node = findCellNode( root, borderCells, harvestType );
			if( node == Node.NO_NODE ) {
				outputs.push( 'WAIT' );
			} else {
				if( node.distance == 2 ) {
					final harvesterNode = node.parent;
					final harvesterPos = harvesterNode.cell.pos;
					final havesterDirection = getDirection( harvesterPos, node.cell.pos );
					outputs.push( 'GROW ${harvesterNode.startCellId} ${harvesterPos.x} ${harvesterPos.y} HARVESTER $havesterDirection' );
				} else {
					final neighborNode = backtrack( node );
					outputs.push( 'GROW ${neighborNode.startCellId} ${neighborNode.cell.pos.x} ${neighborNode.cell.pos.y} BASIC' );
				}
			}
		}

		return outputs.join( "\n" );
	}
	
	inline function initBorderCells() {
		for( rootId => cellsOfRoot in myCells ) {
			if( !myBorderCells.exists( rootId )) myBorderCells[rootId] = [];
			final borderCells = myBorderCells[rootId];
			borderCells.splice( 0, borderCells.length );
	
			for( i in -cellsOfRoot.length + 1...1 ) {
				final cell = cellsOfRoot[-i];
				final neighbors = cell.neighbors;
				for( neighbor in neighbors ) {
					if( borderCellNeighborTypes.exists( neighbor.type )) {
						borderCells.push( cell );
						break;
					}
				}
			}
		}
	}

	inline function initHarvestedProteinTypes() {
		for( type => count in harvestedProteinTypes ) harvestedProteinTypes[type] = 0;
		
		for( pos in harvestedProteins.keys() ) {
			final proteinCell = cells[pos];
			harvestedProteinTypes[proteinCell.type]++;
		}
		for( type => count in harvestedProteinTypes ) printErr( 'type: $type, count: $count' );
	}

	function findCellNode( start:Cell, borderCells:Array<Cell>, type:TCell, owner = NO_OWNER ) {
		resetVisited();

		final frontier = new List<Node>();
		for( cell in borderCells ) {
			final startNode = nodePool.get( cell.organId, cell, 0 );
			frontier.add( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentCell = currentNode.cell;
			if( currentCell.type == type && currentCell.owner == owner ) {
				nodePool.addNodes( frontier );
				return currentNode;
			}
			
			final nextDistance = currentNode.distance + 1;
			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				if( visited[y][x] || harvestedProteins[neighbor.pos] ) continue;
				
				frontier.add( nodePool.get( currentCell.organId, neighbor, nextDistance, currentNode ));
				visited[y][x] = true;
			}
		}
		printErr( 'no node found' );
		return Node.NO_NODE;
	}
	
	function findCellNodes( borderCells:Array<Cell>, start:Cell, type:TCell, owner = NO_OWNER ) {
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
			nodePool.add( currentNode );
			
			if( currentCell.type == type && currentCell.owner == owner ) {
			// if( currentCell.type == type ) {
				nodes.push( currentNode );
				// printErr( 'found node, type: ${currentCell.type} owner: ${owner}' );
			}
			
			final nextDistance = currentNode.distance + 1;
			for( neighbor in currentCell.neighbors ) {
				final x = neighbor.pos.x;
				final y = neighbor.pos.y;
				if( visited[y][x] || harvestedProteins[neighbor.pos] ) continue;
				
				frontier.add( nodePool.get( currentNode.startCellId, neighbor, nextDistance, currentNode ));
				visited[y][x] = true;
			}
		}
		
		return nodes;
	}
	
	function backtrack( node:Node, to = 1 ) {
		// printErr( 'backtrack: node: $node, to: $to' );
		if( node.distance < to ) throw 'ERROR: node.distance < to';
		if( node.distance == to ) return node;
		var tempNode = node;
		while( tempNode.distance > to ) {
			// printErr( '$tempNode' );
			nodePool.add( tempNode );
			tempNode = tempNode.parent;
		}

		return tempNode;
	}

	function getDirection( pos1:Pos, pos2:Pos ) {
		if( pos1.y < pos2.y ) return "S";
		if( pos1.x < pos2.x ) return "E";
		if( pos1.y > pos2.y ) return "N";
		if( pos1.x > pos2.x ) return "W";
		throw 'ERROR: pos1 == pos2';
	}

	function resetVisited() for( y in 0...height ) for( x in 0...width ) visited[y][x] = false;

}