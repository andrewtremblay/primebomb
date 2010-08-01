package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class OpCos extends Operation
	{
		public function OpCos(inComp1:Operation) 
		{
			super(inComp1);
			
		}
		
		override public function value(varX:Number):Number 
		{
			if (isWrong()) { //quick check
				//FlashConnect.trace("Cosine error");
				//return -10;
				}
				
			if (!isNaN(num1)){ //just a number
				return (Math.cos(num1));
			}else {//or an operator
				return (Math.cos(comp1.value(varX)));
			}
		}
	}
		
}

