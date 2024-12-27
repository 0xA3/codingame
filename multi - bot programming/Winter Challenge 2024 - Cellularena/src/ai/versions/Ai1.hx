package ai.versions;

import CodinGame.printErr;
import CodinGame.readline;
import Math.round;
import Std.int;
import ai.IAi;
import ai.data.Cell;
import ai.data.Node.NO_NODE;
import ai.data.Node;
import xa3.MathUtils;
import xa3.math.Pos;

using Lambda;

class Ai1 {
	
	static final proteinTypes = ["A" => true, "B" => true, "C" => true, "D" => true];

	public var aiId = "Ai1";

	var playerIdx = 1;

	var grid:Array<Array<Int>>;
	var width:Int;
	var height:Int;
	var positions:Array<Array<Pos>>;
	var visited:Array<Array<Bool>>;
	final harvestedProteins:Map<Pos, Bool> = [];

	var requiredActionsCount:Int;
	var entities:Array<Entity>;
	var myEntities:Map<Int, Entity>;
	var oppEntities:Array<Entity>;
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
		visited = [for( _ in 0...height ) [for( _ in 0...width ) false]];
		
		turn = 0;
	}
	
	public function setInputs( requiredActionsCount:Int, entities:Array<Entity>, myEntities:Map<Int, Entity>, oppEntities:Array<Entity>, a:Int, b:Int, c:Int, d:Int ) {
		this.requiredActionsCount = requiredActionsCount;
		this.entities = entities;
		this.myEntities = myEntities;
		this.oppEntities = oppEntities;
		
		this.a = a;
		this.b = b;
		this.c = c;
		this.d = d;
	}

	public function process() {
		turn++;
		harvestedProteins.clear();
		for( entity in myEntities ) if( entity.type == "HARVESTER" ) {
			final proteinPos = getNeighborPosition( entity.pos, entity.organDir );
			printErr( 'set harvestedProtein at $proteinPos' );
			harvestedProteins.set( proteinPos, true );
		}

		final closestProteinNode = findClosestProtein();

		final closestOrgan = myEntities[closestProteinNode.closestOrganId];
		if( closestProteinNode.distance == 2 ) {
			final harvesterPos = closestProteinNode.parent.pos;
			final direction = getDirection( harvesterPos, closestProteinNode.pos );
			return 'GROW ${closestOrgan.organId} ${harvesterPos.x} ${harvesterPos.y} HARVESTER $direction';
		} else if( closestProteinNode.distance > 2 ) {
			return 'GROW ${closestOrgan.organId} ${closestProteinNode.pos.x} ${closestProteinNode.pos.y} BASIC N';
		} else {
			final goToOppNode = getGoToOppNode();
			if( goToOppNode != NO_NODE ) {
				// check for opponent entities nearby
				final x = goToOppNode.pos.x;
				final y = goToOppNode.pos.y;
				var dir = "N";
				var isOppNearby = false;
				for( i in [1, 2] ) {
					final yUp = y - i;
					final xLeft = x - i;
					final yDown = y + i;
					final xRight = x + i;
					if( checkValidCoord( x, yUp )) {
						final entity = geTCell( positions[yUp][x] );
						if( entity.owner == 0 ) {
							isOppNearby = true;
							dir = "N";
						}
					}
					if( checkValidCoord( xLeft, y )) {
						final entity = geTCell( positions[y][xLeft] );
						if( entity.owner == 0 ) {
							isOppNearby = true;
							dir = "W";
						}
					}
					if( checkValidCoord( x, yDown )) {
						final entity = geTCell( positions[yDown][x] );
						if( entity.owner == 0 ) {
							isOppNearby = true;
							dir = "S";
						}
					}
					if( checkValidCoord( xRight, y )) {
						final entity = geTCell( positions[y][xRight] );
						if( entity.owner == 0 ) {
							isOppNearby = true;
							dir = "E";
						}
					}
				}

				if( isOppNearby ) return 'GROW ${goToOppNode.closestOrganId} ${x} ${y} TENTACLE $dir';
				else return 'GROW ${goToOppNode.closestOrganId} ${x} ${y} BASIC N';
				
			} else {
				return "WAIT";
			}
		}
	}

	function findClosestProtein() {
		// find proteins
		for( y in 0...grid.length ) for( x in 0...grid[y].length ) visited[y][x] = false;

		final frontier = new List<Node>();
		for( entity in myEntities ) {
			final startNode = new Node( entity.organId, entity.pos, 0, NO_NODE );
			frontier.add( startNode );
		}

		while( !frontier.isEmpty() ) {
			final currentNode = frontier.pop();
			final currentClosestOrganId = currentNode.closestOrganId;
			final currentPos = currentNode.pos;
			final entity = geTCell( currentPos );
			
			if( entity != Entity.NO_ENTITY && proteinTypes.exists( entity.type )) {
				printErr( 'found protein type ${entity.type} at $currentPos with distance ${currentNode.distance}' );
				return currentNode;
			}

			final nextDistance = currentNode.distance + 1;
			final neighborPositions = getNeighborPositions( currentPos, visited );
			for( neighborPos in neighborPositions ) {
				frontier.add( new Node( currentClosestOrganId, neighborPos, nextDistance, currentNode ));
			}
		}
		return Node.NO_NODE;
	}

	inline function geTCell( pos:Pos ) return grid[pos.y][pos.x] == -1 ? Entity.NO_ENTITY : entities[grid[pos.y][pos.x]];
	inline function manhattanDistance( p1:Pos, p2:Pos ) return MathUtils.abs( p1.x - p2.x ) + MathUtils.abs( p1.y - p2.y );
	inline function getDirection( p1:Pos, p2:Pos ) {
		if( p1.y < p2.y ) return "S";
		if( p1.x < p2.x ) return "E";
		if( p1.y > p2.y ) return "N";
		return "W";
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
		if( x1 >= 0 && !visited[y2][x2] && checkProteinOrEmpty( x1, y1 ) && !harvestedProteins.exists( positions[y1][x1] )) {
			neighbors.add( positions[y1][x1] );
			visited[y1][x1] = true;
		}
		if( x2 < width && !visited[y2][x2] && checkProteinOrEmpty( x2, y2 ) && !harvestedProteins.exists( positions[y2][x2] )) {
			neighbors.add( positions[y2][x2] );
			visited[y2][x2] = true;
		}
		if( y3 >= 0 && !visited[y3][x3] && checkProteinOrEmpty( x3, y3 ) && !harvestedProteins.exists( positions[y3][x3] )) {
			neighbors.add( positions[y3][x3] );
			visited[y3][x3] = true;
		}
		if( y4 < height && !visited[y4][x4] && checkProteinOrEmpty( x4, y4 ) && !harvestedProteins.exists( positions[y4][x4] )) {
			neighbors.add( positions[y4][x4] );
			visited[y4][x4] = true;
		}
	
		return neighbors;
	}

	function getNeighborPosition( pos:Pos, direction:String ) {
		switch direction {
			case "N": return positions[pos.y - 1][pos.x];
			case "W": return positions[pos.y][pos.x - 1];
			case "S": return positions[pos.y + 1][pos.x];
			case "E": return positions[pos.y][pos.x + 1];
			default: throw 'ERROR: invalid direction $direction';
		}
	}

	function checkValidCoord( x:Int, y:Int ) {
		if( x < 0 || x >= width || y < 0 || y >= height ) return false;
		return true;
	}

	function checkProteinOrEmpty( x:Int, y:Int ) {
		if( x < 0 || x >= width || y < 0 || y >= height ) return false;
		final entity = geTCell( positions[y][x] );
		if( entity == Entity.NO_ENTITY ) return true;
		if( proteinTypes.exists( entity.type )) return true;
		return false;
	}

	function getGoToOppNode() {
		for( y in 0...grid.length ) for( x in 0...grid[y].length ) visited[y][x] = false;
		final oppCenter = getCenter( [for( entity in oppEntities ) entity.pos] );

		final entityDistances:Array<{ entity:Entity, distance:Int }> = [];
		for( entity in myEntities ) {
			final distance = manhattanDistance( entity.pos, oppCenter );
			entityDistances.push( { entity:entity, distance:distance } );
		}
		entityDistances.sort(( a, b ) -> a.distance - b.distance );
		for( ed in entityDistances ) {
			// printErr( 'entity: ${ed.entity.pos} distance: ${ed.distance}' );
			final neighbors = getNeighborPositions( ed.entity.pos, visited );
			if( neighbors.length > 0 ) {
				final closestNeighborPos = getClosestPos( oppCenter, neighbors );
				// printErr( 'closestNeighborPos: $closestNeighborPos' );
				return new Node( ed.entity.organId, closestNeighborPos, 1 );
			}
		}

		return Node.NO_NODE;
	}
	
	function getCenter( inputPositions:Array<Pos> ) {
		final avgX = inputPositions.fold(( pos, sum ) -> sum + pos.x, 0 ) / inputPositions.length;
		final avgY = inputPositions.fold(( pos, sum ) -> sum + pos.y, 0 ) / inputPositions.length;

		return positions[int(avgY)][int(avgX)];
	}

	function getClosestPos( pos:Pos, inputPositions:List<Pos> ) {
		// find closest position
		var minDistance = width * height;
		var closestPos = inputPositions.first();
		for( p in inputPositions ) {
			final distance = manhattanDistance( pos, p );
			if( distance < minDistance ) {
				minDistance = distance;
				closestPos = p;
			}
		}
		return closestPos;
	}
}
