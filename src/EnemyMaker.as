package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author andrewtremblay
	 * */
	public class EnemyMaker extends FlxSprite
	{
		public var nextEnemy:Number;  
		public var nextPos:Number;  
		
		public function EnemyMaker() {
			nextEnemy = 0;
			nextPos = 1;
			super();
		}
		
		override public function update():void {
			//don't do anything
		}
		
		public function spawn( yLoc:String = "1", val:Number = 22, type:String = "a"):void {
				var temp:Enemy = new Enemy(new Number(yLoc), val, type);
				(FlxG.state as GameState).enemies.add( temp );
					}
			}
	}
