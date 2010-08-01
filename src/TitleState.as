package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class TitleState extends FlxState
	{
		//title
		public var titleGrp:FlxGroup;
				
		
		//replaced later by functionality
		public var sndbx:FlxGroup;
		public var lvlsel:FlxGroup;
		
		public function TitleState() 
		{
			super();
			FlxG.mouse.show();
			FlxG.volume = 1;
			FlxState.bgColor = 0xff000000;
			titleGrp = new FlxGroup();
			
			lvlsel = new FlxGroup();
			sndbx = new FlxGroup();
		}
		override public function create():void 
		{
			var x:Number = FlxG.width / 2;
			var y:Number = FlxG.height / 2;
			var w:uint = FlxG.width;
			var h:uint = FlxG.height;
			
				//the title
			titleGrp.add((new FlxText(0, 10, w, "YOU WIN") as FlxText).setFormat(null, 16, 0xffffff, "center"), true);
			/*titleGrp.add(new FlxButton(x -50,  y-25, function():void { 	//FlxG.log("to instructions");
																	FlxG.state = new instructState(); 
																	}));
			(titleGrp.add(new FlxText(x - 50,  y-25, 100, "Instructions")) as FlxText).setFormat(null, 8, 0xcccccc, "center");
			
			titleGrp.add(new FlxButton(x - 50, y + 15, function():void { 	//FlxG.log("to difficulty");
																	FlxG.state = new difficultyState();
																	//FlxG.state = new GameState();
																	}));
			(titleGrp.add(new FlxText(x-50, y+15, 100, "Play")) as FlxText).setFormat(null, 8, 0xcccccc, "center");
			*/
			this.add(titleGrp);
			
			
			
			
		}
		
	}

}