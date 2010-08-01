package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class OpVar extends Operation
	{
		
		public function OpVar()
		{
			super();
		}
		
		
		override public function value(varX:Number):Number {
			return varX;
		}
		
	}

}