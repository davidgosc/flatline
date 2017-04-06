
//Loads player movieclip onto stage
package
{
	import flash.display.MovieClip;
	public class Avatar extends MovieClip
	{
		public function Avatar()
		{
			
		}
		
		// Moves player across the stage
		public function moveABit( xDistance:Number, yDistance:Number ):void
		{
			// Change baseSpeed to change player speed in both x and y.
			var baseSpeed:Number = 5;
			x += ( xDistance * baseSpeed );
			y += ( yDistance * baseSpeed );
		}
	}
}