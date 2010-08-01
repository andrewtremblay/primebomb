package  
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author andrew
	 */
	public class equationString
	{
		public var equation:String;
		public var parsedEquation:Array;
		public var tempParsed:Array;
		
		public function equationString(eq:String) 
		{ // the equation needs to be in the format "x + 1 - cos ( 2 * x ) + x" to work 
			equation = eq;
			parsedEquation = eq.split(" ");
		}
		
		public function value(x:Number){ // the Y value if the input variable is X 
			return loopCompute(x, parsedEquation);
		}
		
		private function loopCompute(x:Number, temp:Array):Number {
			var loopTemp:Array = temp;
			//while(tempParsed.length != 0){
				var segment1:String = loopTemp.pop //takes the first element of the equation out 
				//ignore parens for now
				if (loopTemp.indexOf("^") != -1) {
					
				}else if (loopTemp.indexOf("*") != -1) {
				
				}else if (loopTemp.indexOf("/") != -1) {
					
				}else if (loopTemp.indexOf("+") != -1) {
					
				}else if (loopTemp.indexOf("-") != -1) {
					
				}else if ((loopTemp.indexOf("x") != -1)||(loopTemp.indexOf("y") != -1)) {
					
				}else { //assume it's a number
					
				}
				
				
				var segment2:String = "";
				switch (segment1) {
					//PEMDAS UGHAVLBGERSAFTHRBD
					case "x":
						if (loopTemp.length == 0){
							return x;
						}else { //there's something left
								//continue analyzing
							return loopCompute(x, loopTemp);
						}
						break;
					case "*":
						
						break;
					case "/":
						
						break;
					case "+":
						end = plus(end, Xvalue());
						break;
					case "-":
						
						break;
				}
			//}
			//there is nothing in the function declaration
			return 0;
			
		}
		
		public function makeNum(num:String):Number {
			return Number(num);
		}
		
		public function plus(part1:Number, part2:Number):Number {
			return part1 + part2;
		}
		public function minus(part1:Number, part2:Number):Number {
			return part1 - part2;
		}
		public function times(part1:Number, part2:Number):Number {
			return part1 * part2;
		}
		public function divide(part1:Number, part2:Number):Number {
			return part1 / part2;
		}
		public function plus(part1:Number, part2:Number):Number {
			return part1 + part2;
		}
		public function sine(part1:Number):Number {
			return Math.sin(part1);
		}
		public function cosine(part1:Number):Number {
			return Math.cos(part1);
		}
		public function tangent(part1:Number):Number {
			return part1;
		}



	}

}