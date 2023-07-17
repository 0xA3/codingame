package viewer;

import h2d.Object;
import h2d.Text;
import h2d.Tile;
import viewer.Utils.Point;

/**
 * Given by the SDK
 */
@:StructInit class FrameInfo {
	public var number:Int;
	public var frameDuration:Int;
	public var date:Int;
}
  /**
   * Given by the SDK
   */
@:StructInit class CanvasInfo {
	public var width:Int;
	public var height:Int;
	public var oversampling:Int;
}
  /**
   * Given by the SDK
   */
@:StructInit class PlayerInfo {
	public var name:String;
	public var avatar:h2d.Tile;
	public var color:Int;
	public var index:Int;
	public var isMe:Bool;
	public var number:Int;
	public var type = "";
}
  
@:StructInit class EventDto {
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
  
@:StructInit class FrameDataDto {
	public var scores:Array<Int>;
	public var events:Array<EventDto>;
	public var messages:Array<String>;
	public var beacons:Array<Int>;
}
  
@:StructInit class PathSegment {
	public var key:String;
	public var from:Int;
	public var to:Int;
	public var amount:Int;
	public var pathKeys:Map<String, Bool>;
}
  
@:StructInit class AggregatedPathsEvent {
	public var type:Int;
	public var animData:AnimData;
	public var segments:Array<PathSegment>;
	public var segmentMap:Map<String, PathSegment>;
	public var totals:Array<{cellIdx:Int, amount:Int}>;
	public var playerIdx:Int;
	public var bouncing:Array<Int>;
}
  
@:StructInit class FrameData extends FrameDataDto { //, FrameInfo
	public var number:Int;
	public var previous:FrameData;
	public var ants:Array<Int>;
	public var richness:Array<Int>;
	public var syntheticEvents:Array<AggregatedPathsEvent>;
	public var buildAmount:Array<Int>;
	public var antTotals:Array<Int>;
	public var consumedFrom:Map<Int, Bool>;
}
  
@:StructInit class CoordDto {
	public var x:Int;
	public var y:Int;
}
  
@:StructInit class CellDto {
	public var q:Int;
	public var r:Int;
	public var richness:Int;
	public var index:Int;
	public var owner:Int;
	public var type:Int;
	public var ants:Array<Int>;
}
  
@:StructInit class GlobalDataDto {
	public var cells:Array<CellDto>;
}

@:StructInit class GlobalData extends GlobalDataDto {
	public var players:Array<PlayerInfo>;
	public var playerCount:Int;
	public var anthills:Array<Int>;
	public var maxScore:Int;
}
  
@:StructInit class AnimData {
	public var start:Int;
	public var end:Int;
}
  
@:StructInit class Effect<T> {
	public var busy:Bool;
	public var display:T;
}
  
/* View entities */
@:StructInit class Hex {
	public var container:Object;
	public var data:CellDto;
	public var texts:Array<Text>;
	public var indicators:Array<Tile>;
	public var foodText:Text;
	public var foodTextBackground:Tile;
	public var icon:Tile;
	public var iconBounceContainer:Object;
	public var bouncing:Bool;
	public var indicatorLayer:Object;
}

@:StructInit class Tile {
	public var container:Object;
	public var sprite:Tile;
}
  
@:StructInit class AntParticleGroup {
	public var particles:Array<AntParticle>;
	public var fromIdx:Int;
	public var toIdx:Int;
	public var cellIdx:Int;
	public var playerIdx:Int;
	public var animData:AnimData;
}
  
@:StructInit class AntParticle {
	public var offset:Point;
	public var random:Int;
	public var direction:Int;
	public var sprite:Tile;
	public var placed:Bool;
}
  
@:StructInit class SfxData {
	public var angle:Int;
	public var speed:Int;
	public var size:Int;
	public var deathAt:Int;
}
  
@:StructInit class Explosion extends AnimData {
	public var cellIdx:Int;
	public var data:Array<SfxData>;
}