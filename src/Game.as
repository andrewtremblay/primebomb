package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	import org.flixel.*;
	[SWF(width = "800", height = "500", backgroundColor = "#0FFFFF")]
	
	public class Game extends FlxGame
	{
		public var level:Number; //keeps track of the levels that the player has completed
		public function Game():void
		{
			//override the default pause screen with our custom one
			//super(400, 250, TitleState, 2);
			//super(400, 250, instructState, 2);
			//super(400, 250, levelSelectState, 2);
			super(400, 250, GameState, 2); //Create a new FlxGame object at 400x400 with 2x pixels, then load PlayState
			//this.useDefaultHotKeys = false;
			this.pause = new Editor();
			//super(300, 250, TEST_InputText, 2); //Test out the Input
		}
		
	}

}