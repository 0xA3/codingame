package resources.view;

import gameengine.view.core.Point;
import h2d.Tile;
import h3d.Vector;
import main.event.EventData;
import main.view.CellData;
import resources.view.pixi.Container;
import resources.view.pixi.Sprite;
import resources.view.pixi.Text;

/**
 * Given by the SDK
 */
@:structInit
class FrameInfo {
	public var number:Int;
	public var frameDuration:Int;
	public var date:Int;
}
  /**
   * Given by the SDK
   */
@:structInit
class CanvasInfo {
	public var width:Int;
	public var height:Int;
	public var oversampling:Int;
}
  /**
   * Given by the SDK
   */
@:structInit
class PlayerInfo {
	public var name:String;
	public var avatar:h2d.Tile;
	public var color:Int;
	public var index:Int;
	public var isMe:Bool;
	public var number:Int;
	public var type = "";
}
  
@:structInit
class EventDto {
	public var type:Int;
	public var animData:AnimData;
	public var cellIdx:Int;
	public var targetIdx:Int;
	public var amount:Int;
	public var playerIdx:Int;
	public var path:Array<Int>;
  
	/* Generated locally */
	public var double = false;
	public var crisscross = false;
}
  
// @:structInit
// class FrameDataDto {
// 	public var scores:Array<Int>;
// 	public var events:Array<EventDto>;
// 	public var messages:Array<String>;
// 	public var beacons:Array<Int>;
// }
  
@:structInit
class PathSegment {
	public var key:String;
	public var from:Int;
	public var to:Int;
	public var amount:Int;
	public var pathKeys:Map<String, Bool>;
}
  
@:structInit
class AggregatedPathsEvent {
	public var type:Int;
	public var animData:AnimData;
	public var segments:Array<PathSegment>;
	public var segmentMap:Map<String, PathSegment>;
	public var totals:Array<{cellIdx:Int, amount:Int}>;
	public var playerIdx:Int;
	public var bouncing:Array<Int>;
}
  
@:structInit
class FrameData { // extends FrameViewData { //, FrameInfo
	// from FrameViewData
	public var scores:Array<Int>;
	public var events:Array<EventData>;
	public var messages:Array<String>;
	public var beacons:Array<Array<Int>>;
	// from FrameInfo
	public var number:Int;
	public var frameDuration:Int;
	public var date:Int;

	public var previous:FrameData;
	public var ants:Array<Array<Int>>;
	public var richness:Array<Int>;
	public var syntheticEvents:Array<AggregatedPathsEvent>;
	public var buildAmount:Array<Array<Int>>;
	public var antTotals:Array<Int>;
	public var consumedFrom:Array<Map<Int, Bool>>;
}
  
// @:structInit
// class CoordDto {
// 	public var x:Int;
// 	public var y:Int;
// }
  
@:structInit
class GlobalDataDto {
	public var cells:Array<CellData>;
}

@:structInit
class GlobalData extends GlobalDataDto {
	public var players:Array<PlayerInfo>;
	public var playerCount:Int;
	public var anthills:Array<Array<Int>>;
	public var maxScore:Int;
}
  
@:structInit
class AnimData {
	public var start:Float;
	public var end:Float;
}
  
@:structInit
class Effect<T> {
	public var busy:Bool;
	public var display:T;
}
  
/* View entities */
@:structInit
class Hex {
	public var container:Container;
	public var data:CellData;
	public var texts:Array<Text>;
	public var indicators:Array<Sprite>;
	public var foodText:Text;
	public var foodTextBackground:Sprite;
	public var icon:Sprite;
	public var iconBounceContainer:Container;
	public var bouncing:Bool;
	public var indicatorLayer:Container;
}

@:structInit
class Tile {
	public var container:Container;
	public var sprite:Tile;
}
  
@:structInit
class AntParticleGroup {
	public var particles:Array<AntParticle>;
	public var fromIdx:Int;
	public var toIdx:Int;
	public var cellIdx:Int;
	public var playerIdx:Int;
	public var animData:AnimData;
}
  
@:structInit
class AntParticle {
	public var offset:Point;
	public var random:Int;
	public var direction:Int;
	public var sprite:Tile;
	public var placed:Bool;
}
  
@:structInit
class SfxData {
	public var angle:Int;
	public var speed:Int;
	public var size:Int;
	public var deathAt:Int;
}
  
@:structInit
class Explosion extends AnimData {
	public var cellIdx:Int;
	public var data:Array<SfxData>;
}