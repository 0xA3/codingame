package ai;

import CodinGame.printErr;
import ProgramInput.PodPropertiesDataset;
import ProgramInput.TravelRoute;
import algorithm.Triangulate.triangulate;
import data.Building;
import data.Edge;

using Lambda;

class Ai1 {
	
	var step = 0;
	
	var resources = 0;
	final travelRoutes:Array<TravelRoute> = [];
	final podPropertiesDatasets:Array<PodPropertiesDataset> = [];
	final buildings:Map<Int, Building> = [];
	final landingPads:Map<Int, Building> = [];
	final lunarModules:Map<Int, Building> = [];

	final tubes:Map<String, Edge> = [];
	
	var hasNewBuildings = false;

	public function new() {	}

	public function setInput( programInput:ProgramInput ) {
		hasNewBuildings = false;

		resources = programInput.resources;

		if( programInput.buildings.length > 0 ) {
			for( building in programInput.buildings ) {
				buildings.set( building.id, building );
				if( building.type == 0 ) landingPads.set( building.id, building );
				else lunarModules.set( building.id, building );
			}

			hasNewBuildings = true;
		}
	}

	public function process() {
		if( hasNewBuildings ) {
			final points = buildings.map( b -> b.pos );
			final triangles = triangulate( points );
			final edges = [for( t in triangles ) for( e in t.getEdges() ) e.id => e].array();
			printErr( edges.map( e -> e.id ).join( "\n" ));
		}
		
		step++;
		return "WAIT";
	}

}