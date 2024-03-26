@:native("buildingHeights")
@:keep function buildingHeights( n:Int, buildingMap:Array<String> ) {
	final heights = buildingMap.map( s -> s.split( "" ).filter( s -> s == "*" ).length );

	return heights;
}
