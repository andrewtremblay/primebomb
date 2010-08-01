package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import flash.geom.Point;

	
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class Ship extends FlxSprite
	{
		[Embed(source='../lib/ship.png')] private var ImgShip:Class;
		public var shipBul:Bullet;
		public var ascend:Boolean;
		public function Ship(_x:Number = 100, _y:Number = 100) {
			super();
			ascend = false;
			this.health = 100;
			this.x = _x;
			this.y = _y;
			loadGraphic(ImgShip, false, false, 0, 0);
			shipBul = new Bullet(); 
			(FlxG.state as GameState).bullets.add(shipBul);
		}
		
		override public function update():void {
			super.update();
			if(!ascend){
				if (FlxG.keys.pressed("UP")) {
						if(y > 0){
							this.y -= 2;
						}
					} else if (FlxG.keys.pressed("DOWN")) {
						if(y < FlxG.height - height - 25){
							this.y += 2;
						}
					}
				if (FlxG.keys.pressed("RIGHT")){
						this.x += 2;
					} else if (FlxG.keys.pressed("LEFT")) {
						this.x -= 2;
					}
			}	
		}
		
		public function shoot(superB:Boolean = false):void {
			//FlxG.log("SHOT");
			var temp:Bullet = (FlxG.state as GameState).bullets.members.shift() as Bullet;
			temp.spawn(this.x + this.width, this.y + this.height / 2, -1, superB);
			temp.velocity.y = 0;
			(FlxG.state as GameState).bullets.members.push(temp);
		}
		public function sprayShoot(superB:Boolean = false):void {
			//FlxG.log("SPRAYSHOT");
			var temp:Bullet = (FlxG.state as GameState).bullets.members.shift() as Bullet;
			temp.spawn(this.x + this.width, this.y + this.height / 2, -1, superB);
			temp.velocity.y = 0;
			(FlxG.state as GameState).bullets.members.push(temp);
			temp = (FlxG.state as GameState).bullets.members.shift() as Bullet;
			temp.spawn(this.x + this.width, this.y + this.height / 2, -1, superB);
			temp.velocity.y = 90;
			(FlxG.state as GameState).bullets.members.push(temp);
			temp = (FlxG.state as GameState).bullets.members.shift() as Bullet;
			temp.spawn(this.x + this.width, this.y + this.height / 2, -1, superB);
			temp.velocity.y = -90;
			(FlxG.state as GameState).bullets.members.push(temp);
		}
		
		public var shotGun:Boolean = true;
		public function shootShotGun(superB:Boolean = false):void {
			//FlxG.log("SHOT");
			var temp:Bullet = new Bullet();
			
			if (shotGun) {
				shotGun = false;
				(FlxG.state as GameState).bullets.members.push(temp);
				temp = (FlxG.state as GameState).bullets.members.shift() as Bullet;
				temp.spawn(this.x + this.width, this.y + this.height / 2 - 3, -1, superB);
				temp.velocity.y = 10;
				(FlxG.state as GameState).bullets.members.push(temp);
				temp = (FlxG.state as GameState).bullets.members.shift() as Bullet;
				temp.spawn(this.x + this.width, this.y + this.height / 2 - 3, -1, superB);
				temp.velocity.y = -10;
				(FlxG.state as GameState).bullets.members.push(temp);
			}else {
				shotGun = true;
				
			(FlxG.state as GameState).bullets.members.push(temp);
			temp = (FlxG.state as GameState).bullets.members.shift() as Bullet;
			temp.spawn(this.x + this.width, this.y + this.height / 2 + 3, -1, superB);
			temp.velocity.y = 10;
			(FlxG.state as GameState).bullets.members.push(temp);
			temp = (FlxG.state as GameState).bullets.members.shift() as Bullet;
			temp.spawn(this.x + this.width, this.y + this.height / 2 + 3, -1, superB);
			temp.velocity.y = -10;
			(FlxG.state as GameState).bullets.members.push(temp);
			}
		}
	}
	
}