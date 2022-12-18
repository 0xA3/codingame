package gameengine.core;

interface Module {
    /**
     * Called by the game manager after calling the <code>Referee</code>'s init method.
     *
     * The module must be registered to the game manager.
     */
	 function onGameInit():Void;

	 /**
	  * Called by the game manager after calling the <code>Referee</code>'s gameTurn method.
	  *
	  * The module must be registered to the game manager.
	  */
	 function onAfterGameTurn():Void;
 
	 /**
	  * Called by the game manager after calling the <code>Referee</code>'s onEnd method.
	  *
	  * The module must be registered to the game manager.
	  */
	 function onAfterOnEnd():Void;
}