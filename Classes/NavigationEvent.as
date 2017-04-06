//Defines the navigation event to set the current game state. Used by buttons in menu options.

package
{
	import flash.events.Event;
	public class NavigationEvent extends Event
	{
		public static const RESTART:String = "restart";
		public static const START:String = "start";
		public static const GAMEOVER:String = "gameover";
		
		public function NavigationEvent( type:String )
		{
			super( type );
		}
	}
}