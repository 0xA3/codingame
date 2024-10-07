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
	final outputs:Array<String> = [];
	final edgesMap:Map<String, Edge> = [];
	final edges:Array<Edge> = [];

	public function new() {	}

	public function reset() {
		outputs.splice( 0, outputs.length );
		hasNewBuildings = false;
	}

	public function setInput( programInput:ProgramInput ) {
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
		if( hasNewBuildings ) {
			edges.splice( 0, edges.length );
			edgesMap.clear();

			final points = buildings.map( b -> b.pos );
			final triangles = triangulate( points );
			for( t in triangles ) for( e in t.getEdges() ) edgesMap.set( e.id, e );
			for( edge in edgesMap ) {
				var isIntersect = false;
				for( tube in tubes ) {
					if( edge.intersects( tube )) {
						printErr( 'intersect of edge ${getEdgeDescription( edge )} with tube ${getEdgeDescription( tube )}' );
						isIntersect = true;
						break;
					}
				}
				if( !isIntersect ) {
					printErr( 'add edge ${getEdgeDescription( edge )}' );
					edges.push( edge );
				}
			}
			
			addTubes();
			// printErr( 'Edges\n' + validEdges.map( e -> e.id ).join( "\n" ));

		}
		
		step++;
		if( outputs.length == 0 ) return "WAIT";
		return outputs.join( ";" );
	}

	function getEdgeDescription( edge:Edge ) {
		final startBuilding = buildingsByPos[edge.p1];
		final endBuilding = buildingsByPos[edge.p2];
		final startBuildingString = startBuilding.type == 0 ? 'LandingPad' : 'LunarModule type ${startBuilding.type}';
		final endBuildingString = endBuilding.type == 0 ? 'LandingPad' : 'LunarModule type ${endBuilding.type}';
		return 'from $startBuildingString id ${startBuilding.id} to $endBuildingString id ${endBuilding.id}';
	}

	function addTubes() {
		final neighborsMap:Map<Building, Array<Edge>> = [];
		for( building in buildings ) {
			neighborsMap.set( building, [] );
			for( edge in edges ) {
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
				final modulesForAstronaut = lunarModulesByType[astronautType];
				for( moduleForAstronaut in modulesForAstronaut ) {
					// final moduleForAstronaut = lunarModulesByType[astronautType][0] ?? throw 'No lunar module for astronaut type: $astronautType';
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
							if( resources > cost ) {
								outputs.push( 'TUBE $tubeStartId $tubeEndId' );
								tubes.set( edgeId, edge );
								tubesNum++;
								resources -= cost;
							}
						}
					}
				}
			}
		}
	
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