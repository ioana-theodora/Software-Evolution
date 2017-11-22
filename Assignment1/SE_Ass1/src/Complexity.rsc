module Complexity
//-----------------------------------------
import IO;
import Set;
import String;
import List;
import util::Resources;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import util::ValueUI;
import Exception;
//--------------------------------


public list[int] unitCyclomaticComplexity(set[Declaration] methodsInFile){
	/*int complexityCounterLow = 0;
	int complexityCounterModerate = 0;
	int complexityCounterHigh = 0;
	int complexityCounterVeryHigh = 0;*/
	//--------------------------------
	/*int locLow = 0;
	int locModerate = 0;
	int locHigh = 0;
	int locVeryHigh = 0;*/
	//-------------------------------
	list[int] calculatedRiskFile = [0, 0, 0, 0];
	int counter = 0;
	for(methodAST <- methodsInFile){
		counter += 1;
		text(methodAST);
		int complexity = 1; //always starts with 1
		loc methodLocation;
		println("Analysing method");
		visit(methodAST){
			case \if(_,_) : complexity += 1;
			case \if(_,_,_) : complexity += 1;
			case \case(_) : complexity += 1;
			case \defaultCase() : complexity += 1;
			case \for(_,_,_) : complexity += 1;
			case \for(_,_,_,_) : complexity += 1;
			case \foreach(_,_,_) : complexity += 1;
			case \while(_,_) : complexity += 1;
			case \do(_,_) : complexity += 1;
			case \break() : complexity += 1;
			case \break(_) : complexity += 1;
			case \continue() : complexity += 1;
			case \continue(_) : complexity += 1;
			case \throw(_) : complexity += 1;
			case \catch(_,_) : complexity += 1;
			case \conditional(_,_,_) : complexity += 1; //x?y:z
			case \infix(_,/(\B&&\B|\B\|\|\B)/,_) : complexity += 1; //match only full non-words && and ||
			//case \method(x,_,_,_,_):text(x);
			case \method(x,_,_,_) : methodLocation = x;//why error? it works...
		}
		println("---Done---");
		//println("Complexity: <complexity>");
		println(methodLocation);
		holder1 = calculatedRiskFile;
		holder2 = riskEvaluation(complexity, methodLocation, 0, 0, 0, 0);
		for(int i <- [0..size(holder1)-1]){
			calculatedRiskFile[i] = holder1[i]+holder2[i];
		}
		//calculatedRiskFile += riskEvaluation(complexity, methodLocation, 0, 0, 0, 0);
		println(calculatedRiskFile);
	}
	return calculatedRiskFile;
}

public list[int] riskEvaluation(int complexityPerUnit, loc methodToEvaluate, int locLow, int locModerate, int locHigh, int locVeryHigh){
	if(complexityPerUnit >= 1 && complexityPerUnit <= 10){
		println("Low risk");
		//complexityCounterLow += 1;
		locLow += methodLOC(methodToEvaluate);
	}
	if(complexityPerUnit >= 11 && complexityPerUnit <= 20){
		println("Moderate risk");
		//complexityCounterModerate += 1;
		locModerate += methodLOC(methodToEvaluate);
	}
	if(complexityPerUnit >= 21 && complexityPerUnit <= 50){
		println("High risk");
		//complexityCounterHigh += 1;
		locHigh += methodLOC(methodToEvaluate);
	}
	if(complexityPerUnit >= 51){
		println("Very high risk");
		//complexityCounterVeryHigh += 1;
		locVeryHigh += methodLOC(methodToEvaluate);
	}
	risk = [locLow, locModerate, locHigh, locVeryHigh];
	return risk;
}

public int methodLOC(loc methodToEvaluate){
	list[str] allLocMethodStr;
	methodSrc = readFile(methodToEvaluate);
	allLocMethodStr = split("\n", methodSrc);
	allLocMethod = size(allLocMethodStr);
	//println(allLocMethod);
	blankLines = countBlankLines(allLocMethodStr);
	//println(blankLines);
	commentLines = countCommentLines(allLocMethodStr);
	//println(commentLines);
	locMethod = allLocMethod - blankLines - commentLines;
	//println(locMethod);
	return locMethod;
}

public int countBlankLines(list[str] file){
	count = 0;
	for(l <- file){
		if(/^[ \t\n]*$/ := l)
			count += 1;
	}
	return count;
}

public int countCommentLines(list[str] file){
	count = 0;
	open = 0;
	for(l <- file){
			
			if(/^[\s\t\n]*\/\// := l){
				count += 1;
				
			}
			
			else if(/^.*\*\/[\s\t\n]*$/ := l){
				if(!(!/^[\s\t\n]*\/\*.*\*\/$/ := l && /^[\s\t\n]*<x:[\s\S]+>\/\*.*\*\/$/ := l)){
					count += 1;
					open = 0;
				}	
			}
			
			
			else if(open == 1 && !(/^[ \t\n]*$/ := l)){
				count += 1;
			}
			
			
			else if(/^[\s\t\n]*\/\*.*$/ := l){
				count += 1;
				open = 1;
			}

			else if(/^[\s\t\n\S]*\/\*.*/ := l){
					if(!/^[\s\t\n\S]*\"[\s\S]*\/\*|^.*\*\// := l)
						open = 1;
			}		
	}

	return count;
}