package  
{
	import org.flixel.FlxGroup;	
	import org.flixel.FlxG;
	import org.flixel.data.FlxConsole;
	import org.flashdevelop.utils.FlashConnect;
	/**
	 * ...
	 * @author andrewtremblay
	 * */
	public class equationPrefixString
	{
		public var equation:String;
		public var parsedEquation:Array;
		
		public var equals:Operation;
		
		private var debug:Boolean = true;
		private var numPattern:RegExp = /\d+/; // regex to check for numbers (one or more decimals)
		private var varPattern:RegExp = /[xy]/i; // regex to check for variables (ignore case)
		
		public function equationPrefixString(eq:String) 
		{   // ( + x 1 )
			// the equation needs to be in the format "(+ (- (+ x 1) (cos (* 2 x))) x)" to work if using schemeCompile
			//alter the equation so that all operations are implicitly declared
			equation = prepare(eq);
			//FlxG.log(equation);
			//parsedEquation = eq.split(" "); //take the equation and turn it into an array
			//FlxG.log("passing " + parsedEquation);
			equals = stringCompile(equation);
			/* equals = simpleCompile(parsedEquation);
			 * equals = schemeCompile(parsedEquation);
			 * examples
			 * equals = new OpExponent(new OpVar(), new OpNumber(2)); //x^2
			 * equals = new OpSubtract(new OpMultiply(new OpExponent(new OpMultiply(new OpVar(), new opNumber(0.33)), new opNumber(2)), new OpNumber(1)), new OpAdd(new OpMultiply(new OpVar(), new OpNumber(5)), new OpNumber(1))); //1*(1/3X)^2 - (5*X + 1)		
			 * equals = new OpAdd(new OpMultiply(new OpVar(), null, NaN, 1), null, NaN, 1); //4X + 1		
			 * equals = new OpSubtract(new OpDivide(new OpVar(), null, NaN, 4), null, NaN, 15); //1/4X - 15
			 * equals = new OpCos(new OpVar());
			 * equals = new OpSine(new OpVar());
			 */
		}
		
		public function value(x:Number):Number{ // returns the Y value if the input variable is X and vice versa
			return equals.value(x); //alter X and Y vars here ONLY if appearance is not correct
		}

		private function stringCompile(Eq:String):Operation {
			var parsedEq:String = Eq 
			FlxG.log("Compiling: "+Eq);
			var i:Number;
			var j:Number;
			var z:Number = 0;
			var lParen:Number = parsedEq.indexOf("(");
			var rParen:Number = parsedEq.indexOf(")");
					if ((parsedEq.indexOf("+") != -1)&&(beforeParen("+", parsedEq))) { FlxG.log("a plus before the first paren was found");
							i = parsedEq.indexOf("+");
							return new OpAdd(stringCompile(parsedEq.slice(0, i)), stringCompile(parsedEq.slice(i+1)));
					} else if ( (parsedEq.indexOf("-") != -1) && (beforeParen("-", parsedEq)) ) { FlxG.log("a minus before the first paren was found");
							i = parsedEq.indexOf("-");
							FlxG.log(parsedEq.charAt(i - 1));
							if (parsedEq.charAt(i - 1).match("*") != null) {
									FlxG.log("negative number (multiplication)");
									//...*-1*...
									return new OpMultiply(stringCompile(parsedEq.slice(0, i - 1)), 
													  new OpMultiply(new OpSubtract(stringCompile("0"),stringCompile("1")), 
																       stringCompile(parsedEq.slice(i + 1))));
									}
							if ((i == 0) || (parsedEq.charAt(i - 1).match("+")) != null) {
										FlxG.log("negative number (simple)");
										return new OpSubtract(stringCompile("0"), stringCompile(parsedEq.slice(i + 1)));
									}else {FlxG.log("ordinary subtraction");
								return new OpSubtract(stringCompile(parsedEq.slice(0, i)), stringCompile(parsedEq.slice(i + 1)));
							}
					} else if ( (parsedEq.indexOf("*") != -1) && (beforeParen("*", parsedEq)) ) { FlxG.log("a mult before the first paren was found");
							i = parsedEq.indexOf("*");
							return new OpMultiply(stringCompile(parsedEq.slice(0, i)), stringCompile(parsedEq.slice(i + 1)));
					} else if ( (parsedEq.indexOf("/") != -1) && (beforeParen("/", parsedEq)) ) { FlxG.log("a div before the first paren was found");
							i = parsedEq.indexOf("/");
							return new OpDivide(stringCompile(parsedEq.slice(0, i)), stringCompile(parsedEq.slice(i + 1)));
					} else if ( (parsedEq.indexOf("^") != -1) && (beforeParen("^", parsedEq)) ) { FlxG.log("a exp before the first paren was found");
							i = parsedEq.indexOf("^");
							return new OpExponent(stringCompile(parsedEq.slice(0, i)), stringCompile(parsedEq.slice(i + 1)));
					} else if ( (lParen != -1) && (rParen != -1) && (lParen < rParen) ) { //parens, ugh
								FlxG.log("parens found");
								//find and parse the stuff before the first paren section
								rParen =  findrParen(parsedEq, rParen, lParen); //the index of the corresponding paren 
								if (lParen == 0) { // first paren at the beginning of the equation
									FlxG.log("left paren found");
									//find and parse the stuff before the corresponding paren section
									if (parsedEq.indexOf(")+") == rParen) {
										FlxG.log("paren add found");
										return new OpAdd(new OpParen(stringCompile(parsedEq.slice(1,rParen))), stringCompile(parsedEq.slice(rParen+2)));
									}else if (parsedEq.indexOf(")-") == rParen) {
										FlxG.log("paren subtract found");
										return new OpSubtract(new OpParen(stringCompile(parsedEq.slice(1,rParen))), stringCompile(parsedEq.slice(rParen+2)));
									}else if (parsedEq.indexOf(")*") == rParen) {
										FlxG.log("paren mult found");
										return new OpMultiply(new OpParen(stringCompile(parsedEq.slice(1,rParen))), stringCompile(parsedEq.slice(rParen+2)));
									}else if (parsedEq.indexOf(")/") == rParen) {
										FlxG.log("paren div found");
										return new OpDivide(new OpParen(stringCompile(parsedEq.slice(1,rParen))), stringCompile(parsedEq.slice(rParen+2)));
									}else if (parsedEq.indexOf(")^") == rParen) {
										FlxG.log("paren exp found");
										return new OpExponent(new OpParen(stringCompile(parsedEq.slice(1,rParen))), stringCompile(parsedEq.slice(rParen+2)));
									}else if (rParen == parsedEq.length - 1) { //end of the equation
										FlxG.log("simple parens found");
										return new OpParen(stringCompile(parsedEq.slice(1,rParen)));
									}else { //should not occur
										FlxG.log("problem with parens");
										return new Operation();
									}
								}else if (parsedEq.indexOf("+(") == lParen - 1) { //plus at start of the equation
									FlxG.log("left paren addition found");
									//find and parse the stuff before the corresponding paren section
									if (parsedEq.indexOf(")+") == rParen) {
										FlxG.log("paren add found");
										return new OpAdd(stringCompile(parsedEq.slice(z, lParen-1)), new OpAdd(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")-") == rParen) {
										FlxG.log("paren subtract found");
										return new OpAdd(stringCompile(parsedEq.slice(z, lParen-1)), new OpSubtract(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")*") == rParen) {
										FlxG.log("paren mult found");
										return new OpAdd(stringCompile(parsedEq.slice(z, lParen - 1)), new OpMultiply(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (parsedEq.indexOf(")/") == rParen) {
										FlxG.log("paren div found");
										return new OpAdd(stringCompile(parsedEq.slice(z, lParen - 1)), new OpDivide(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (parsedEq.indexOf(")^") == rParen) {
										FlxG.log("paren exp found");
										return new OpAdd(stringCompile(parsedEq.slice(z, lParen - 1)), new OpExponent(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (rParen == parsedEq.length - 1) { //end of the equation
										FlxG.log("simple parens found");
										return new OpAdd(stringCompile(parsedEq.slice(z, lParen - 1)), new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))));
									}else { //should not occur
										FlxG.log("problem with parens");
										return new Operation();
									}
								} else if (parsedEq.indexOf("-(") == lParen - 1) { //minus at start of the equation
									FlxG.log("left paren addition found");
									//find and parse the stuff before the corresponding paren section
									if (parsedEq.indexOf(")+") == rParen) {
										FlxG.log("paren add found");
										return new OpSubtract(stringCompile(parsedEq.slice(z, lParen-1)), new OpAdd(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")-") == rParen) {
										FlxG.log("paren subtract found");
										return new OpSubtract(stringCompile(parsedEq.slice(z, lParen-1)), new OpSubtract(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")*") == rParen) {
										FlxG.log("paren mult found");
										return new OpSubtract(stringCompile(parsedEq.slice(z, lParen - 1)), new OpMultiply(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (parsedEq.indexOf(")/") == rParen) {
										FlxG.log("paren div found");
										return new OpSubtract(stringCompile(parsedEq.slice(z, lParen - 1)), new OpDivide(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));							}else if (parsedEq.indexOf(")^") == rParen) {
										FlxG.log("paren exp found");
										return new OpSubtract(stringCompile(parsedEq.slice(z, lParen - 1)), new OpExponent(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (rParen == parsedEq.length - 1) { //end of the equation
										FlxG.log("simple parens found");
										return new OpSubtract(stringCompile(parsedEq.slice(z, lParen - 1)), new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))));
									}else { //should not occur
										FlxG.log("problem with parens");
										return new Operation();
									}
								} else if (parsedEq.indexOf("*(") == lParen - 1) { //mult at start of the equation
									FlxG.log("left paren addition found");
									//find and parse the stuff before the corresponding paren section
									if (parsedEq.indexOf(")+") == rParen) {
										FlxG.log("paren add found");
										return new OpMultiply(stringCompile(parsedEq.slice(z, lParen-1)), new OpAdd(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")-") == rParen) {
										FlxG.log("paren subtract found");
										return new OpMultiply(stringCompile(parsedEq.slice(z, lParen-1)), new OpSubtract(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")*") == rParen) {
										FlxG.log("paren mult found");
										return new OpMultiply(stringCompile(parsedEq.slice(z, lParen - 1)), new OpMultiply(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (parsedEq.indexOf(")/") == rParen) {
										FlxG.log("paren div found");
										return new OpMultiply(stringCompile(parsedEq.slice(z, lParen - 1)), new OpDivide(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));							}else if (parsedEq.indexOf(")^") == rParen) {
										FlxG.log("paren exp found");
										return new OpMultiply(stringCompile(parsedEq.slice(z, lParen - 1)), new OpExponent(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (rParen == parsedEq.length - 1) { //end of the equation
										FlxG.log("simple parens found");
										return new OpMultiply(stringCompile(parsedEq.slice(z, lParen - 1)), new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))));
									}else { //should not occur
										FlxG.log("problem with parens");
										return new Operation();
									}
								}  else if (parsedEq.indexOf("/(") == lParen - 1) { //div at start of the equation
									FlxG.log("left paren addition found");
									//find and parse the stuff before the corresponding paren section
									if (parsedEq.indexOf(")+") == rParen) {
										FlxG.log("paren add found");
										return new OpDivide(stringCompile(parsedEq.slice(z, lParen-1)), new OpAdd(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")-") == rParen) {
										FlxG.log("paren subtract found");
										return new OpDivide(stringCompile(parsedEq.slice(z, lParen-1)), new OpSubtract(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")*") == rParen) {
										FlxG.log("paren mult found");
										return new OpDivide(stringCompile(parsedEq.slice(z, lParen - 1)), new OpMultiply(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (parsedEq.indexOf(")/") == rParen) {
										FlxG.log("paren div found");
										return new OpDivide(stringCompile(parsedEq.slice(z, lParen - 1)), new OpDivide(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));							}else if (parsedEq.indexOf(")^") == rParen) {
										FlxG.log("paren exp found");
										return new OpDivide(stringCompile(parsedEq.slice(z, lParen - 1)), new OpExponent(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (rParen == parsedEq.length - 1) { //end of the equation
										FlxG.log("simple parens found");
										return new OpDivide(stringCompile(parsedEq.slice(z, lParen - 1)), new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))));
									}else { //should not occur
										FlxG.log("problem with parens");
										return new Operation();
									}
								} else if (parsedEq.indexOf("^(") == lParen - 1) { //exp at start of the equation
									FlxG.log("left paren addition found");
									//find and parse the stuff before the corresponding paren section
									if (parsedEq.indexOf(")+") == rParen) {
										FlxG.log("paren add found");
										return new OpExponent(stringCompile(parsedEq.slice(z, lParen-1)), new OpAdd(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")-") == rParen) {
										FlxG.log("paren subtract found");
										return new OpExponent(stringCompile(parsedEq.slice(z, lParen-1)), new OpSubtract(new OpParen(stringCompile(parsedEq.slice(lParen+1,rParen))), stringCompile(parsedEq.slice(rParen+2))));
									}else if (parsedEq.indexOf(")*") == rParen) {
										FlxG.log("paren mult found");
										return new OpExponent(stringCompile(parsedEq.slice(z, lParen - 1)), new OpMultiply(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (parsedEq.indexOf(")/") == rParen) {
										FlxG.log("paren div found");
										return new OpExponent(stringCompile(parsedEq.slice(z, lParen - 1)), new OpDivide(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));							}else if (parsedEq.indexOf(")^") == rParen) {
										FlxG.log("paren exp found");
										return new OpExponent(stringCompile(parsedEq.slice(z, lParen - 1)), new OpExponent(new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))), stringCompile(parsedEq.slice(rParen + 2))));
									}else if (rParen == parsedEq.length - 1) { //end of the equation
										FlxG.log("simple parens found");
										return new OpExponent(stringCompile(parsedEq.slice(z, lParen - 1)), new OpParen(stringCompile(parsedEq.slice(lParen + 1, rParen))));
									}else { //should not occur
										FlxG.log("problem with parens");
										return new Operation();
									}
								}else {
									FlxG.log("problem with left paren");
									return Operation(null);
								}
					} else if (numPattern.exec(parsedEq) != null){ FlxG.log("a number was found");
								//if it's just numbers, make numbers ya goofball
								return new OpNumber(new Number(parsedEq as String));
					} else if (varPattern.exec(parsedEq) != null) { FlxG.log("a variable was found");
								return new OpVar();
					} else { // should not be encountered
							//it might still be something else, in which case it's wrong
							FlxG.log("OH GOD WHAT HAPPENED: " + parsedEq + ".");
							(FlxG.state as GameState).eqError.text = ("Warning: " + parsedEq) as String;
					}
			//in the event of an empty array...
			FlxG.log("empty array");
			return new Operation();
		}
		private var numVarReg:RegExp = /\d+[xy]/g; // regex to check for numbers next to vars 
		private var varNumReg:RegExp = /[xy]\d+/g; // regex to check for vars next to numbers 
		private var parenNumReg:RegExp = /\)\d+/g; // regex to check for parens next to numbers 
		private var numParenReg:RegExp = /\d+\(/g; // regex to check for numbers next to parens 
		private var twoParenReg:RegExp = /\)\(/g; // regex to check for numbers next to parens 
		private function prepare(eq:String):String {
			var result:String = eq.replace(new RegExp(" ", "g"), ""); // trim the spaces
			FlxG.log("Trimmed: " + result);
			//FlxG.log("preparing " + eq);
			//#x -> #*x
			result = result.replace(numVarReg, insertMultVar);
			//x# -> x*#
			result = result.replace(varNumReg, insertVarMult);
			//)( -> )*(
			result = result.replace(twoParenReg, ")*(");
			//)x -> )*x
			result = result.replace(new RegExp(")x","g"), ")*x");
			//x( -> x*(
			result = result.replace(new RegExp("x(","g"), "x*(");
			//xx -> x*x
			result = result.replace(new RegExp("xx","g"), "x*x");
			//)# -> )*#
			result = result.replace(parenNumReg, insertParenMult);
			//#( -> #*(
			result = result.replace(numParenReg, insertMultParen);
			//FlxG.log("prepared " + result);
			return result;
		}
		private function insertMultVar():String {
			var change:String = arguments[0]; //get the substring that tested positive
			change = change.substr(0, change.length - 1) + "*x";
			FlxG.log(change);
			return change;
		}	
		private function insertVarMult():String {
			var change:String = arguments[0]; //get the substring that tested positive
			change = "x*" + change.substr(1, change.length);
			FlxG.log(change);
			return change;
		}
		private function insertParenMult():String {
			var change:String = arguments[0]; //get the substring that tested positive
			change = ")*" + change.substr(1, change.length);
			FlxG.log(change);
			return change;
		}
		private function insertMultParen():String {
			var change:String = arguments[0]; //get the substring that tested positive
			change = change.substr(0, change.length - 1) + "*(";
			FlxG.log(change);
			return change;
		}
				
		private function inParen(index:Number, equat:String):Boolean {
			var symb:String = equat.charAt(index);
			FlxG.log("checking " + symb);
			var i:Number = equat.lastIndexOf("(", index); //finding closest (, (x 
			var j:Number = equat.indexOf(")", index + 1);
			
			return false;
		}
		//finds the index of the right paren corresponding to the first left paren
		private function findrParen(Eq:String, rI:Number, lI:Number):Number {
			//we already know both a left and right paren were found
			if (Eq.slice(lI + 1, rI).indexOf("(") != -1) { //there's another set of parens somewhere!
				return rI;
			}else { //simple
				return rI;
			}
		}
		
		private function beforeParen(sym:String, eq:String):Boolean {
			var lParen:Number = eq.indexOf("(");
			if (lParen < 0) { //no parens were found
				return true;
			} else { //we know the symbol exists, so we just have to check
				return (eq.indexOf(sym) < lParen);
			}
		}
		
		private function simpleCompile(parsedEq:Array):Operation {
			FlxG.log("Compiling Regular Equation");
			var i:Number;
			for (i = 0; i < parsedEq.length; i++) {
				FlxG.log(i); //must follow reverse pemdas (trust me) 
				if (parsedEq[i].indexOf("+") != -1) { FlxG.log("a plus was found");
						return new OpAdd(simpleCompile(parsedEq.slice(0, i-1)), simpleCompile(parsedEq.slice(i+1)));
					}else if (parsedEq[i].indexOf("-") != -1) { FlxG.log("a minus was found");
						return new OpSubtract(simpleCompile(parsedEq.slice(0, i - 1)), simpleCompile(parsedEq.slice(i + 1)));
					}else if (parsedEq[i].indexOf("*") != -1) { FlxG.log("a mult was found");
						return new OpMultiply(simpleCompile(parsedEq.slice(0, i - 1)), simpleCompile(parsedEq.slice(i + 1)));
					}else if ((parsedEq[i].indexOf("\\") != -1)||(parsedEq[i].indexOf("/") != -1)){ FlxG.log("a div was found");
						return new OpDivide(simpleCompile(parsedEq.slice(0, i - 1)), simpleCompile(parsedEq.slice(i + 1)));
					}else if (parsedEq[i].indexOf("^") != -1) { FlxG.log("a div was found");
						return new OpExponent(simpleCompile(parsedEq.slice(0, i - 1)), simpleCompile(parsedEq.slice(i + 1)));
					}else if (varPattern.exec(parsedEq[i]) != null) { FlxG.log("a variable was found");
						return new OpVar();
					}else if (numPattern.exec(parsedEq[i]) != null){ FlxG.log("a number was found");
						return new OpNumber(new Number(parsedEq[i] as String));
						//check for parens or vars, if found make a multiplier 
						//if it's just numbers, make numbers ya goofball
						//it might still be something else, in which case it's wrong
					} else { // should not be encountered
						FlxG.log("OH GOD WHAT HAPPENED: " + parsedEq[i] + ".");
					}
			}
			//in the event of an empty array...
			return new Operation();
		}
		
		private function schemeCompile(parsedEq:Array):Operation {
			FlxG.log("Compiling Scheme Equation");
			var i:Number;
			for (i = 0; i < parsedEquation.length; i++) {
				//FlashConnect.trace(parsedEquation[i]);
				if (parsedEquation[i].indexOf("*") != -1) { FlxG.log("a mult was found");
						return new OpMultiply(schemeCompile(parsedEq.slice(0, i - 1)), schemeCompile(parsedEq.slice(i + 1)));
					}else if (parsedEquation[i].indexOf("/") != -1) { FlxG.log("a div was found");
						return new OpDivide(schemeCompile(parsedEq.slice(0, i - 1)), schemeCompile(parsedEq.slice(i + 1)));
					}else if (parsedEquation[i].indexOf("+") != -1) { FlxG.log("a plus was found");
						return new OpAdd(schemeCompile(parsedEq.slice(0, i-1)), schemeCompile(parsedEq.slice(i+1)));
					}else if (parsedEquation[i].indexOf("-") != -1) { FlxG.log("a minus was found");
						return new OpSubtract(schemeCompile(parsedEq.slice(0, i - 1)), schemeCompile(parsedEq.slice(i + 1)));
					}else if (parsedEquation[i].indexOf("^") != -1) { FlxG.log("a div was found");
						return new OpExponent(schemeCompile(parsedEq.slice(0, i - 1)), schemeCompile(parsedEq.slice(i + 1)));
					}else if (varPattern.exec(parsedEquation[i]) != null) { FlxG.log("a variable was found");
						return new OpVar();
					}else if (numPattern.exec(parsedEquation[i]) != null){ FlxG.log("a number was found");
						return new OpNumber(new Number(parsedEq[i] as String));
						//a number or some other excludable variable
						//check for parens or vars, if found make a multiplier 
					} else { // should not be encountered
						FlxG.log("OH GOD WHAT HAPPENED: " + parsedEq[i] + ".");
				}
					
			}
			return new Operation();
		}
		
		public function alter(inEq:String):void {
			equation = prepare(inEq);
			FlxG.log(equation);
			//parsedEquation = inEq.split(" "); //take the equation and turn it into an array
			//FlxG.log("Parsing " + parsedEquation);
			equals = stringCompile(equation);
		}
		private function findNumber(parsedEqSegment:String):Number{
			var i:Number = NaN;
				if (numPattern.exec(parsedEqSegment)) { //FlashConnect.trace("a number was found");
				
				}
				return i;
			}
		private function convert(inEq:String):Array {
				var out:Array = new Array();
				return out;
			}
		public function isSimple(part:Array):Boolean{
			return false;
			}
		}
	
	}