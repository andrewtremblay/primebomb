package  
{
	/**
	 * ...
	 * @author andrewtremblay
	 */
	public class OpSine extends Operation
	{
		
		public function OpSine(inComp1:Operation) 
		{
			super(inComp1);
		}
		
		override public function value(varX:Number):Number 
		{
			if (isWrong()) { //quick check
				//FlashConnect.trace("Sine error");
				//return -10;
				}
				
			if (!isNaN(num1)){ //just a number
				return (Math.sin(num1));
			}else {//an operator
				return (Math.sin(comp1.value(varX)));
			}
		}
		
	}

}