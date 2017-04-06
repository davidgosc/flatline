package
{
	import flash.display.MovieClip;

	public class Red extends MovieClip
	{
		
		public function Red( startX:Number, startY:Number )
		{
			x = startX;
			y = startY;
		}
		
		public function moveEnemyLeft():void
		{
			x = x - 5;
		}
		
		public function followTarget( target ):void
		{
			if ( y < target.y )
			{
				y = y + 2;
			}
			if ( y > target.y )
			{
				y = y - 2;
			}
		}
	}
}