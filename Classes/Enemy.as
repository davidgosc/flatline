//Defines class for enemies.

package
{
	import flash.display.MovieClip;

	public class Enemy extends MovieClip
	{
		//Set's enemy's stage spawn position.
		public function Enemy( startX:Number, startY:Number )
		{
			x = startX;
			y = startY;
		}
		
		//Moves enemy across stage at a set speed.
		public function moveEnemyLeft( moveSpeed ):void
		{
			x = x - moveSpeed;
		}
		
		
		//Basic AI function to follow target's Y position (up/down) on stage
		public function followTarget( target ):void
		{
			if ( y < target.y )
			{
				y = y + 1;
			}
			if ( y > target.y )
			{
				y = y - 1;
			}
		}
	}
}