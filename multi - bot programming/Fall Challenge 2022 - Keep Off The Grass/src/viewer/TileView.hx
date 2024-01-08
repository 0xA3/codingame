package viewer;

import h2d.Bitmap;
import h2d.Object;

@:structInit
class TileView {
	public var container:Object;
	public var spriteContainer:Object;
	public var tileId:Int;
	public var sprite:Bitmap;
	public var overlay:Bitmap;
	public var border:Bitmap;
	public var cracks:Array<Bitmap>;
}