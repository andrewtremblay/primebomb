package  
{
	
	import flash.display.Shape;
	import flash.geom.Point;
	import org.flixel.*;
	import flash.utils.Timer;
    import flash.events.TimerEvent;
    import flash.display.Sprite;
	import org.flashdevelop.utils.FlashConnect;


	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class Bullet extends FlxSprite
	{
		[Embed(source = "../lib/bullet2.png")] protected var ImgBullet:Class;
		private var addVal:Number;	
		public var superb:Boolean;	
		
		public function Bullet(_x:Number = 10000, _y:Number = 12, _val:Number = -1, _superB:Boolean = false) {
			loadGraphic(ImgBullet, false, false);
			this.y = _y;
			this.x = _x
			addVal = _val;
			superb = _superB;
		}
		override public function update():void {
			super.update();
			//x position has already been updated because velocity
			if (this.x > FlxG.width) {
				FlxG.log("Off Screen");
				kill();
			}
		}
		public function spawn(_x:Number, _y:Number, _val:Number = -1, _superB:Boolean = false):void{
				this.x = _x;
				this.y = _y;
				addVal = _val;
				superb = _superB;				
				this.velocity.x = 90;
				exists = true;
				dead = false;
			}
		override public function kill():void {
			(FlxG.state as GameState).blood.add(new geomBoom((this.x - this.width / 2), (this.y - this.height / 2), true, 5, 0x099099, 0x099099));
			(FlxG.state as GameState).submit = true;
			die();
		}
		
		public function die():void {
			exists = false;
			//FlashConnect.trace("luldead");
		}
		
	}
}