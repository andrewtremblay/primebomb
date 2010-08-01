package  
{
	/**
	 * base class for mathmatical operations...
	 * @author andrewtremblay andrewtremblay ...
	 */
		import org.flashdevelop.utils.FlashConnect;

	public class Operation
	{
		public var comp1:Operation;
		public var comp2:Operation;
		
		
		public function Operation(inComp1:Operation = null, inComp2:Operation = null) {
			comp1 = inComp1;
			comp2 = inComp2;
		}
		
		public function isWrong():Boolean {
			//check to make sure that the first component isn't declared twice as an operation and a number
			//returns true if incorrect format, false if correct
			return false;
			
		}
		
		public function isRight():Boolean {
			//returns true if correct format, false if incorrect
			return !isWrong();
		}
		
		public function value(varX:Number):Number{ //to override
			//return the resulting value of whatever operation the object is
			//get the values of the internal components if they are operations
			//4*Math.sin(varX/5)
			return 0;
		}
		
	}

}