package gameplayer;

import gameplayer.view.ClickButton;
import gameplayer.view.Slider;
import gameplayer.view.SwitchButton;
import h2d.Bitmap;
import h2d.Object;

class GameplayerLibrary {

	public var gameplayerContainer:Object;
	public var gameplayerBackground:Object;
	
	public var bRewind:ClickButton;
	public var bPrev:ClickButton;
	public var bPlay:SwitchButton;
	public var bNext:ClickButton;
	public var bEnd:ClickButton;

	public var handle:Bitmap;

	public var sliderContainer:Object;
	public var slider:Slider;

	public function new() {}

	public function verify() {
		final fieldNames = Type.getInstanceFields( GameplayerLibrary );
		for( fieldName in fieldNames ) {
			if( Reflect.field( this, fieldName ) == null ) throw 'Error: $fieldName is null';
		}
	}

}