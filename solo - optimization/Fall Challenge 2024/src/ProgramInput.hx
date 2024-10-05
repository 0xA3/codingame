import data.Building;

typedef ProgramInput = {
	final resources:Int;
	final travelRoutes:Array<TravelRoute>;
	final podPropertiesDatasets:Array<PodPropertiesDataset>;
	final buildings:Array<Building>;
}

typedef TravelRoute = {
	final buildingId1:Int;
	final buildingId2:Int;
	final capacity:Int;
}

typedef PodPropertiesDataset = {
	final podId:Int;
	final stops:Array<Int>;
}
