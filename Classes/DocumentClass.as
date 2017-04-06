//Main class for Flash document. Loads other classes into game.

package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class DocumentClass extends MovieClip
	{
		public var menuScreen:MenuScreen;
		public var gameScreen:GameScreen;
		public var gameOverScreen:GameOverScreen;
		
		public function DocumentClass() 
		{
			menuScreen = new MenuScreen();
			menuScreen.addEventListener( NavigationEvent.START, onRequestStart );
			menuScreen.x = 0;
			menuScreen.y = 0;
			addChild( menuScreen );
		}
		
		public function onRequestStart( navigationEvent:NavigationEvent ):void
		{
			gameScreen = new GameScreen();
			gameScreen.x = 0;
			gameScreen.y = 0;
			gameScreen.addEventListener( NavigationEvent.GAMEOVER, gameOver );
			addChild( gameScreen );
			
			menuScreen = null;
		}
		
		//Ends game and loads "Game Over" screen with final score.
		public function gameOver( navigationEvent:NavigationEvent ):void
		{
			var finalScore:Number = gameScreen.getFinalScore();
			
			gameOverScreen = new GameOverScreen();
			gameOverScreen.addEventListener( NavigationEvent.RESTART, onRequestRestart );
			gameOverScreen.x = 0;
			gameOverScreen.y = 0;
			gameOverScreen.setFinalScore( finalScore );
			addChild( gameOverScreen );
			
			gameScreen = null;
		}
		
		public function onRequestRestart( navigationEvent:NavigationEvent ):void
		{
			menuScreen = new MenuScreen();
			menuScreen.addEventListener( NavigationEvent.START, onRequestStart );
			menuScreen.x = 0;
			menuScreen.y = 0;
			addChild( menuScreen );
			
			gameOverScreen = null;
		}
		
	}
	
	
}