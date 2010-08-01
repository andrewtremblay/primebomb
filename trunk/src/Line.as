package  
{
	/**
	 * ...
	 * @author andrew
	 */
	import org.flixel.*;
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.Shape;
		import org.flashdevelop.utils.FlashConnect;


    public class Line extends FlxObject
	{
		protected var line:Shape = new Shape();
		protected var p1:Point = new Point();
		protected var p2:Point = new Point();
		protected var age:Number = 0;

		function Line()
		{
			exists = false;
        }
		
		public function redraw(_p1:Point, _p2:Point):void 
		{
			this.age = 0;
			this.p1 = _p1;
			this.p2 = _p2;	
			exists = true;
		}
		
        override public function render():void
		{
			
            line.graphics.lineStyle(2.5, 0x999999);
            line.graphics.moveTo(p1.x, p1.y);
            line.graphics.lineTo(p2.x, p2.y);
            FlxG.buffer.draw(line);
        }
		
		override public function update():void 
		{
			wormKill(1); //only up to 75 timestep-old segments exist
			//recoilKill(); //lags like hell if the bullet stays on-screen too long
			super.update();
		}
		
		private function recoilKill():void{
			this.kill();
			
		}
		
		private function wormKill(cull:Number):void{
			//if the line is old, remove it
				if (this.age >= cull) {
					this.die();
				}else {
					this.age += 1;
				}
		}
		
		override public function kill():void 
		{
			die();
		}
		public function die():void {
			exists = false;
		}
    }

}