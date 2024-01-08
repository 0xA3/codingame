package types;

import h2d.Anim;
import h2d.Bitmap;

/* View entities */
@:structInit
class Tile {
	public final baseScale:Float;
	public var sprite:h2d.Bitmap;
	public final overlay:h2d.Bitmap;
	public final cracks:Array<h2d.Bitmap>;
	public final border:h2d.Bitmap;
	public final recycleFx:Anim;
}