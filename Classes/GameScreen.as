package
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class GameScreen extends MovieClip
	{
		public var army:Array; //declares array for Enemy movie clips
		public var graphLine:Array; //declares array for Heart Monitor effect
		public var redArmy:Array; //declares array for special Red enemies
		public var greenArmy:Array; //declares array for green powerups
		public var avatar:Avatar; //declares player icon
		public var avatarBackground:AvatarBackground;
		public var gameTimer:Timer; //Sets frame rate
		public var clockTimer:Timer; //Sets clock at 1 second
		public var useMouseControl:Boolean; //Whether mouse is being used to control player.
		public var downKeyIsBeingPressed: Boolean; //Defines player movement in Y position
		public var upKeyIsBeingPressed:Boolean; //Defines player movement in -Y position
		public var leftKeyIsBeingPressed:Boolean; //Defines player movement in -X position
		public var rightKeyIsBeingPressed:Boolean; //Defines player movement in X position
		public var burnZone:BurnZone; //Declares Resting Heart Rate bar
		public var burnRate:Number; //Declares varible for how fast the Resting Heart Rate is moving
		public var gameScreenMask:GameScreenMask;
		public var heIsDeadJim:Boolean; //declares whether player has died
		public var enemyMovementSpeed:int; //Declares the variable that controls enemy movement speed
		public var lossRate:int;
		public var penaltyTime:int;
		public var bonusTime:int;
		public var bonusIsOn:Boolean;
		public var heartGraphic:HeartGraphic;
		
		public function GameScreen()
		{
			useMouseControl = false;
			downKeyIsBeingPressed = false;
			upKeyIsBeingPressed = false;
			leftKeyIsBeingPressed = false;
			rightKeyIsBeingPressed = false;
			heIsDeadJim = false;
			
			penaltyTime = 0;
			bonusTime = 0;
			bonusIsOn = false; //Sets whether the power up is on, should be off by default
			enemyMovementSpeed = 5; //Sets the speed that enemies move across the screen in -x direction
			
			army = new Array;
			//var newEnemy = new Enemy( 720, 240 );
			//army.push( newEnemy );
			//addChild( newEnemy );
			
			graphLine = new Array;
			//var linePoint = new LineEffect( 50, 240 );
			//graphLine.push( linePoint );
			//addChild( linePoint );
			
			redArmy = new Array;
			
			greenArmy = new Array;
			
			avatar = new Avatar(); //determines the avatar's hittest area
			addChild( avatar );
			if ( useMouseControl )
			{
				avatar.x = mouseX;
				avatar.y = mouseY;
			}
			else
			{
				avatar.x = 50
				avatar.y = 240
			}
			
			avatarBackground = new AvatarBackground(); //creates the outerglow around the avatar
			addChild( avatarBackground );
			avatarBackground.x = avatar.x;
			avatarBackground.y = avatar.y;
			
			burnZone = new BurnZone();
			addChildAt( burnZone, 3 );
			burnZone.x = 0;
			burnZone.y = 0;
			
			gameScreenMask = new GameScreenMask();
			addChild( gameScreenMask );
			
			heartGraphic = new HeartGraphic();
			addChild( heartGraphic );
			heartGraphic.x = 34;
			heartGraphic.y = 8;
			
			gameTimer = new Timer( 25 ); //ticks the game every 25 milliseconds
			gameTimer.addEventListener( TimerEvent.TIMER, onTick );
			gameTimer.start();
			
			clockTimer = new Timer( 1000 ); //updates the clock every 1 second
			clockTimer.addEventListener( TimerEvent.TIMER, onClock );
			clockTimer.start();
			
			var lossRate = 1;
			
			addEventListener( Event.ADDED_TO_STAGE, onAddToStage );
		}
		public function createLineEffect( frameNumber:Number ) //creates the graph line effect
		{
			var linePoint:LineEffect = new LineEffect( avatar.x, avatar.y );
			graphLine.push( linePoint );
			addChildAt( linePoint, 4 );
			linePoint.gotoAndStop( frameNumber );
		}
		
		public function onClock( timerEvent:TimerEvent ):void //changes the Health meter, changes Game Over
		{
			if ( avatar.y < burnZone.y ) //burnzone goes up
			{
				if ( penaltyTime > 0 )
				{
					gameScreenMask.healthMeter.addToValue( -lossRate * 2 );
					lossRate++;
				}
				
				else //burnzone goes down
				{
					gameScreenMask.healthMeter.addToValue( -lossRate );
					lossRate++;
				}
			}
			
			else
			{
				if ( gameScreenMask.healthMeter.currentValue < 100 )
				{
					lossRate = 1;
					gameScreenMask.healthMeter.addToValue( lossRate );
				}
			}
			
			if ( gameScreenMask.healthMeter.currentValue <= 0 )
			{
				gameScreenMask.healthMeter.currentValue = 0;
				heIsDeadJim = true;
				onDeath();
			}
			if ( ( penaltyTime > 0 ) || ( bonusTime > 0 ) )
				{
					if ( penaltyTime > 0 )
					{
						penaltyTime = penaltyTime - 1;
					}
					if ( penaltyTime == 0 )
					{
					}
					if ( bonusTime > 0 )
					{
						bonusTime = bonusTime - 1;
					}
					if ( bonusTime == 0 )
					{
						bonusIsOn = false;
					}
				}
			else
			{
				heartGraphic.gotoAndStop( 1 );
			}
			
		}
		public var spawnRate = 0.01
		
		public function onDeath()
			{
				gameTimer.stop();
				clockTimer.stop();
				dispatchEvent( new NavigationEvent( NavigationEvent.GAMEOVER ) );
			}
		
		public function onTick( timerEvent:TimerEvent ):void //runs this on every game tick
		{
			/*if ( heIsDeadJim == true )
			{
				onDeath();
			}*/
			
			if ( Math.random() < spawnRate ) //sets the enemy random spawn rate
			{
				var randomY:Number = ( Math.random() * 430 ) + 50; //randomizes enemy start position in the Y axis
				var newEnemy:Enemy = new Enemy( 800, randomY );
				army.push( newEnemy );
				addChildAt( newEnemy, 2 );
			}
			
			if ( Math.random() < 0.005 ) //red enemy spawning
			{
				if ( gameScreenMask.gameScore.currentValue > 10000 ) //only spawns after the player's score reaches 10,000
				{
					var randomY2:Number = ( Math.random() * 430 ) + 50;
					var redEnemy:Red = new Red( 800, randomY2 );
					redArmy.push( redEnemy );
					addChildAt( redEnemy, 2 );
				}
			}
			
			if ( Math.random() < 0.0005 ) //bonus spawning
			{
				if ( gameScreenMask.gameScore.currentValue > 5000 ) //only spawns the bonus if the player has enough points to purchase it
				{
					var randomY3:Number = ( Math.random() * 430 ) + 50;
					var greenBonus:Green = new Green( 800, randomY3 );
					greenArmy.push( greenBonus );
					addChildAt( greenBonus, 2 );
				}
			}
			
			if ( Math.random() < 0.01 )
			{
				spawnRate = spawnRate + 0.001;
			}
			
			if ( useMouseControl )
			{
				avatar.x = mouseX;
				avatar.y = mouseY;
			}
			else
			{
				if ( downKeyIsBeingPressed )
				{
					avatar.moveABit( 0, 1 );
					createLineEffect( 2 );
				}
				else if ( upKeyIsBeingPressed )
				{
					avatar.moveABit( 0, -1 );
					createLineEffect( 3 );
				}
				else if ( leftKeyIsBeingPressed )
				{
					avatar.moveABit( -1, 0 );
				}
				else if ( rightKeyIsBeingPressed )
				{
					avatar.moveABit( 1, 0 );
					createLineEffect( 4 );
				}
				else
				{
					createLineEffect( 1 );
				}
			}
			
			//check the avatar's position here and move here if the player is moving out of bounds
			
			if ( avatar.x < 15 )
			{
				avatar.x = 15;
			}
			if ( avatar.x > 705 )
			{
				avatar.x = 705;
			}
			if( avatar.y < 55 )
			{
				avatar.y = 55;
			}
			if( avatar.y > 465 )
			{
				avatar.y = 465;
			}
			
			if ( burnZone.y <= 480 ) //moves the burnZone
			{
				if ( avatar.y > (burnZone.y - 10)  )
				{
					burnZone.moveZone( 0.2 );
				}
				else if ( avatar.y < (burnZone.y - 10) )
				{
					burnRate = (burnZone.y - avatar.y) * -0.01;
					burnZone.moveZone( burnRate );
				}
			}
			else
			{
				burnZone.y = 480;
			}
			
			avatarBackground.x = avatar.x;
			avatarBackground.y = avatar.y;
						
			/*var linePoint:LineEffect = new LineEffect( avatar.x, avatar.y );
			graphLine.push( linePoint );
			addChild( linePoint );*/
			
			for each ( var linePoint:LineEffect in graphLine )
			{
				linePoint.moveLine();
			}
			
			/*for each ( var newEnemy:Enemy in army ) //old enemy moving code
			{
				newEnemy.moveEnemyLeft();
				
				if (newEnemy.hitTestObject(avatar))
				{
					burnZone.moveZone( 5 );
				}
			}
			*/
			
			var i:int = army.length - 1;
			while ( i > -1 )
			{
				newEnemy = army[i];
				newEnemy.moveEnemyLeft(enemyMovementSpeed);
				if ( bonusIsOn == false ) //Toggles if the player has the bonus active to turn off enemy collision
				{
					if ( avatar.hitTestObject( newEnemy ) ) //removes enemy on collision, penalizes playyer
					{
						burnZone.moveZone( 30 );
						removeChild( newEnemy );
						army.splice( i, 1 );
					}
				}
				if ( newEnemy.x < -50 ) //removes enemy when off-screen, adds to score
				{
					removeChild( newEnemy );
					army.splice( i, 1 );
					gameScreenMask.gameScore.addToValue( 100 );
				}
				
				i = i - 1;
			}
			
			var k:int = redArmy.length - 1;
			while ( k > -1 )
			{
				redEnemy = redArmy[k];
				redEnemy.moveEnemyLeft();
				redEnemy.followTarget( avatar );
				if ( bonusIsOn == false )
				{
				if ( avatar.hitTestObject( redEnemy ) ) //removes enemy on collision, penalizes player
					{
						penaltyTime = 10;
						burnZone.moveZone( 30 );
						removeChild( redEnemy );
						redArmy.splice( k, 1 );
						heartGraphic.gotoAndPlay( 12 );
					}
				}
				if ( redEnemy.x < -50 ) //removes enemy when off-screen, adds to score
				{
					removeChild( redEnemy );
					redArmy.splice( k, 1 );
					gameScreenMask.gameScore.addToValue( 500 );
				}
				
				k = k - 1;
			}
			
			var l:int = greenArmy.length - 1;
			while ( l > -1 )
			{
				greenBonus = greenArmy[l];
				greenBonus.moveEnemyLeft();
				if ( avatar.hitTestObject( greenBonus ) ) //detects collision of bonus item
				{
					bonusTime = 10;
					bonusIsOn = true;
					penaltyTime = 0;
					burnZone.y = 50;
					gameScreenMask.healthMeter.currentValue = 99;
					gameScreenMask.gameScore.addToValue( -5000 );
					if ( gameScreenMask.gameScore.currentValue < 0 )
					{
						gameScreenMask.gameScore.currentValue = 0;
					}
					removeChild( greenBonus );
					greenArmy.splice( l, 1 );
					heartGraphic.gotoAndPlay( 2 );
				}
				
				if ( greenBonus.x < -50 ) //removes enemy when off-screen, adds to score
				{
					removeChild( greenBonus );
					greenArmy.splice( l, 1 );
				}
				
				l = l - 1;
			}
			
			var j:int = graphLine.length - 1;
			while ( j > -1 )
			{
				linePoint = graphLine[j];
				if (linePoint.x < -20 )
				{
					removeChild( linePoint );
					graphLine.splice( j, 1 );
				}
				j = j - 1;
			}

		}
		
		public function onKeyPress( keyboardEvent:KeyboardEvent ):void //Player movement with arrows or WASD
		{
			if ( (keyboardEvent.keyCode == Keyboard.DOWN) || (keyboardEvent.keyCode == Keyboard.S) )
			{
				downKeyIsBeingPressed = true;
			}
			else if ( (keyboardEvent.keyCode == Keyboard.UP) || (keyboardEvent.keyCode == Keyboard.W) )
			{
				upKeyIsBeingPressed = true;
			}
			else if ( (keyboardEvent.keyCode == Keyboard.LEFT) || (keyboardEvent.keyCode == Keyboard.A))
			{
				leftKeyIsBeingPressed = true;
			}
			else if ( (keyboardEvent.keyCode == Keyboard.RIGHT) || (keyboardEvent.keyCode == Keyboard.D) )
			{
				rightKeyIsBeingPressed = true;
			}
		
		}
		public function onKeyRelease( keyboardEvent:KeyboardEvent ):void
		{
			if ( (keyboardEvent.keyCode == Keyboard.DOWN) || (keyboardEvent.keyCode == Keyboard.S) )
			{
				downKeyIsBeingPressed = false;
			}
			else if ( (keyboardEvent.keyCode == Keyboard.UP) || (keyboardEvent.keyCode == Keyboard.W) )
			{
				upKeyIsBeingPressed = false;
			}
			else if ( (keyboardEvent.keyCode == Keyboard.LEFT) || (keyboardEvent.keyCode == Keyboard.A) )
			{
				leftKeyIsBeingPressed = false;
			}
			else if ( (keyboardEvent.keyCode == Keyboard.RIGHT) || (keyboardEvent.keyCode == Keyboard.D) )
			{
				rightKeyIsBeingPressed = false;
			}
		
		}
		
		public function getFinalScore():Number
		{
			return gameScreenMask.gameScore.currentValue;
		}
		
		public function onAddToStage( event:Event ):void
		{
			stage.addEventListener( KeyboardEvent.KEY_DOWN, onKeyPress );
			stage.addEventListener( KeyboardEvent.KEY_UP, onKeyRelease );
		}
	}
}