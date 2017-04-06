//Class defines Player's health rate and updates display.

package
{
	import flash.text.TextField;
	public class HealthMeter extends Counter
	{
		public function HealthMeter()
		{
			super();
		}
		
		//Resets health to 100 for start of game.
		override public function reset():void
		{
			currentValue = 100;
			updateDisplay();
		}
		
		//Updates health display.
		override public function updateDisplay():void
		{
			super.updateDisplay();
			healthDisplay.text = currentValue.toString();
		}
	}
}