package resources.view;

import gameengine.view.core.Constants.HEIGHT;
import gameengine.view.core.Point;
import h2d.Font;
import h2d.Graphics;
import h2d.Interactive;
import hxd.Event;
import resources.view.pixi.Container;
import resources.view.pixi.Text;

class TooltipManager {
	
	static final PADDING = 5;
	static final CURSOR_WIDTH = 20;

	final fonts:Fonts;
	
	var tooltip:Container;
	var tooltipContainer:Container;
	var tooltipLabel:Text;
	var tooltipBackground:Graphics;
	var tooltipOffset:Float;
	var registry:Array<{element:Interactive, getText:()->String}>;
	var inside:Map<Int,Bool>;
	dynamic function getGlobalText( data:Event ) { return "not registered"; }
	var lastEvent:hxd.Event;

	function generateText( text:String, color:Int, font:Font, align:String ) {
		final textEl = new Text( font );
		textEl.textColor = color;

		if( align == "right" ) {
			textEl.anchor.x = 1;
		} else if (align == "center" ) {
			textEl.anchor.x = 0.5;
		}

		return textEl;
	}

	public function new( fonts:Fonts ) {
		this.fonts = fonts;
	}

	public function reinit() {
		final container = new Container();
		final tooltip = new Container();
		final background = new Graphics();
		final label = generateText( "DEFAULT", 0xffffff, fonts.lato_bold_30, "left" );

		label.position.x = PADDING;
		label.position.y = PADDING;

		tooltip.visible = false;
		tooltip.addChild(background);
		tooltip.addChild(label);
		this.tooltipBackground = background;
		this.tooltipLabel = label;
		this.tooltipContainer = container;
		this.tooltip = tooltip;
		this.registry = [];
		this.inside = [];
		this.tooltipOffset = 0;
		this.getGlobalText = null;
	
		container.addChild( tooltip );
		return container;
	}

	public function clear() inside.clear();

	public function registerGlobal( getText:( data:Dynamic )->String ) {
		getGlobalText = getText;
	}

	public function register( element:Interactive, getText:()->String ) {
		final registryIdx = registry.length;
		registry.push({ element: element, getText: getText });
		element.onOver = ( e ) -> inside.set( registryIdx, true );
		element.onOut = ( e ) -> inside.remove( registryIdx );
	}

	public function showTooltip( text:String ) {
		setTooltipText( tooltip, text );
	}

	function setTooltipText( tooltip:Container, text: String ) {
		tooltipLabel.text = text;
	
		final bounds = tooltipLabel.getBounds();
		final width = bounds.width + PADDING * 2;
		final height = bounds.height + PADDING * 2;
	
		tooltipOffset = -width;
	
		tooltipBackground.clear();
		tooltipBackground.beginFill( 0 );
		tooltipBackground.drawRect(0, 0, width, height);
		tooltipBackground.endFill();
	
		tooltip.visible = true;
	}

	public function updateGlobalText() {
		if( lastEvent != null ) moveTooltip( lastEvent );
	}

	function moveTooltip( event:Event ) {
		lastEvent = event;
	
		final newPosition:Point = { x: event.relX, y: event.relY }
	
		var xOffset = tooltipOffset - 20;
		var yOffset = 40.;
	
		if( newPosition.x + xOffset < 0 ) {
			xOffset = CURSOR_WIDTH;
		}
	
		final bounds = tooltip.getBounds();
		if( newPosition.y + bounds.height > HEIGHT ) {
			yOffset = HEIGHT - newPosition.y - bounds.height;
		}
	
		tooltip.x = newPosition.x + xOffset;
		tooltip.y = newPosition.y + yOffset;
	
		final textBlocks:Array<String> = [];
		for( key in inside.keys() ) {
			var registryIdx = key;
			var getText = this.registry[registryIdx].getText;
	
			var text = getText();
			if( text != null && text.length > 0 ) {
				textBlocks.push(text);
			}
		}
	
		if( getGlobalText != null ) {
			var text = getGlobalText( event );
			if( text != null && text.length > 0 ) {
				textBlocks.push(text);
			}
		}
		if( textBlocks.length > 0 ) {
			showTooltip( textBlocks.join( '\n--------\n' ));
		} else {
			hideTooltip();
		}
	}

	function hideTooltip() {
		tooltip.visible = false;
	}
}