
package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class OpExponent extends Operation
	{
		import org.flixel.FlxG;
		public function OpExponent(inComp1:Operation, inComp2:Operation) 
		{
			super(inComp1, inComp2);
		}
		
			
		override public function value(varX:Number):Number 
		{
			if (isWrong()) { //quick check
				FlxG.log("Exponent error");
				return -10;
				}
				
				return Math.pow(comp1.value(varX) , comp2.value(varX));
		}
		
	}

}