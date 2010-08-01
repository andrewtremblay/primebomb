package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class OpNumber extends Operation
	{
		public var numVal:Number;
		public function OpNumber(inNum1:Number)
		{
			super();
			numVal = inNum1;
		}
		override public function value(varX:Number):Number {
			return numVal;
		}
		
		
	}

}