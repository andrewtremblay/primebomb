package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	
	public class OpSubtract extends Operation
	{
		/*inherited
		 * comp1
		 * comp2
		 * num1
		 * num2
		 * */
		public function OpSubtract(inComp1:Operation, inComp2:Operation) 
		{
			super(inComp1, inComp2);
		}
		
		override public function value(varX:Number):Number 
		{
			if (isWrong()) { //quick check
				//FlashConnect.trace("Subtract error");
				return -10;
				}
				
			return (comp1.value(varX) - comp2.value(varX));
		}
		
	}

}