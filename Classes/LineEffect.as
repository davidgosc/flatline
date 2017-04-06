//Class creates player "tail" for Heart Rate Monitor effect.

package
{
	import flash.display.MovieClip;
	
	public class LineEffect extends MovieClip
	{
		
		public function LineEffect( startX:Number, startY:Number )
		{
			x = startX;
			y = startY;
		}
		
		public function moveLine():void
		{
			x = x - 5;
		}
	}
}