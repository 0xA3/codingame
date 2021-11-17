import CodinGame.print;
import CodinGame.printErr;
import CodinGame.readline;
import Std.parseInt;
import TestCases.TestCase;
import ga.Population;
import sim.data.Agent;
import sim.data.Position;
import sim.data.SurfaceCoords;

class Main {
	
	static var x:Int;
	static var y:Int;
	static var hSpeed:Int;
	static var vSpeed:Int;
	static var fuel:Int;
	static var rotate:Int;
	static var power:Int;
	
	static final numChromosomes = 100;
	static final numGenes = 150;
	static final mutationRate = 0.1;

	static function main() {
		
		final coordsN = parseInt( CodinGame.readline()); // the number of points used to draw the surface of Mars.
		final coords = [for ( i in 0...coordsN ) {
			var inputs = CodinGame.readline().split(' ');
			final landX = parseInt( inputs[0] ); // X coordinate of a surface point. (0 to 6999)
			final landY = parseInt( inputs[1] ); // Y coordinate of a surface point. By linking all the points together in a sequential fashion, you form the surface of Mars.
			[landX, landY];
		}];

		// printErr( surface );
		var inputs = CodinGame.readline().split(' ');
		x = parseInt( inputs[0] );
		y = parseInt( inputs[1] );
		hSpeed = parseInt( inputs[2] ); // the horizontal speed (in m/s), can be negative.
		vSpeed = parseInt( inputs[3] ); // the vertical speed (in m/s), can be negative.
		fuel = parseInt( inputs[4] ); // the quantity of remaining fuel in liters.
		rotate = parseInt( inputs[5] ); // the rotation angle in degrees (-90 to 90).
		power = parseInt( inputs[6] ); // the thrust power (0 to 4).
		
		final testCase:TestCase = {
			coords: coords,
			x: x,
			y:y,
			hSpeed: hSpeed,
			vSpeed: vSpeed,
			fuel: fuel,
			angle: rotate,
			power: power
		}
		final positions = testCase.coords.map( c -> new Position( c[0], c[1] ));
		final surfaceCoords = new SurfaceCoords( positions );
		
		final agent = new Agent( testCase, surfaceCoords, numGenes );
		final population = Population.createRandom( numChromosomes, numGenes, testCase, surfaceCoords );
		final marsLander = new MarsLander( surfaceCoords, agent, population, numGenes, mutationRate );
		marsLander.startSimulation();
		
		// final commands = haxe.Json.parse( '[{"rotate":-1,"power":1},{"rotate":3,"power":2},{"rotate":0,"power":3},{"rotate":-7,"power":4},{"rotate":-16,"power":4},{"rotate":-11,"power":4},{"rotate":-16,"power":3},{"rotate":-13,"power":4},{"rotate":-5,"power":3},{"rotate":8,"power":2},{"rotate":5,"power":2},{"rotate":-4,"power":3},{"rotate":1,"power":4},{"rotate":-4,"power":4},{"rotate":-17,"power":4},{"rotate":-29,"power":4},{"rotate":-35,"power":4},{"rotate":-35,"power":4},{"rotate":-33,"power":4},{"rotate":-30,"power":4},{"rotate":-42,"power":4},{"rotate":-34,"power":3},{"rotate":-24,"power":4},{"rotate":-29,"power":4},{"rotate":-28,"power":4},{"rotate":-32,"power":4},{"rotate":-36,"power":4},{"rotate":-44,"power":4},{"rotate":-39,"power":4},{"rotate":-28,"power":3},{"rotate":-30,"power":4},{"rotate":-36,"power":4},{"rotate":-37,"power":3},{"rotate":-27,"power":3},{"rotate":-22,"power":2},{"rotate":-29,"power":2},{"rotate":-24,"power":3},{"rotate":-22,"power":2},{"rotate":-26,"power":2},{"rotate":-19,"power":2},{"rotate":-20,"power":3},{"rotate":-10,"power":3},{"rotate":-2,"power":4},{"rotate":-14,"power":4},{"rotate":-15,"power":4},{"rotate":-13,"power":4},{"rotate":-12,"power":4},{"rotate":-2,"power":4},{"rotate":-7,"power":4},{"rotate":-3,"power":4},{"rotate":6,"power":4},{"rotate":13,"power":4},{"rotate":10,"power":3},{"rotate":21,"power":3},{"rotate":22,"power":3},{"rotate":25,"power":3},{"rotate":34,"power":4},{"rotate":44,"power":4},{"rotate":36,"power":4},{"rotate":32,"power":4},{"rotate":32,"power":4},{"rotate":22,"power":4},{"rotate":22,"power":4},{"rotate":22,"power":4},{"rotate":22,"power":4},{"rotate":22,"power":4},{"rotate":18,"power":4},{"rotate":7,"power":4},{"rotate":4,"power":4},{"rotate":4,"power":4},{"rotate":4,"power":4},{"rotate":4,"power":4},{"rotate":9,"power":4},{"rotate":9,"power":4},{"rotate":9,"power":4},{"rotate":9,"power":4},{"rotate":7,"power":4},{"rotate":7,"power":4},{"rotate":6,"power":4},{"rotate":6,"power":4},{"rotate":6,"power":4},{"rotate":6,"power":4},{"rotate":6,"power":4},{"rotate":3,"power":4},{"rotate":7,"power":4},{"rotate":7,"power":4},{"rotate":7,"power":4},{"rotate":7,"power":4},{"rotate":7,"power":4},{"rotate":10,"power":4},{"rotate":10,"power":4},{"rotate":2,"power":3},{"rotate":2,"power":3},{"rotate":2,"power":3},{"rotate":2,"power":3},{"rotate":1,"power":4},{"rotate":1,"power":4},{"rotate":1,"power":4},{"rotate":1,"power":4},{"rotate":1,"power":4},{"rotate":1,"power":4},{"rotate":1,"power":4},{"rotate":1,"power":4},{"rotate":0,"power":4}]' );

		var frame = 0;
		print( marsLander.update( frame ));
		// print( '${commands[frame].rotate} ${commands[frame].power}' );
		frame++;
		
		// game loop
		while( true ) {
			readline();
			print( marsLander.update( frame ));
			// print( '${commands[frame].rotate} ${commands[frame].power}' );
			frame++;
		}
	}
}
