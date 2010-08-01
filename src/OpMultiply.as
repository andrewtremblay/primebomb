package  
{
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class OpMultiply extends Operation
	{
		
		public function OpMultiply(inComp1:Operation, inComp2:Operation) 
		{
			super(inComp1, inComp2);
		}
		
				
		override public function value(varX:Number):Number 
		{
			if (isWrong()) { //quick check
				//FlashConnect.trace("Multiply error");
				return -10;
				}
				
				return (comp1.value(varX) * comp2.value(varX));	
		}
		
		
	}

}