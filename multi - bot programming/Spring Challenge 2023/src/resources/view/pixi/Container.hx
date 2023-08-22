package resources.view.pixi;

import h2d.Object;

class Container extends Object {

	public final position:ContainerPosition;

	public var sortableChildren = false;
	public var zIndex = 0;
	
	public function new( ?parent : Object ) {
		super( parent );
		position = new ContainerPosition( this );
	}
}

class ContainerPosition {

	final container:Container;

	public function new( container:Container ) {
		this.container = container;
	}

	public function set( x:Float, y:Float ) {
		container.setPosition( x, y );
	}
}