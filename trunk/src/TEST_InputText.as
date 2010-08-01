package
{
	import org.flixel.*;
	
	import org.flixel.data.FlxMouse;
	public class TEST_InputText extends FlxState
	{
		[Embed(source="menuData/a.png")] private var ImgTBAMLogo:Class;
		[Embed(source="menuData/cursor.png")] private var ImgCursor:Class;


		public var layer:FlxGroup;
		public var curs:FlxMouse;

		override public function TEST_InputText():void
		{
			var logo:FlxSprite;
			logo = new FlxSprite(0,0,ImgTBAMLogo);
			logo.x=1;
			logo.y=1;
			this.add(logo);
			FlxG.mouse.show();
			//FlxG.mouse.load(ImgCursor);
			
			this.add(new FlxButton(0, 220, function():void { layer.visible = !layer.visible; }));
			//new FlxSprite(null, 0, 0, false, false, 104, 15, 0xff729954)
			//new FlxText(0, 1, 104, 10, "Show layer", 0x729954, null, 8, "center")
			//new FlxText(0, 1, 104, 10, "Show layer", 0xd8eba2, null, 8, "center")
			
			layer = new FlxGroup;
			this.add(layer);
		}
		override public function create():void 
		{
			
			
			this.add(new FlxText(50, 50, 200, "This input text has custom filtering\n(can only write .,:; and digits)"));
			
			var customFilterInput:FlxInputText = this.add(new FlxInputText(50, 76, 220, 25, "Type Your Equation Here", 0x000fff)) as FlxInputText;
			customFilterInput.customFilterPattern = /[^.,:;0-9]*/g;
			customFilterInput.filterMode = FlxInputText.CUSTOM_FILTER;
			this.add(customFilterInput);
			
			layer.add(new FlxText(170, 200, 200, "This FlxText is in a layer"));
			var layerInput:FlxInputText = new FlxInputText(0, 190, 220, 12, "this input textbox is in a layer too", 0x000fff);
			layerInput.borderVisible=false;
			layerInput.backgroundColor = 0xf0f000;
			layer.add(layerInput);
			
			
			
			this.add(new FlxText(20, 100, FlxG.width-40,"Enter your initials (max 3 chars, auto uppercase)")) as FlxText;
			var initialsInput:FlxInputText = this.add(new FlxInputText((FlxG.width-100)/2, 120, 100, 30, "MSW", 0x000fff, "HELLO", 24)) as FlxInputText;
			initialsInput.setMaxLength(3);
			initialsInput.filterMode = FlxInputText.ONLY_ALPHA;
			initialsInput.forceUpperCase = true;
			initialsInput.visible = true;
			this.add(initialsInput);
			
			
			
		}
	}
}