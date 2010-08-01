package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author andrewtremblay	 
	 * */
	public class Help extends FlxGroup
	{
		public function Help(part:Number = 1) 
		{
			super();
			scrollFactor.x = 0;
			scrollFactor.y = 0;
			var w:uint = FlxG.width;
			var h:uint = FlxG.height;
			var _x:Number = (FlxG.width)/2;
			var _y:Number = (FlxG.height) / 2;
			add((new FlxSprite()).createGraphic(w, h, 0x11000000, true), true);		
			
			add((new FlxSprite(_x-123, h-51)).createGraphic(250, 20, 0xff000000, true), true);		
			(add(new FlxText(0, h - 50, w, "Press P to continue"), true) as FlxText).alignment = "center";
			
			switch(part) { //which help screen would you like to display?
				case 0:
				add((new FlxSprite(_x-95, 25)).createGraphic(225, 150, 0xff000000, true), true);		
				(add(new FlxText(_x -95, 35, 225, "THE END"), true) as FlxText).alignment = "center";
				(add(new FlxText(_x -95, 65, 225, "That's the game so far."), true) as FlxText).alignment = "center";
				(add(new FlxText(_x -95, 95, 225, "Thank you for playing!"), true) as FlxText).alignment = "center";
				add((new FlxSprite(_x-123, h-51)).createGraphic(250, 20, 0xff000000, true), true);		
				(add(new FlxText(0, h - 50, w, "Press L to return to level selection screen"), true) as FlxText).alignment = "center";
				break;	
				
				case 1:
				add((new FlxSprite(_x-125, 50)).createGraphic(225, 100, 0xff000000, true), true);		
				(add(new FlxText(_x-w+100, _y - 70, w, "This enemy requires one hit ->"), true) as FlxText).alignment = "right";
				(add(new FlxText(_x-w+100, _y - 25, w, "This enemy requires two hits ->"), true) as FlxText).alignment = "right";
				(add(new FlxText(_x - w + 100, _y + 5, w, "This is not an enemy and cannot be killed ->"), true) as FlxText).alignment = "right";	
				break;	
				
				case 2:
				add((new FlxSprite(_x-95, 25)).createGraphic(225, 150, 0xff000000, true), true);		
				(add(new FlxText(_x -90, _y - 95, w, "Use the equation editor to get as many \nenemies in a single shot as possible."), true) as FlxText);
				(add(new FlxText(_x -80, _y, w, "Here, try this one:"), true) as FlxText);
				(add(new FlxText(_x -20, _y + 20, w, "3x+1"), true) as FlxText);
				break;	
				
				case 666:
				add((new FlxSprite(_x-95, 25)).createGraphic(225, 150, 0xff000000, true), true);		
				(add(new FlxText(_x -90, _y - 95, w, "Uh oh! We're in for it now!\n\n Get ready to dodge with the arrow keys!"), true) as FlxText);
				(add(new FlxText(_x -80, _y, w, ""), true) as FlxText);
				(add(new FlxText(_x -20, _y + 20, w, ""), true) as FlxText);
				break;	
				
				default:
				(add(new FlxText(0, y, w, "ERROR"), true) as FlxText).alignment = "center";
			
				break;
			}
		}
		
		override public function update():void 
		{
			if(FlxG.keys.justPressed("L")) {
				FlxG.state = new levelSelectState();
				FlxG.pause = false;
			}
		}
		
	}

}