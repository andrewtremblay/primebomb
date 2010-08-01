package  
{
	import flash.external.ExternalInterface;
	import org.flixel.*;
	
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class instructState extends FlxState
	{
		
		[Embed(source = '../src/menuData/example1.png')] private var ex1:Class;
		[Embed(source = '../src/menuData/example2.png')] private var ex2:Class;
		[Embed(source = '../src/menuData/example3.png')] private var ex3:Class;
		[Embed(source = '../src/menuData/example4.png')] private var ex4:Class;
		
		[Embed(source = '../lib/ship.png')] private var you:Class;
		
		[Embed(source = '../lib/enemy.png')] private var en1:Class;
		[Embed(source = '../lib/enemy_small.png')] private var en1s:Class;
		
		[Embed(source = '../lib/Enemy_super.png')] private var en2:Class;
		[Embed(source = '../lib/Enemy_super_small.png')] private var en2s:Class;
		
		[Embed(source = '../lib/Enemy_noHit.png')] private var en3:Class;
		[Embed(source = '../lib/Enemy_noHit_small.png')] private var en3s:Class;
		
		//instructions
		public var instrGrp:FlxGroup;
		public var place:Number;
		public var dispText:FlxText;
		public var dispPix:FlxSprite;
		
		public var slide1:FlxGroup;
		public var slide2:FlxGroup;
		public var slide3:FlxGroup;
		
		public function instructState() 
		{
			FlxG.mouse.show();
			place = 0;
			instrGrp = new FlxGroup();
			
			slide1 = new FlxGroup();
			slide2 = new FlxGroup();
			slide3 = new FlxGroup();
			
			var x:Number = FlxG.width / 2;
			var y:Number = FlxG.height / 2;
			var w:uint = 155;
			var h:uint = 92;
			//the instructions
			instrGrp.add((new FlxText(0, 10, FlxG.width, "INSTRUCTIONS") as FlxText).setFormat(null, 16, 0xffffff, "center"), true);
			//back button
			instrGrp.add(new FlxButton(25, FlxG.height - 25, backBut));
			(instrGrp.add(new FlxText(25, FlxG.height - 25, 100, "BACK")) as FlxText).setFormat(null, 8, 0xcccccc, "center");
			//next button
			instrGrp.add(new FlxButton(FlxG.width - 125, FlxG.height - 25, nextBut));
			(instrGrp.add(new FlxText(FlxG.width - 125, FlxG.height - 25, 100, "NEXT")) as FlxText).setFormat(null, 8, 0xcccccc, "center");
			//text
			dispText = new FlxText(25, 45, FlxG.width - 50, "Welcome to Axeawesome. Your task this afternoon will be to eliminate enemies as efficiently as possible.");
			this.add(dispText);
			
			var basex:Number = 70; 
			slide1.add(new FlxSprite(basex+30, 100, en1));
			slide1.add(new FlxSprite(basex+60, 100, en2));
			slide1.add(new FlxSprite(basex+90, 100, en3));
			slide1.add(new FlxSprite(basex+30, 125, en1s));
			slide1.add(new FlxSprite(basex+60, 125, en2s));
			slide1.add(new FlxSprite(basex + 90, 125, en3s));
			slide1.add(new FlxText(basex + 40, 85, 100, "ENEMIES"));
			
			slide1.add(new FlxText(basex + 190, 85, 100, "YOU"));
			slide1.add(new FlxSprite(basex + 190, 100, you));
			this.add(slide1);
			
			slide2.visible = false;
			slide2.add(new FlxSprite(45, 85, ex1));
			slide2.add(new FlxSprite(155, 105, ex2));
			this.add(slide2);
			
			slide3.visible = false;
			slide3.add(new FlxSprite(55, 85, ex3));
			slide3.add(new FlxSprite(245, 85, ex4));
			this.add(slide3);
			
			this.add(instrGrp);
		}
		
		override public function update():void 
		{
			super.update();
			switch(place) {
				case -1:
				FlxG.state = new TitleState();
				break;
				case 0:
				slide1.visible = true; 
				slide2.visible = false;
				slide3.visible = false;
				dispText.text = "Welcome to Axeawesome. Your task this afternoon will be to eliminate enemies as efficiently as possible.";
				break;
				case 1:
				slide1.visible = false; 
				slide2.visible = true;
				slide3.visible = false;
				dispText.text = "Using the latest in bullet technology you will define equations that determine the path of the bullet.";
				break;
				case 2:
				slide1.visible = false; 
				slide2.visible = false;
				slide3.visible = true;
				dispText.text = "The game ends well when you destroy all enemies. The game ends badly when you run out of time or bullets.";
				break;
				case 3:
				FlxG.state = new TitleState();
				break;
				default:
				FlxG.state = new TitleState();
				break;
			}
		}
		
		public function nextBut():void {
			place++;
		}
		
		public function backBut():void {
			place--; 
		}
		
	}

}