package viewer;

import h2d.Object;
import h2d.Text;

class HeroView extends CharacterView {

	final textField:Text;

	public function new( container:Object, infoContainer:Object, object:Object, angleOffset:Float, textField:Text ) {
		super( container, infoContainer, object, angleOffset );
		this.textField = textField;
	}

	public function setMessage( message:String ) {
		if( message == "" ) {
			infoContainer.visible = false;
		}
		textField.text = message;
		infoContainer.visible = true;
	}
}