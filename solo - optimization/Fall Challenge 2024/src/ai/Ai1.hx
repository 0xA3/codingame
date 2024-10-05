package ai;

import CodinGame.printErr;
import ProgramInput.PodPropertiesDataset;
import ProgramInput.TravelRoute;
import algorithm.AStarSearch;
import algorithm.Triangulate.triangulate;
import data.Building;
import data.Edge;
import data.PathNode;
import data.Point;

using Lambda;

class Ai1 {
	
	var step = 0;
	
	var resources = 0;
	final travelRoutes:Array<TravelRoute> = [];
	final podPropertiesDatasets:Array<PodPropertiesDataset> = [];
	final buildings:Map<Int, Building> = [];
	final buildingsByPos:Map<Point, Building> = [];
	final landingPads:Map<Int, Building> = [];
	final lunarModules:Map<Int, Building> = [];
	final lunarModulesByType:Map<Int, Array<Building>> = [];

	final pods:Array<Array<Int>> = [];
	final tubes:Map<String, Edge> = [];
	var tubesNum = 0;
	
	var hasNewBuildings = false;

	public function new() {	}

	public function setInput( programInput:ProgramInput ) {
		hasNewBuildings = false;

		resources = programInput.resources;

		if( programInput.buildings.length > 0 ) {
			for( building in programInput.buildings ) {
				buildings.set( building.id, building );
				buildingsByPos.set( building.pos, building );
				if( building.type == 0 ) landingPads.set( building.id, building );
				else {
					lunarModules.set( building.id, building );
					if( !lunarModulesByType.exists( building.type )) lunarModulesByType.set( building.type, [building] );
					else lunarModulesByType[building.type].push( building );
				}
			}

			hasNewBuildings = true;
		}
	}

	public function process() {
		var currentResources = resources;
		final outputs = [];
		if( hasNewBuildings ) {
			final points = buildings.map( b -> b.pos );
			final triangles = triangulate( points );
			final edgesMap = [for( t in triangles ) for( e in t.getEdges() ) e.id => e];
			final validEdges = [];
			for( edge in edgesMap ) {
				var isIntersect = false;
				for( tube in tubes ) {
					if( edge.intersects( tube )) {
						printErr( 'edge $edge intersects tube $tube' );
						isIntersect = true;
						break;
					}
				}
				if( !isIntersect ) printErr( 'add edge $edge' );
				if( !isIntersect ) validEdges.push( edge );
			}
			
			// printErr( 'Edges\n' + validEdges.map( e -> e.id ).join( "\n" ));

			final neighborsMap:Map<Building, Array<Edge>> = [];
			for( building in buildings ) {
				neighborsMap.set( building, [] );
				for( edge in validEdges ) {
					if( edge.p1.equals( building.pos ) || edge.p2.equals( building.pos )) {
						neighborsMap[building].push( edge );
					}
				}
			}
			// for( building => neighbors in neighborsMap ) {
			// 	trace( '${building.id} $neighbors' );
			// }
		
			for( landingPad in landingPads ) {
				for( astronautType in landingPad.astronautTypesMap.keys()) {
					// find path to building
					final moduleForAstronaut = lunarModulesByType[astronautType][0] ?? throw 'No lunar module for astronaut type: $astronautType';
					final pathNodes = createPathNodes( landingPad, moduleForAstronaut, neighborsMap );

					final path = AStarSearch.getPath( pathNodes, landingPad.id, moduleForAstronaut.id );
					for( i in 0...path.length - 1 ) {
						printErr( 'astronaut $astronautType from ${landingPad.id} to ${moduleForAstronaut.id}' );
						final tubeStartId = path[i][0];
						final tubeEndId = path[i + 1][0];
						final pos1 = buildings[tubeStartId].pos;
						final pos2 = buildings[tubeEndId].pos;
						final edgeId = Edge.createId( pos1, pos2 );
						final edge = edgesMap[edgeId];
						if( !tubes.exists( edgeId )) {
							final cost = Math.floor( edge.length );
							if( currentResources > cost ) {
								outputs.push( 'TUBE $tubeStartId $tubeEndId' );
								tubes.set( edgeId, edge );
								tubesNum++;
								currentResources -= cost;
							}
						}
					}
					
				}
			}
		}
		
		step++;
		if( outputs.length == 0 ) return "WAIT";
		return outputs.join( ";" );
	}

	function createPathNodes( from:Building, to:Building, neighborsMap:Map<Building, Array<Edge>> ) {
		final pathNodes = [];
		for( building in buildings ) {
			final distanceToGoal = building.pos.distanceTo( to.pos );
			final neighbors = neighborsMap[building];
			final neighborIds = [for( neighbor in neighbors ) neighbor.p1 == building.pos ? buildingsByPos[neighbor.p2].id : buildingsByPos[neighbor.p1].id];
			final pathNode = new PathNode( building.id, distanceToGoal, neighbors, neighborIds );
			
			pathNodes.push( pathNode );
		}
		
		return pathNodes;
	}

}