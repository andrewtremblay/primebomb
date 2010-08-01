package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 * */
	public class OpDivide extends Operation
	{
		import org.flixel.FlxG;
		public function OpDivide(inComp1:Operation, inComp2:Operation) 
		{
			super(inComp1, inComp2);
		}
		override public function value(varX:Number):Number 
		{
			if (isWrong()) { //quick check
				FlxG.log("Division error");
				return -10;
				}	
				return (comp1.value(varX) / comp2.value(varX));
		}
	}
}