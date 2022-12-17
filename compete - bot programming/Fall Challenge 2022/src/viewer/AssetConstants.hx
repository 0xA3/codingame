package viewer;

using StringTools;
using xa3.format.NumberFormat;

class AssetConstants {
	
	public static final HUD = "hud";
	public static final GEAR = "gear";
	public static final BLUE_ROBOT = "blue_robot";
	public static final RED_ROBOT = "red_robot";
	public static final UNIT_MULTIPLE = "unit_multiple";

	public static final DEBRIS_GREY_FRAMES = ['Debris_1','Debris_2','Debris_3','Debris_4'];
	public static final DEBRIS_BLUE_FRAMES = ['Debris_1_Bleu','Debris_2_Bleu','Debris_3_Bleu','Debris_4_Bleu'];
	public static final DEBRIS_RED_FRAMES = ['Debris_1_Rouge','Debris_2_Rouge','Debris_3_Rouge','Debris_4_Rouge'];
	public static final BUILD_RECYCLER_BLUE_FRAMES = [for( i in 1...35 ) 'R_B' + i.fixed( 4 )];
	public static final BUILD_RECYCLER_RED_FRAMES = [for( i in 1...35 ) 'R_R' + i.fixed( 4 )];
	public static final RECYCLER_BLUE_FRAMES = [for( i in 1...35 ) 'Recyclage_Bleu' + i.fixed( 4 )];
	public static final RECYCLER_RED_FRAMES = [for( i in 1...35 ) 'Recyclage_Rouge' + i.fixed( 4 )];
	public static final DISPARITION_GLOBAL_FRAMES = [for( i in 1...43 ) 'Disparition_Globale' + i.fixed( 4 )];
	public static final POUFF_FRAMES = [for( i in 1...35 ) 'Pouff' + i.fixed( 4 )];
	public static final FIGHT_FRAMES = [for( i in 1...32 ) 'Fight' + i.fixed( 4 )];
	
	public static final CENTER_ANCHOR = { x: 0.5, y: 0.5 }
}