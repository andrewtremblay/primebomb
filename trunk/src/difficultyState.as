package  
{
		import org.flixel.*;
	
	/**
	 * @author andrewtremblay
	 */
	public class difficultyState extends FlxState
	{
		[Embed(source = '../lib/enemy.png')] private var en1:Class;
		[Embed(source = '../lib/enemy_small.png')] private var en1s:Class;
		
		[Embed(source = '../lib/Enemy_super.png')] private var en2:Class;
		[Embed(source = '../lib/Enemy_super_small.png')] private var en2s:Class;
		
		[Embed(source = '../lib/Enemy_noHit.png')] private var en3:Class;
		[Embed(source = '../lib/Enemy_noHit_small.png')] private var en3s:Class;
		
		
		//difficulty
		public var diffGrp:FlxGroup;
					
		public function difficultyState() 
		{
			FlxG.mouse.show();
			//the difficulty selection
			diffGrp = new FlxGroup();			
			var x:Number = FlxG.width / 2;
			var y:Number = FlxG.height / 2 -50;
			var w:uint = 155;
			var h:uint = 92;
			//the instructions
			diffGrp.add((new FlxText(0, 10, FlxG.width, "SELECT DIFFICULTY") as FlxText).setFormat(null, 16, 0xffffff, "center"), true);
			//back button
			diffGrp.add(new FlxButton(25, FlxG.height - 25, function():void { 	//FlxG.log("back up");
																	FlxG.state = new TitleState();
																}));
			(diffGrp.add(new FlxText(25, FlxG.height - 25, 100, "BACK")) as FlxText).setFormat(null, 8, 0xcccccc, "center");
			
			//easy button
			diffGrp.add(new FlxButton(x - 150, y + 55, function():void { 	//FlxG.log("back up");
																	//FlxG.lvl = 1;
																	FlxG.setdiff(1);
																	FlxG.state = new levelSelectState();
																}));
			(diffGrp.add(new FlxText(x - 150, y + 55, 100, "EASY")) as FlxText).setFormat(null, 8, 0xcccccc, "center");
			//easy enemies
			var base1x:Number = x - 175;
			diffGrp.add(new FlxText(base1x, y+35, 300, "large targets, small invincels"))
			diffGrp.add(new FlxSprite(base1x+30, y+5, en1));
			diffGrp.add(new FlxSprite(base1x + 60, y+5, en2));
			diffGrp.add(new FlxSprite(base1x + 95, y+10, en3s));
			
			
			//hard button
			diffGrp.add(new FlxButton(x + 50, y + 55, function():void { 	//FlxG.log("back up");
																	//FlxG.lvl = 1;
																	FlxG.setdiff(2);
																	FlxG.state = new levelSelectState();
																}));
			(diffGrp.add(new FlxText(x+50, y+55, 100, "CHALLENGING")) as FlxText).setFormat(null, 8, 0xcccccc, "center");
			//hard enemies
			var base2x:Number = x + 25;
			diffGrp.add(new FlxText(base2x, y+35, 300, "small targets, large invincels"))
			diffGrp.add(new FlxSprite(base2x+30, y+10, en1s));
			diffGrp.add(new FlxSprite(base2x+60, y+10, en2s));
			diffGrp.add(new FlxSprite(base2x + 90, y+5, en3));
			
			this.add(diffGrp); 
		}
		
	}

}