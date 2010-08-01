package  
{
	import org.flixel.*;
	
	
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class levelSelectState extends FlxState
	{
		//level selection screen

		[Embed(source = "../src/menuData/polar.png")] protected var ImgPolar:Class;
		[Embed(source = "../src/menuData/parametric.png")] protected var ImgParametric:Class;
		[Embed(source = "../src/menuData/cartesian.png")] protected var ImgCartesian:Class;
		//hereYet: the latest level number that the player has gotten to
		public function levelSelectState() 
		{
			FlxG.mouse.show();
			bgColor = 0xff000000;
			var hereYet:Number = FlxG.getlvl();
			var diff:Number = FlxG.getdiff();
			
			var but_w:Number = 36;
			var but_h:Number = 36;
			var kern:Number = 5;
			var base1_x:Number = 75;
			var base1_y:Number = 50;
			
			var base2_x:Number = 75;
			var base2_y:Number = 100; //50+36+14
			
			var base3_x:Number = 75;
			var base3_y:Number = 150;//100+36+14
			
			var levelGrp:FlxGroup = new FlxGroup();
			//title
			levelGrp.add((new FlxText(0, 10, FlxG.width, "Select a Level") as FlxText).setFormat(null, 16, 0xffffff, "center"), true);

			//cartesian levels
			levelGrp.add(new FlxSprite(base1_x - kern - 36, base1_y, ImgCartesian));
			//level 1
			levelGrp.add(new FlxButton(base1_x, base1_y, function():void{FlxG.state = new GameState(1, diff)}, but_w, but_h));
			levelGrp.add((new FlxText(base1_x-1, base1_y+1, but_w, "1") as FlxText).setFormat(null, 16, 0xcccccc, "center"), true);

			if (hereYet > 1) { //level 2
				levelGrp.add(new FlxButton(base1_x + but_w + kern, base1_y, function():void{FlxG.state = new GameState(2, diff)}, but_w, but_h));
			}else {
				levelGrp.add((new FlxSprite(base1_x + but_w + kern, base1_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
			}
			levelGrp.add((new FlxText(base1_x + but_w + kern-1, base1_y+1, but_w, "2") as FlxText).setFormat(null, 16, 0xbbbbbb, "center"), true);

			if (hereYet > 2) { //level 3
				levelGrp.add(new FlxButton((base1_x + 2*(but_w + kern)), base1_y, function():void{FlxG.state = new GameState(3, diff)}, but_w, but_h));
				}else {
				levelGrp.add((new FlxSprite(base1_x + 2*(but_w + kern), base1_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
				}
			levelGrp.add((new FlxText(base1_x + 2*(but_w + kern)-1, base1_y+1, but_w, "3") as FlxText).setFormat(null, 16, 0xbbbbbb, "center"), true);
			
			
			if (hereYet > 3) { //level 4
				levelGrp.add(new FlxButton(base1_x + 3*(but_w + kern), base1_y, function():void{FlxG.state = new GameState(4, diff)}, but_w, but_h));
				}else {
				levelGrp.add((new FlxSprite(base1_x + 3*(but_w + kern), base1_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
				}
			levelGrp.add((new FlxText(base1_x + 3*(but_w + kern)-1, base1_y+1, but_w, "4") as FlxText).setFormat(null, 16, 0xbbbbbb, "center"), true);
			
			
			if (hereYet > 4) { //level 5
				
			}
			
			if (hereYet > 5) { //level 6
				
			}
			
		
			//polar levels
			levelGrp.add(new FlxSprite(base2_x - kern - 36, base2_y, ImgPolar));
			
			//levelGrp.add(new FlxButton(base2_x, base2_y, function():void { FlxG.state = new GameState(1, diff) }, but_w, but_h));
			levelGrp.add((new FlxSprite(base2_x, base2_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
			levelGrp.add((new FlxText(base2_x-1, base2_y+1, but_w, "5") as FlxText).setFormat(null, 16, 0xcccccc, "center"), true);

			
			levelGrp.add((new FlxSprite(base2_x + but_w + kern, base2_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
			levelGrp.add((new FlxText(base2_x + but_w + kern-1, base2_y+1, but_w, "6") as FlxText).setFormat(null, 16, 0xbbbbbb, "center"), true);

			levelGrp.add((new FlxSprite(base2_x + 2*(but_w + kern), base2_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
			levelGrp.add((new FlxText(base2_x + 2*(but_w + kern)-1, base2_y+1, but_w, "7") as FlxText).setFormat(null, 16, 0xbbbbbb, "center"), true);
			
			
			levelGrp.add((new FlxSprite(base2_x + 3*(but_w + kern), base2_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
			levelGrp.add((new FlxText(base2_x + 3*(but_w + kern)-1, base2_y+1, but_w, "8") as FlxText).setFormat(null, 16, 0xbbbbbb, "center"), true);

			//parametric levels
			levelGrp.add(new FlxSprite(base3_x- kern - 36, base3_y, ImgParametric));
			
			//levelGrp.add(new FlxButton(base3_x, base3_y, function():void { FlxG.state = new GameState(1, diff) }, but_w, but_h));
			levelGrp.add((new FlxSprite(base3_x, base3_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
			levelGrp.add((new FlxText(base3_x-1, base3_y+1, but_w, "9") as FlxText).setFormat(null, 16, 0xcccccc, "center"), true);
			
			levelGrp.add((new FlxSprite(base3_x + but_w + kern, base3_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
			levelGrp.add((new FlxText(base3_x + but_w + kern-1, base3_y+1, but_w, "10") as FlxText).setFormat(null, 16, 0xbbbbbb, "center"), true);
			
			levelGrp.add((new FlxSprite(base3_x + 2*(but_w + kern), base3_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
			levelGrp.add((new FlxText(base3_x + 2*(but_w + kern)-1, base3_y+1, but_w, "11") as FlxText).setFormat(null, 16, 0xbbbbbb, "center"), true);
			
			levelGrp.add((new FlxSprite(base3_x + 3*(but_w + kern), base3_y)).createGraphic(but_w, but_h,0x33ffffff,true));		
			levelGrp.add((new FlxText(base3_x + 3*(but_w + kern)-1, base3_y+1, but_w, "12") as FlxText).setFormat(null, 16, 0xbbbbbb, "center"), true);
			
			
			//back button
			levelGrp.add(new FlxButton(25, FlxG.height - 25, function():void { 	//FlxG.log("back up");
																	FlxG.state = new TitleState();
																}));
			(levelGrp.add(new FlxText(25, FlxG.height - 25, 100, "BACK")) as FlxText).setFormat(null, 8, 0xcccccc, "center");
			
			
			this.add(levelGrp);
		}
		
	}

}