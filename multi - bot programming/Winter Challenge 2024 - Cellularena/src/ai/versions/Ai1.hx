package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import ai.IAi;
import ai.data.Entity;
import ai.data.Node;
import ai.data.Pos;

using Lambda;

class Ai1 implements IAi {
	
	static final proteinTypes = ["A" => true, "B" => true, "C" => true, "D" => true];

	public var aiId = "Ai1";

	var playerIdx:Int;

	var grid:Array<Array<Int>>;
	var width:Int;
	var height:Int;
	var positions:Array<Array<Pos>>;

	var requiredActionsCount:Int;
	var entities:Array<Entity>;
	var myEntities:Array<Entity>;
	var a:Int;
	var b:Int;
	var c:Int;
	var d:Int;

	var turn:Int;

	public function new() { }
	
	public function setGlobalInputs( grid:Array<Array<Int>>, width:Int, height:Int, positions:Array<Array<Pos>> ) {
		this.grid = grid;
		this.width = width;
		this.height = height;
		this.positions = positions;
		
		turn = 0;
	}
	
	public function setInputs( requiredActionsCount:Int, entities:Array<Entity>, myEntities:Array<Entity>, a:Int, b:Int, c:Int, d:Int	) {
		this.requiredActionsCount = requiredActionsCount;
		this.entities = entities;
		this.myEntities = myEntities;
		// for( entity in myEntities ) printErr( '${entity}' );
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	public function process() {
		turn++;

		final closestProteinNode = findClosestProtein();

		if( closestProteinNode != Node.NO_NODE ) {
			return 'GROW ${closestProteinNode.closestOrganId} ${closestProteinNode.pos.x} ${closestProteinNode.pos.y} BASIC';
		} else return "WAIT";
	}

	function findClosestProtein() {
		
		// find proteins
		final visited = [for( _ in 0...grid.length ) [for( _ in 0...grid[0].length ) false]];
		final startPos = myEntities[0].pos;

		final frontier = new List<Node>();
		for( entity in myEntities ) {
			final startNode = new Node( entity.organId, startPos, 0 );
			frontier.add( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentClosestOrganId = currentNode.closestOrganId;
			final currentPos = currentNode.pos;
			final entity = getEntity( currentPos );
			
			// printErr( 'current entity ${entity}' );
			if( entity != Entity.NO_ENTITY && proteinTypes.exists( entity.type )) {
				// printErr( 'found protein type ${entity.type} at $currentPos with distance ${currentNode.distance}' );
				return currentNode;
			}

			final nextDistance = currentNode.distance + 1;
			final neighborPositions = getNeighborPositions( currentPos, visited );
			for( neighborPos in neighborPositions ) {
				frontier.add( new Node( currentClosestOrganId, neighborPos, nextDistance ));
			}
		}
		return Node.NO_NODE;
	}

	inline function getEntity( pos:Pos ) {
		return grid[pos.y][pos.x] == -1 ? Entity.NO_ENTITY : entities[grid[pos.y][pos.x]];
	}

	function getNeighborPositions( pos:Pos, visited:Array<Array<Bool>> ) {
		final x1 = pos.x - 1;
		final y1 = pos.y;
		final x2 = pos.x + 1;
		final y2 = pos.y;
		final x3 = pos.x;
		final y3 = pos.y - 1;
		final x4 = pos.x;
		final y4 = pos.y + 1;
	
		final neighbors = new List<Pos>();
		if( x1 >= 0 && !visited[y1][x1] && getEntity( pos ).type != "WALL" ) {
			neighbors.add( positions[y1][x1] );
			visited[y1][x1] = true;
		}
		if( x2 < width && !visited[y2][x2] && getEntity( pos ).type != "WALL" ) {
			neighbors.add( positions[y2][x2] );
			visited[y2][x2] = true;
		}
		if( y3 >= 0 && !visited[y3][x3] && getEntity( pos ).type != "WALL" ) {
			neighbors.add( positions[y3][x3] );
			visited[y3][x3] = true;
		}
		if( y4 < height && !visited[y4][x4] && getEntity( pos ).type != "WALL" ) {
			neighbors.add( positions[y4][x4] );
			visited[y4][x4] = true;
		}
	
		return neighbors;
	}
	
}
