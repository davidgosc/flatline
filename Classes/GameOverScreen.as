package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class GameOverScreen extends MovieClip
	{
		public function GameOverScreen()
		{
			restartButton.addEventListener( MouseEvent.CLICK, onClickRestart );
		}
		
		public function setFinalScore( scoreValue:Number ):void
		{
			finalScore.text = scoreValue.toString();
		}
		
		public function onClickRestart( event:MouseEvent ):void
		{
			dispatchEvent( new NavigationEvent( NavigationEvent.RESTART ) );
		}
		
	}
}