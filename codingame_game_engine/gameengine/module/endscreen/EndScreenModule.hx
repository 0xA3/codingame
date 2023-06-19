package gameengine.module.endscreen;

import gameengine.core.Module;
import gameengine.core.GameManager;

class EndScreenModule implements Module {
	
	final gameManager:GameManager;
	var scores:Array<Int> = [];
	var displayedText:Array<String> = [];
	var titleRankingsSprite = "logo.png";

	public function new( gameManager:GameManager ) {
		this.gameManager = gameManager;
	}

    /**
     * Send scores to the module
     *
     * @param scores
     *            the scores of the different players, the index matches the player.getIndex()
     */
	 public function setScores( scores:Array<Int> ) {
        this.scores = scores;
    }

    /**
     * Send scores to the module
     *
     * @param scores
     *            the scores of the different players, the index matches the player.getIndex()
     * @param displayedText
     *            the text displayed instead of the score of a player, if null or empty string for a player the score will still be displayed
     *
     */
    public function setScoresAndDisplayedText( scores:Array<Int>, displayedText:Array<String> ) {
        this.scores = scores;
        this.displayedText = displayedText;
    }

    /**
     * Allows you to set the sprite used as the title of the ranking board
     *
     * @param spriteName
     *            the name of the sprite you want to use default is "logo.png"
     */
    public function setTitleRankingsSprite( spriteName:String ) {
        titleRankingsSprite = spriteName;
    }

    /**
     *
     * @return the name of the sprite that will be used as the title of the ranking board
     */
    public function getTitleRankingsSprite() {
        return titleRankingsSprite;
    }

    public function onGameInit() {
    }

    public function onAfterGameTurn() {
    }

    public function onAfterOnEnd() {
        final data = { scores: scores, titleRankingsSprite: titleRankingsSprite, displayedText: displayedText };
        gameManager.setModuleViewData( "endScreen", data );
    }
}