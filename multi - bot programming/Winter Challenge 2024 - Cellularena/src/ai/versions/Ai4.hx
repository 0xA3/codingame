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

	final proteinCellTypes = [ TCell.A => true, TCell.B => true, TCell.C => true, TCell.D => true ];

	var playerIdx = 1;

	var positions:Array<Array<Pos>>;
	var cells:Map<Pos, Cell>;
	var width:Int;
	var height:Int;

	var requiredActionsCount:Int;
	var entities:Array<Cell>;
	var myCells:Map<Int, Cell>;
	var myRoots:Array<Cell>;
	var harvestedProteins:Map<Pos, Bool> = [];
	var oppCells:Array<Cell>;
	var a:Int;
	var b:Int;
	var c:Int;
	var d:Int;

	var turn:Int;

	final nodePool = new NodePool();
	final visited:Array<Array<Bool>> = [];
	final myBorderCells:Array<Cell> = [];

	public function new() {	}

	public function setGlobalInputs( positions:Array<Array<Pos>>, cells:Map<Pos, Cell>, width:Int, height:Int ) {
		this.positions = positions;
		this.cells = cells;
		this.width = width;
		this.height = height;
		
		for( _ in 0...height ) visited.push( [for( _ in 0...width ) false] );
		turn = 0;
	}
	
	public function setInputs( a:Int, b:Int, c:Int, d:Int, requiredActionsCount:Int, myRoots:Array<Cell>, myCells:Map<Int, Cell>, harvestedProteins:Map<Pos, Bool>, oppCells:Array<Cell> ) {
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
		
		if( turn == 1 ) {
			// for( cell in cells ) printErr( 'pos: ${cell.pos}, type: ${output( cell.type )}, neighbors: ${cell.neighborsToString()}' );
		}
		initBorderCells();

		// for( cell in myBorderCells ) printErr( 'border cells: pos: ${cell.pos}, type: ${output( cell.type )}' );

		final outputs = [];
		for( i in 0...requiredActionsCount ) {
			final root = myRoots[i];
			final node = findCellNode( root, TCell.A );
			printErr( '$node' );
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
					// printErr( 'neighborNode: $neighborNode' );
					outputs.push( 'GROW ${neighborNode.startCellId} ${neighborNode.cell.pos.x} ${neighborNode.cell.pos.y} BASIC' );
				}
			}
		}

		return outputs.join( "\n" );
	}
	
	function initBorderCells() {
		myBorderCells.splice( 0, myBorderCells.length );
		for( cell in myCells ) {
			final neighbors = cell.neighbors;
			for( neighbor in neighbors ) {
				if( neighbor.type == TCell.Empty ) {
					myBorderCells.push( cell );
					break;
				}
			}
		}
	}

	function findCellNode( start:Cell, type:TCell, owner = NO_OWNER ) {
		resetVisited();

		final frontier = new List<Node>();
		for( cell in myBorderCells ) {
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
	
	function findCellNodes( start:Cell, type:TCell, owner = NO_OWNER ) {
		resetVisited();
		final nodes = [];
		final frontier = new List<Node>();
		for( cell in myBorderCells ) {
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