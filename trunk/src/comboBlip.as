package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author ...
	 */
	public class comboBlip extends FlxSprite
	{
		[Embed(source = '../lib/plus2.png')] private var Img2:Class;
		[Embed(source = '../lib/plus3.png')] private var Img3:Class;
		public var age:Number;
		public var maxAge:Number;
		public function comboBlip(_x:Number = 0, _y:Number = 0, type:Number = 0, _age:Number = 1) 
		{
			super(_x, _y);
			if (_age == 0) {
				_age = 1;
			}
			maxAge = _age;
			age = 0;
			switch (type) {
				case 0: //
					break;
				case 1: //normal
					break;
				case 2: //double
					loadGraphic(Img2);
					break;
				case 3: //triple multiplier
					loadGraphic(Img3);
					break;
				default://shouldn't be encountered
					break;
			}
		}
		
		override public function update():void 
		{
			this.y = this.y - 15*FlxG.elapsed;
			this.alpha = (maxAge-age)/maxAge;
			if (maxAge < age) {
				kill();
				}
			age += FlxG.elapsed;
		}
		
	}

}