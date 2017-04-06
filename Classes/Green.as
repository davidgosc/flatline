//Class defines the green powerup.

package
{
	import flash.display.MovieClip;

	public class Green extends MovieClip
	{
		
		public function Green( startX:Number, startY:Number )
		{
			x = startX;
			y = startY;
		}
		
		//Moves the powerup left across the stage.
		public function moveEnemyLeft():void
		{
			x = x - 5;
		}
	}
}