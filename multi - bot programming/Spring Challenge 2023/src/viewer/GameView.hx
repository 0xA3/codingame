package viewer;

import h2d.Object;
import h2d.Scene;
import view.FrameViewData;

class GameView {
	
	final s2d:Scene;

	public final scene:Object;

	public function new( s2d:Scene, scene:Object ) {
		this.s2d = s2d;
		this.scene = scene;
	}

	public function init( player1:String, player2:String ) {
	}

	public function initGrid( gridWidth:Int, gridHeight:Int ) {
	}

	public function update( frame:Float, intFrame:Int, subFrame:Float, frameDatasets:Array<FrameViewData> ) {
	}

	public function updateFrame( frame:Int, currentFrameData:FrameViewData ) {
	}



	public function mouseOver( screenX:Float, screenY:Float, currentFrameData:FrameViewData ) {
	}

	public function mouseOut() {
	}
}