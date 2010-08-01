package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class OpParen extends Operation
	{
		
		public function OpParen(inComp1:Operation) 
		{
			super(inComp1);
		}
		
		override public function value(varX:Number):Number 
		{
			return comp1.value(varX);	
		}
		
	}
}