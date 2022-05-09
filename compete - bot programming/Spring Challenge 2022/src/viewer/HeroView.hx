package viewer;

import h2d.Object;
import h2d.Text;

class HeroView extends CharacterView {

	final textField:Text;

	public function new( container:Object, infoContainer:Object, object:Object, textField:Text ) {
		super( container, infoContainer, object );
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