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
	 
	public class geomBoom extends FlxObject
	{
		
		protected var drawShape:Shape = new Shape();
		protected var p1:Number;
		protected var p2:Number;
		protected var age:Number = 0;
		protected var maxSize:Number;
		protected var death:Boolean;
		protected var color1:uint;
		protected var color2:uint;
		
		public function geomBoom(_p1:Number, _p2:Number, _d:Boolean = false, _maxSize:Number = 10,  _color1:uint = 0x000999, _color2:uint = 0x990000) 
		{   this.age = 1;
			this.p1 = _p1;
			this.p2 = _p2;	
			this.maxSize = _maxSize;
			this.death = _d;
			this.color1 = _color1;
			this.color2 = _color2;
		}
		
		override public function render():void
		{	var deathSize:Number = maxSize / age - 2 / age / age;
			if (deathSize < 0) {
				deathSize = 0;
				}
			
			drawShape.graphics.clear();
			
			if (!death) {
				drawShape.graphics.beginFill(color1);
				drawShape.graphics.drawCircle(this.p1, this.p2, 1); //*age
				drawShape.graphics.endFill();
			}else {
				drawShape.graphics.beginFill(color2);
				drawShape.graphics.drawCircle(this.p1, this.p2, deathSize); 
				drawShape.graphics.endFill();
				}			
				FlxG.buffer.draw(drawShape);
        }
		
		override public function update():void {
			age = age * 0.9;
			
			if (age < 0.0000001) {
				kill();
			}
			
		}
		
		public function respawn(_p1:Number, _p2:Number):void {
		    this.age = 1;
			this.p1 = _p1;
			this.p2 = _p2;	
		}
	}

}