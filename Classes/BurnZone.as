//Creates class for the RHR.
package
{
	import flash.display.MovieClip;
	public class BurnZone extends MovieClip
	{
		public function BurnZone()
		{
			
		}
		
		//Moves the RHR down the stage.
		public function moveZone( yDistance:Number ):void
		{
			y += yDistance
		}
	}
}