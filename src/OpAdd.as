package  
{
	/**
	 * ...
	 * @author andrewtremblay 
	 */
	import org.flixel.FlxG;
	public class OpAdd extends Operation
	{
		/*inherited
		 * comp1
		 * comp2
		 * */
		public function OpAdd(inComp1:Operation, inComp2:Operation) 
		{
			super(inComp1, inComp2);
		}
		
		override public function value(varX:Number):Number 
		{
			if (isWrong()) { //quick check
				FlxG.log("Addition error");
				return -10;
				}
				return (comp1.value(varX) + comp2.value(varX));
		}
		
	}

}