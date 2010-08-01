package  
{
	import org.flixel.*;	
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class Enemy extends FlxSprite
	{
		[Embed(source = '../lib/enemy.png')] private var regLarge:Class;
		[Embed(source = '../lib/enemy_small.png')] private var regSmall:Class;
		
		[Embed(source = '../lib/Enemy_super.png')] private var supSmall:Class;
		[Embed(source = '../lib/Enemy_super_small.png')] private var supLarge:Class;
		
		[Embed(source = '../src/media/pow.mp3')] protected var boomSound:Class;
		public var valDisp:FlxText;
		public var type:String;		
		public var val:Number;
		public var timer:Number = 0;
		public function Enemy(yLoc:Number, _val:Number, _type:String = "a") {
				super(FlxG.width+1, yLoc);
				val = _val;
				type = _type;
				loadGraphic(regLarge, false, false, 0, 0);	
				valDisp = new FlxText((this.x - 25), (this.y), 50, "(" +_val+ ")");
				(FlxG.state as GameState).enemytext.add(valDisp);
				this.velocity.x = -40;
			}
			
			
		override public function update():void{
				super.update();
				valDisp.text = "(" + val + ")";
				valDisp.x = this.x - 25;
				valDisp.y = this.y;
				switch(type) {
					case "a": //default forward
					break;
					case "b": //forward and stop
					
					break;
					case "c": //circle the player
						if (this.x < (FlxG.state as GameState).ship.x) {
							this.acceleration.x = 15;
						}else {
							this.acceleration.x = -15;
							}
						if (this.y < (FlxG.state as GameState).ship.y) {
							this.acceleration.y = 15;
						}else {
							this.acceleration.y = -15;
								}
					break;
					default: 
					if (this.x < (FlxG.state as GameState).ship.x) {
							this.acceleration.x = 15;
						}else {
							this.acceleration.x = -15;
							}
						if (this.y < (FlxG.state as GameState).ship.y) {
							this.acceleration.y = 15;
						}else {
							this.acceleration.y = -15;
								}
					break;
					}
				if ((val <= 0)||(this.x < -50)) {
					kill();
				}
			}
			
		override public function kill():void 
			{	
				/*if (this.x >= this.width) {
					FlxG.play(boomSound, 0.1);
					if(!dead){
						(FlxG.state as GameState).bleedOut(this.x + this.width / 2, this.y + this.height / 2);	
						dead = true;
					}
				}else { 
					(FlxG.state as GameState).killCombo += 1;
				}*/
				valDisp.kill();
				super.kill();
			}
			
	}

}