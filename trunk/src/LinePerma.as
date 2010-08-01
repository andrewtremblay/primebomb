package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	
	 
	import org.flixel.*;
    import flash.display.Bitmap;
    import flash.geom.Point;
    import flash.display.Shape;
		import org.flashdevelop.utils.FlashConnect;

	 
	public class LinePerma extends FlxObject
	{
		protected var drawShape:Shape = new Shape();
		protected var p1:Point = new Point();
		protected var p2:Point = new Point();
		protected var age:Number = 0;
		public var col:uint = 0x999999;
		public function LinePerma(_p1:Point, _p2:Point, newCol:uint = 0x999999) 
		{
		    this.age = 0;
			this.p1 = _p1;
			this.p2 = _p2;	
			this.col = newCol;
		}
		
		override public function render():void
		{	drawShape.graphics.clear();
            drawShape.graphics.lineStyle(2.5, col, 0.5);
            drawShape.graphics.moveTo(p1.x, p1.y);
            drawShape.graphics.lineTo(p2.x, p2.y);
            FlxG.buffer.draw(drawShape);
			
        }
		
		override public function update():void 
		{
			wormKill(5); //only up to 5 timestep-old segments exist
			super.update();
		}
		
		
		private function wormKill(cull:Number):void{
			//if the line is old, remove it
				if (this.age >= cull) {
					this.kill();
				}else {
					this.age += 1;
				}
		}
		
	}

}