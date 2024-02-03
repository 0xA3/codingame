import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import ConvertCoordinates.convertCoordinates;
import Math.cos;
import Std.int;
import Std.parseInt;

using Lambda;

typedef Collector = {
	final name:String;
	final speed:Float;
	final capacity:Int;
	final levitationEfficiency:Float;
	final minCapacity:Int;
}

final collectors:Array<Collector> = [
	{
		name: "VaCoWM Cleaner",
		speed: 44.7,
		capacity: 3,
		levitationEfficiency: 0.8,
		minCapacity: 1
	},
	{
		name: "L4nd MoWer",
		speed: 22.38,
		capacity: 10,
		levitationEfficiency: 1.2,
		minCapacity: 6
	},
	{
		name: "Cow Harvester",
		speed: 11.19,
		capacity: 20,
		levitationEfficiency: 1.5,
		minCapacity: 14
	}
];

final collectorAltitude = 0.5;
final missleLat = convertCoordinates( "34°45'21.8\"N" );
final missleLon = convertCoordinates( "120°37'34.8\"W" );
final missleStartAltitude = 0.046;
final missleMaxAltitude = 160;
final missleSpeed = 6;
final g = 9.81;
final PI = 3.14159265359;
final latDegreeDistance = 111.11;

function main() {

	final n = parseInt( readline());
	final upcomingMissions = [for( _ in 0...n ) readline()];

	final result = process( upcomingMissions );
	print( result );
}

function process( upcomingMissions:Array<String> ) {

	final locations = upcomingMissions.map( upcomingMission -> Location.fromString( upcomingMission ));
	final locationResults = locations.map( processLocation );

	return locationResults.join( "\n" );
}

function processLocation( location:Location ) {
	final latDist = ( missleLat - location.latitude ) * latDegreeDistance;
	final lonDist = ( missleLon - location.longitude ) * latDegreeDistance * cos(( missleLat + location.latitude ) / 2 * PI / 180 );
	final missleHorizontal = Math.sqrt( latDist * latDist + lonDist * lonDist );
	final missleVertical = missleMaxAltitude - missleStartAltitude;
	final missleSlopeDistance = Math.sqrt( missleHorizontal * missleHorizontal + missleVertical * missleVertical );
	final missleSlopeTime = missleSlopeDistance / missleSpeed;

	final collectorEscapeDistance = missleMaxAltitude - location.elevation - collectorAltitude;
	final collectorEscapeTimes = collectors.map( collector -> collectorEscapeDistance / collector.speed );
	final collectorHarvestTimes = collectorEscapeTimes.map( collectorEscapeTime -> missleSlopeTime - collectorEscapeTime );
	final cowLevitateTimes = collectors.map( collector -> collectorAltitude / ( g / 1000 * collector.levitationEfficiency ));
	final harvestedCowsPerCollector = collectorHarvestTimes.mapi(( i, collectorHarvestTime ) -> min( collectors[i].capacity, int( collectorHarvestTime / cowLevitateTimes[i] )));

	final collectorHarvestDatasets = [for( i in 0...collectors.length ) {collector: collectors[i], cows: harvestedCowsPerCollector[i]}];
	final chdsAboveMinCapacity = collectorHarvestDatasets.filter( chd -> chd.cows >= chd.collector.minCapacity );

	if( chdsAboveMinCapacity.length == 0 ) return '${location.name}: impossible.';
	
	chdsAboveMinCapacity.sort(( a, b ) -> b.cows - a.cows );
	final chdBest = chdsAboveMinCapacity[0];

	return '${location.name}: possible. Send a ${chdBest.collector.name} to bring back ${chdBest.cows} cow' + ( chdBest.cows > 1 ? "s" : "" ) + ".";
}

function min( v1:Int, v2:Int ) return v1 < v2 ? v1 : v2;