package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class Editor extends FlxGroup
	{
		
		[Embed(source="menuData/key_minus.png")] private var ImgKeyMinus:Class;
		[Embed(source="menuData/key_plus.png")] private var ImgKeyPlus:Class;
		[Embed(source="menuData/key_0.png")] private var ImgKey0:Class;
		[Embed(source="menuData/key_p.png")] private var ImgKeyP:Class;

		
			public var hintShow:FlxButton;
			public var gHint:FlxText;
			protected var hintText:ListOfHints;
			public var hint_array:Array;
			public var hint_i:Number;
		/**
		 * Constructor.
		 */
		public function Editor() 
		{
			
			super();
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			var w:uint = FlxG.width;
			var h:uint = FlxG.height;
			var _x:Number = (FlxG.width)/2;
			var _y:Number = (FlxG.height)/2;
			add((new FlxSprite()).createGraphic(w,h,0xee000000,true),true);			
			(add(new FlxText(0,10,w,"this game is named"),true) as FlxText).alignment = "center";
			add((new FlxText(0, 20, w, "PRIME BOMB")).setFormat(null, 16, 0xffffff, "center"), true);
			//add(new FlxSprite(x+4,y+36,ImgKeyP),true);
			
			add(new FlxText(_x -40, _y - 56, w - 16, "M : Start/Stop Music "), true);
			add(new FlxText(_x -40, _y - 46, w - 16, "P : unPause Game"), true);
			add(new FlxText(_x -40, _y - 36, w - 16, "Q : Shoot"), true);
			add(new FlxText(_x -40, _y - 26, w - 16, "A : Fire Prime Bomb"), true);
			add(new FlxText(_x -40, _y - 16, w - 16, "L : Go to Level Select Screen"), true);
			add(new FlxText(_x -40, _y - 6,  w - 16, "T : Go to Title Screen"), true);
			add(new FlxText(_x -40, _y + 4,  w - 16, "H : Cycle Hints (Pause Only)"), true);
			
			
			//load hint portion of GUI
			gHint = new FlxText(30, FlxG.height - 22, 300, "");
			hintText = new ListOfHints();
			hint_array = hintText.toString().split("\n");
			hint_i = 0;
			add(gHint);
		}
		
		
		override public function update():void 
		{
			if(FlxG.keys.justPressed("H") ){
					cycleHints();
				}
			if(FlxG.keys.justPressed("L") ){
					FlxG.state = new levelSelectState();
				}
			if(FlxG.keys.justPressed("T") ){
					FlxG.state = new TitleState();
				}
		}
		
		private function cycleHints():void {
			//equation checking logic goes here
			//when it checks out, submit to the bullet  
			gHint.text = ((FlxG.state as GameState).hint_array[hint_i] as String);
				hint_i += 1;
				if (hint_i > hint_array.length - 1) {
					hint_i = 0;
				}
		}
		
	}

}