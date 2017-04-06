//Defines the class for the Player's score with update and reset functions.

package
{
	import flash.text.TextField;
	public class Score extends Counter
	{
		public function Score()
		{
			super();
		}
		
		//Reset score to 0
		override public function reset():void
		{
			currentValue = 0;
			updateDisplay();
		}
		
		//update the Score display to the current value.
		override public function updateDisplay():void
		{
			super.updateDisplay();
			scoreDisplay.text = currentValue.toString();
		}
	}
}