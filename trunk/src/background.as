package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class background extends FlxGroup
	{
		[Embed(source = "../lib/Earth1_sky.png")] private var bgImg0:Class;
		[Embed(source = "../lib/Earth1_cloud1.png")] private var bgImg1:Class;
		[Embed(source = "../lib/Earth1_cloud2.png")] private var bgImg2:Class;
		[Embed(source = "../lib/Earth1_trees.png")] private var bgImg3:Class;
		[Embed(source = "../lib/Earth1_mtns.png")] private var bgImg4:Class;
		
		[Embed(source = "../lib/Space1.png")] private var bgSpace:Class;
		
		public var ascend:Boolean;
		
		public var still:FlxSprite;
		public var movepair11:FlxSprite;
		public var movepair12:FlxSprite;
		public var movepair21:FlxSprite;
		public var movepair22:FlxSprite;
		public var movepair31:FlxSprite;
		public var movepair32:FlxSprite;
	
		public var movepair41:FlxSprite;
		public var movepair42:FlxSprite;
		
		public var movepair51:FlxSprite;
		public var movepair52:FlxSprite;
		
		public function background(inX:Number, inY:Number) 
		{
			ascend = false;
			
			movepair51 = new FlxSprite(0, FlxG.height / 2, bgSpace);
			movepair52 = new FlxSprite(0, (movepair51.height + FlxG.height / 2), bgSpace);
			movepair51.velocity.y = 15;
			movepair52.velocity.y = 15;
			this.add(movepair51);
			this.add(movepair52);
			
			still = new FlxSprite(0, 0, bgImg0);
			still.velocity.x = 0;
			
			movepair11 = new FlxSprite( -FlxG.width / 2, -15, bgImg1);
			movepair11.velocity.x = -15;
			movepair12 = new FlxSprite( (movepair11.width - FlxG.width / 2), -15, bgImg1);
			movepair12.velocity.x = -15; 
			movepair21 = new FlxSprite( -FlxG.width / 2, -15, bgImg2);
			movepair21.velocity.x = -25; 
			movepair22 = new FlxSprite( (movepair21.width - FlxG.width / 2), -15, bgImg2);
			movepair22.velocity.x = -25; 
			movepair31 = new FlxSprite( - FlxG.width / 2, -15, bgImg3);
			movepair31.velocity.x = -125; 
			movepair32 = new FlxSprite( (movepair31.width - FlxG.width / 2), -15, bgImg3);
			movepair32.velocity.x = -125; 
			movepair41 = new FlxSprite(-FlxG.width / 2, -15, bgImg4);
			movepair41.velocity.x = -10; 
			movepair42 = new FlxSprite( (movepair41.width - FlxG.width / 2), -15, bgImg4);
			movepair42.velocity.x = -10; 
			
			this.add(still);
			
			this.add(movepair41);//mtn
			this.add(movepair42);//mtn
			
			this.add(movepair11);//clouds
			this.add(movepair12);//clouds
			this.add(movepair22);//clouds
			this.add(movepair22);//clouds
			this.add(movepair31);//trees
			this.add(movepair32);//trees
			
		}
		
		
		override public function update():void{
			super.update();
			//during earth
			
			//if any segments are completely off the screen, align to the right side of the twin segment
			if (movepair11.x < -FlxG.width) {
				movepair11.x = FlxG.width;
				}
			if (movepair12.x < -FlxG.width) {
				movepair12.x = FlxG.width;
				}
			if (movepair21.x < -FlxG.width) {
				movepair21.x = FlxG.width;
				}
			if (movepair22.x < -FlxG.width) {
				movepair22.x = FlxG.width;
				}
			if (movepair31.x < -FlxG.width) {
				movepair31.x = movepair32.x + movepair32.width;
				}
			if (movepair32.x < -FlxG.width) {
				movepair32.x = movepair31.x + movepair31.width;
				}
				
			if (movepair41.x < -movepair41.width) {
				movepair41.x = movepair42.x + movepair42.width;
				}
			if (movepair42.x < -movepair42.width) {
				movepair42.x = movepair41.x + movepair41.width;
				}
			
			if (movepair51.y > movepair51.height) {
				movepair51.y = movepair52.y - movepair52.height;
				}
			if (movepair52.y > movepair52.height) {
				movepair52.y = movepair51.y - movepair51.height;
				}	
			
			//are we ascending?
			//transition
			if (ascend) {
				still.alpha = still.alpha * 0.992;
				
				movepair11.velocity.y = 15;
				movepair12.velocity.y = 15;
				movepair21.velocity.y = 15;
				movepair22.velocity.y = 15;
				movepair31.velocity.y = 55;
				movepair32.velocity.y = 55;
				movepair41.velocity.y = 30;
				movepair42.velocity.y = 30;
				
				
				//during space	
				
			}
		}
		
	}

}