//Extends the Enemy class with special functions for the Red enemy.

package
{
	import flash.text.TextField;
	public class RedEnemy extends Enemy
	{
		public function RedEnemy()
		{
			super();
		}
		
		
		// moves the up and down position to follow the Player
		public function followAvatar( target ):void
		{
			if ( target.y > y )
			{
				y = y + 1;
			}
			if ( target.y < y )
			{
				y = y - 1;
			}
		}
	}
}