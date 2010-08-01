package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	import flash.events.KeyboardEvent;
	import flash.utils.ByteArray;
	import org.flixel.*;
	import org.flashdevelop.utils.FlashConnect;
	import flash.system.fscommand;
	import flash.geom.Point;
	import flash.display.Shape;
	import flash.display.Bitmap;
	
	public class GameState extends FlxState
	{
		[Embed(source = '../src/media/song2.mp3')] protected var Songa:Class;
		[Embed(source = '../src/media/boop.mp3')] protected var powSound:Class;
		[Embed(source = '../src/media/pow.mp3')] protected var boomSound:Class;
			//Global variables.
			public var difficulty:Number;
			public var ship:Ship; //the ship
			public var enemyMaker:EnemyMaker; //the faceless malevolence
			public var maxEnemies:Number = 100;
			
			public var musicOn:Boolean; //music volume toggle
			
			public var losing:Boolean;
			public var firstloss:Boolean;
			
			public var hpGroup:FlxGroup = new FlxGroup(); 
			public var healthDisp:FlxSprite;
			public var maxHeight:Number = FlxG.height - 30;
			public var barHeight:Number = maxHeight * 100 / 100;
			public var barY:Number = 0;
			
			//pause screen reset
			public var defaultPause:FlxGroup = new Editor();
			
			//bullet display&logic
			public var numBullets:Number;
			public var numBulDisp:FlxText;
			public var maxBullets:Number = 100; 
			
			//The layers to render everything in
			public var enemies:FlxGroup;
			public var enemytext:FlxGroup;
			public var blood:FlxGroup; //gibs
			public var bullets:FlxGroup;
			public var bGround:FlxGroup;
			
			public var lines:FlxGroup;
			public var maxLines:Number = 100;

			
			//score related nonesense
			public var scoreDisp:FlxText;
			public var score:Number;
			public var currCombo:Number;
			public var killCombo:Number;
			public var shotsSince:Number;
			public var submit:Boolean;
			//hints!
			public var hintShow:FlxButton;
			public var gHint:FlxText;
			protected var hintText:ListOfHints;
			public var hint_array:Array;
			public var hint_i:Number;
			//events
			protected var eventText:ListOfEvents;
			public var timer:Number;
			public var countdown:Number;
			public var hiddenCountdown:Number;
			public var event_array:Array;
			public var event_i:Number;
			public var waiting:Boolean;
			public var seeTimer:Boolean;
			public var dispCountdown:FlxText;
			
		override public function GameState(level:Number = 1, diff:Number = 1): void	{	
			FlxG.log("loading level: " +level);
			FlxG.log("difficulty level: " +diff);
			
			healthDisp = new FlxSprite();
			
			super();
			FlxG.mouse.show();
			FlxG.volume = 1;
			
			difficulty = diff;
			losing = false;
			firstloss = true;
			
			//rusty background
			FlxState.bgColor = 0xff783629;			
			bGround = new background(0, 0);
			this.add(bGround);
			//Initialize stuff
			enemies = new FlxGroup();
			enemytext = new FlxGroup();
			blood = new FlxGroup();
			bullets = new FlxGroup();
			lines = new FlxGroup();
			
			musicOn = false;
			
			//fill the appropriate groups with stuff
			makeLines();
			bulletMake();
			
			//start the music
			if(musicOn){ FlxG.playMusic(Songa, 0.2); }
			
			//make the following visible
			this.add(enemies);
			this.add(enemytext);
			this.add(bullets);
			this.add(blood);
			this.add(hpGroup);
			this.add(lines);
			
			//score & combo logic
			score = 0;
			numBullets = 12;
			currCombo = 0;
			killCombo = 0;
			shotsSince = 1;
			submit = false;
			scoreDisp = new FlxText(1, 1, FlxG.width, "SCORE: "+score);
			this.add(scoreDisp); 
			numBulDisp = new FlxText(1, 31, FlxG.width, "AMMO: " + numBullets);
			this.add(numBulDisp);
			this.add(new FlxText(1, 46, 300, "Equations:"));
			//events
			//load appropriate events
			switch(level) {
				case 1:
				//FlxG.log("loading first level");
				eventText = new Level1();
				break;
				case 2:
				//FlxG.log("loading second level");
				eventText = new Level2();
				break;
				case 3:
				//FlxG.log("loading third level");
				eventText = new Level3();
				break;
				default:
				FlxG.log("unknown level: " + level);
				eventText = new LevelCredits();
				break;
			}
			timer = 0;
			countdown = 0;
			hiddenCountdown = 0;
			event_array = eventText.toString().split("\n");
			event_i = 0;
			waiting = false;
			seeTimer = true;
			dispCountdown = new FlxText(1, 16, 300, "COUNTDOWN ");
			this.add(dispCountdown);
			
			//overlayMake();
			healthBarMake();
		}
	
		//called after the constructor so other constructors can inititalize with them as references
		override public function create():void {
			ship = new Ship(150, 150);
			enemyMaker = new EnemyMaker();
			this.add(ship);
			
			//GUI goes 			
			//load hint portion of GUI
			hintShow = new FlxButton(5, FlxG.height-22, cycleHints, 25, 15)
			gHint = new FlxText(30, FlxG.height - 22, 300, "");
			hintText = new ListOfHints();
			hint_array = hintText.toString().split("\n");
			hint_i = 0;
			this.add(hintShow); 
			this.add(new FlxText(5, FlxG.height - 22, 25, "Hint"));
			this.add(gHint);
			
			FlxG.pause = false;
		}

		override public function update():void {	
				FlxG.setPauseState(defaultPause);
				//graphics update
				//overlay 
				healthBarUpdate();
				
				//controls
				checkControls();
				
				if (!ship.shipBul.exists) {
					if (numBullets <= 0) {
						losing = true;
						//additional visuals?
					}
				}
				//check for events 
				eventHandler();
				updateTimer();
				
				if (enemies.allDead()) { 
					//the player either killed all the enemies
					//or all the enemies have finished retaliating
					countdown = 0;
					if (losing) {
						numBullets += 5;
					}
					losing = false;
				}
				
				if (submit) { //when we want to update the score (like after a combo)
					FlxG.log("killed: " + killCombo + " men in " + shotsSince + " shots.");
					if(!losing){
						currCombo = ((killCombo * 10) * (killCombo * 10)) / shotsSince;
						score = score + currCombo;
						}
					currCombo = 0;
					killCombo = 0;
					shotsSince = 1;
					submit = false;
				}
				
				if (ship.health <= 0) {
					ship.kill();
					this.add(new FlxText(0, FlxG.height / 3, FlxG.width, "GAME OVER").setFormat(null, 16, 0xffdddddd, "center"));
					this.add(new FlxText(0, FlxG.height / 3 + 50, FlxG.width, "Press L to continue").setFormat(null, 8, 0xffdddddd, "center"));		
					hiddenCountdown += 99999999999999;
					seeTimer = false;
					barHeight = 1;
					barY = maxHeight * (100 - 1) / 100;
					healthDisp.visible = false;
					losing = true;
					if (FlxG.keys.pressed("L")){ 
						FlxG.state = new levelSelectState();
					}
				}else {
					barHeight = maxHeight * (ship.health / 100);
					barY = maxHeight * (100 - ship.health) / 100;
				}
				
				//update score
				scoreDisp.text = "SCORE: " + score;
				
				//update bullets
				numBulDisp.text = "AMMO: " + numBullets;
				
				//collision logic
				FlxU.overlap(enemies, bullets, overlapEnemiesBullets);
				FlxU.overlap(ship, enemies, overlapPlayerEnemies);
				//FlxU.overlap(enemies, lines, overlapEnemiesLines);
				super.update();
        }
		
		public function checkControls():void {
				if (FlxG.keys.justPressed("M")) { // turn on/off music
						musicOn = !musicOn;
						if (musicOn) {
							FlxG.playMusic(Songa, 0.2);	
						}else {
							FlxG.playMusic(Songa, 0);	
						}
					}
					
				if (FlxG.keys.justPressed("T")) { 
					FlxG.state = new TitleState();	
				}
				
				if (FlxG.keys.justPressed("L")) { 
				FlxG.state = new levelSelectState();	
				}
				//the things you can do when there isn't a bullet on screen
					if (FlxG.keys.justPressed("Q")) { //shoot a normal bullet
							FlxG.play(powSound, 0.1);
							ship.shoot();	
							//numBullets--;
						
					}
					if (FlxG.keys.justPressed("W")) { //shoot a super bullet
							FlxG.play(powSound, 0.1);
							ship.sprayShoot();	
							//numBullets -= 4;
						
					}
					if (FlxG.keys.justPressed("E")) { //shoot a super bullet
							FlxG.play(powSound, 0.1);
							ship.shootShotGun();	
							//numBullets -= 4;
						
					}
					
					if (FlxG.keys.justPressed("A")) { //shoot a super bullet
							primeBomb();
					}
		}
		public function eventHandler():void {
			timer += FlxG.elapsed;
			var currCommand:Array;
			if (!waiting && (event_i < event_array.length)) {
				if ((event_array[event_i] as String).indexOf("spawn") != -1) {
					currCommand = (event_array[event_i] as String).split(" ");
					FlxG.log("HEY: " + currCommand[2]+ " #: "+new Number(currCommand[2]));
					enemyMaker.spawn(currCommand[1], new Number(currCommand[2]));
				}else if ((event_array[event_i] as String).indexOf("pause") != -1) {
						currCommand = (event_array[event_i] as String).split(" ");
						if (currCommand[1] != null) { 
							//FlxG.log(new Number(currCommand[1]));
							FlxG.setPauseState(new Help(new Number(currCommand[1])));
						}else {
							FlxG.setPauseState(new Help());
						}
						FlxG.pause = true;
				}else if ((event_array[event_i] as String).indexOf("wait") != -1) {
					currCommand = (event_array[event_i] as String).split(" ");
					waiting = true;
					seeTimer = true;
					countdown = new Number(currCommand[1]);
				}else if ((event_array[event_i] as String).indexOf("secretWait") != -1) {
					currCommand = (event_array[event_i] as String).split(" ");
					waiting = true;
					seeTimer = false;
					hiddenCountdown = new Number(currCommand[1]);
				}else if ((event_array[event_i] as String).indexOf("addAmmo") != -1) {
					currCommand = (event_array[event_i] as String).split(" ");
					numBullets += new Number(currCommand[1]);
				}else if ((event_array[event_i] as String).indexOf("uhoh") != -1) {
					losing = true;
				} else if ((event_array[event_i] as String).indexOf("ascend") != -1) {
					(bGround as background).ascend = true;
					ship.ascend = true;
				}else if ((event_array[event_i] as String).indexOf("killAll") != -1) {
					enemies.killAll();
					losing = false;
				}else if ((event_array[event_i] as String).indexOf("levelComplete") != -1) {
					//play win music
					//FlxG.playMusic(Songa, 0.02);
					
					//level complete graphic & appropriate movement
					if (ship.ascend) {
							ship.velocity.y = -35;
							this.add(new FlxText(0, FlxG.height / 3, FlxG.width, "LEVEL COMPLETE").setFormat(null, 16, 0xffdddddd, "center"))	
						}else {
							ship.velocity.x = 35;
							this.add(new FlxText(0, FlxG.height / 3, FlxG.width, "LEVEL COMPLETE").setFormat(null, 16, 0xff555555, "center"));
						}
					//some more numbers moving around
				}else if ((event_array[event_i] as String).indexOf("nextLevel") != -1) {
					//bGround = 0xff000000; 
					FlxG.setlvl(FlxG.getlvl()+ 1);
					FlxG.state = new levelSelectState();
				}else{ //should not occur
					FlxG.log("unknown event command");
				}
				event_i++;
			}else {	//we're waiting (secretly)
				if(hiddenCountdown <= 0){//we're waiting (overtly)
					if (countdown <= 0) {
						waiting = false;
					}else {
						if(!FlxG.pause && !losing){
						countdown -= FlxG.elapsed;
						}
					}
				}else {
					if(!FlxG.pause && !losing){
						hiddenCountdown -= FlxG.elapsed;
					}
				}
			}
		}
		
		public function updateTimer():void {
			if (countdown > 0 && seeTimer) {
					dispCountdown.text = ("SECONDS: " + Math.ceil(countdown));
					}else {
						if (countdown <= 0) {
							dispCountdown.text = "TIME'S UP";
						}
					}
				
			if (!seeTimer) {
					dispCountdown.text = "GET READY";
				}
						
			if(losing){
					dispCountdown.text = "OH NO";
				}
			}
		private function overlapEnemiesBullets(enemy:Enemy, bullet:Bullet):void {	
			//bullet hits an enemy
			//enemy.kill();
			enemy.val--
			bullet.kill();
			
		}
		private function overlapPlayerEnemies(ship:Ship, enemy:Enemy):void {
				FlxG.flash.start();
				ship.hurt(10);
				enemy.kill();
		}		
		private function overlapPlayerBadBullet(ship:Ship, bullet:Bullet):void {
				ship.hurt(10);
				bullet.kill();
		}
		private function overlapEnemiesLines(enemy:Enemy, liney:Line):void {
			//enemy.kill();
			//liney.kill();
		}
		private function cycleHints():void {
			//equation checking logic goes here
			//when it checks out, submit to the bullet  
			gHint.text = (hint_array[hint_i] as String);
				hint_i += 1;
				if (hint_i > hint_array.length - 1) {
					hint_i = 0;
				}
		}
		public function bleedOut(_x:Number, _y:Number):void {
				blood.add(new geomBoom(_x, _y, true));
			}
		private function healthBarMake():void {
			healthDisp = (new FlxSprite(82, 5).createGraphic(5, maxHeight, 0xffff0000));
			hpGroup.add(healthDisp);
		}
		private function healthBarUpdate():void {
			hpGroup.members.shift();
			if (ship.health <= 0) { ship.health = 0; }
			healthDisp = new FlxSprite(78, 5 + barY).createGraphic(5, barHeight, 0xffff0000);
			hpGroup.members.push(healthDisp);
		}
		public function isPrime(num:Number):Boolean {
			//only works for relatively low numbers, don't call it too often
			for (var i:Number = num - 1; i > 1; i--) {
				if (num % i == 0) {
					return false;
				}
			}
			return true;
			}		
		public function primeBomb():void {
			var eTemp:Enemy;
			for (var i:Number = 0; i < enemies.members.length; i++) {
				eTemp = (enemies.members[i] as Enemy);
					if (!eTemp.dead) {
						if(isPrime(eTemp.val)) { //alive and prime
							spawnLine((eTemp.x + eTemp.width / 2), (eTemp.y + eTemp.width / 2));
							bleedOut((eTemp.x + eTemp.width / 2), (eTemp.y + eTemp.width / 2));
							(enemies.members[i] as Enemy).kill();
						}else { //alive and not prime
							spawnLine((eTemp.x + eTemp.width / 2), (eTemp.y + eTemp.width / 2), 0x99000099);
						}
					}
				}
			}
		public function bulletMake():void {
				var i:Number = 0;
				while (i < maxBullets) {
					bullets.members.push(new Bullet());
					i++;
				}
			}	
		public function makeLines():void {
			for (var i:Number = 0; i < maxLines; i++) {
				var tempLine:Line = new Line();
				lines.add(tempLine);
			}			
		}
		public function spawnLine(eX:Number, eY:Number, newCol:uint = 0x999999):void {
			var newLinePerma:LinePerma = new LinePerma(new Point(ship.x+ship.width, ship.y+ship.height/2), new Point(eX, eY), newCol);
				if (lines.members.length >= maxLines)
				{
					lines.members.shift();
					lines.members.push(newLinePerma);
				}
				else
				{
					lines.add(newLinePerma);
				}
		}
		}
}