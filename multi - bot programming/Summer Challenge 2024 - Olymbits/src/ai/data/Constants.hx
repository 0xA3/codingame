package ai.data;

class Constants {
	
	public static inline var NUM_PLAYERS = 3;

	public static inline var HURDLE = "#";
	
	public static inline var U = "U";
	public static inline var L = "L";
	public static inline var D = "D";
	public static inline var R = "R";
	
	public static inline var UP = "UP";
	public static inline var LEFT = "LEFT";
	public static inline var DOWN = "DOWN";
	public static inline var RIGHT = "RIGHT";

	public static final directionMap = [
		U => UP,
		L => LEFT,
		D => DOWN,
		R => RIGHT,
		// GAME OVER
		"G" => LEFT,
		"A" => LEFT,
		"M" => LEFT,
		"E" => LEFT,
	];
}
