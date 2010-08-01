package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author andrew
	 */

	public class PolarShip extends FlxSprite
	{
		[Embed(source='../lib/ship.png')] private var ImgShip:Class;
		
		public var shipBul:Bullet;
		
		public function PolarShip() 
		{
			this.x = 700;
			this.y = 700;
			loadGraphic(ImgShip, false, false, 0, 0);
			
			shoot();
		}
		
		override public function update():void 
		{
			super.update();
			bulletCheck();
			
		}
		
		public function shoot():void {
			shipBul = new Bullet(this.x, this.y);
			GameState.renderLayer.add(shipBul);
			
		}
		
		public function bulletCheck():void {
			if (!shipBul.onScreen()) {
					shipBul.kill();
			}
			
			
		}
	}
	
}