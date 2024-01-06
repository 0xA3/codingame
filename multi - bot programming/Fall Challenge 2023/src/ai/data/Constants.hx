package ai.data;

class Constants {
	
	public static inline var MAX_POS = 10000;
	public static final ZONES = [ 0 => [2500, 5000], 1 => [5000, 7500], 2 => [7500, MAX_POS], -1 => [5000, 10000]];
	public static inline var MONSTER_MIN_Y = 2500;
	
	public static inline var SCAN_RADIUS = 800;
	public static inline var LIGHT_SCAN_RADIUS = 2000;
	
	public static inline var TL = "TL";
	public static inline var TR = "TR";
	public static inline var BR = "BR";
	public static inline var BL = "BL";
}
