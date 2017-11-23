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
import Type;
import Count;
import Read;
//--------------------------------


public list[int] unitCyclomaticComplexity(set[Declaration] methodsInProject){
	list[int] calculatedRiskFile = [0, 0, 0, 0];
	int counter = 0;
	loc methodLocation;
	for(methodAST <- methodsInProject){
		counter += 1;
		//text(methodAST);//text each method for check
		int complexity = 1; //always starts with 1
		
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
		}
		methodINmethod = { m | /TypeSymbol  m := methodAST, m is method};
		//println(methodINmethod);
		for(m <- methodINmethod){
			println(m);
			visit(m){
				case \method(x,_,_,_): methodLocation = x;
			}
		}
		println("---Done---");
		println(methodLocation);
		//Take out of comment after problem solved
		holder1 = calculatedRiskFile;
		holder2 = riskEvaluation(complexity, methodLocation, 0, 0, 0, 0);
		for(int i <- [0..size(holder1)]){
			calculatedRiskFile[i] = holder1[i]+holder2[i];
		}
		//println(calculatedRiskFile);
	}
	return calculatedRiskFile;

}

public list[int] riskEvaluation(int complexityPerUnit, loc methodToEvaluate, int locLow, int locModerate, int locHigh, int locVeryHigh){
	println("Complexity: <complexityPerUnit>");
	if(complexityPerUnit >= 1 && complexityPerUnit <= 10){
		println("Low risk");
		println(methodToEvaluate);
		locLow += methodLOC(methodToEvaluate);
	}
	if(complexityPerUnit >= 11 && complexityPerUnit <= 20){
		println("Moderate risk");
		locModerate += methodLOC(methodToEvaluate);
	}
	if(complexityPerUnit >= 21 && complexityPerUnit <= 50){
		println("High risk");
		locHigh += methodLOC(methodToEvaluate);
	}
	if(complexityPerUnit >= 51){
		println("Very high risk");
		locVeryHigh += methodLOC(methodToEvaluate);
	}
	risk = [locLow, locModerate, locHigh, locVeryHigh];
	return risk;
}

public int methodLOC(loc methodToEvaluate){

	println(typeOf(methodToEvaluate));
	println(methodToEvaluate);
	locMethod = countCodeLinesProject([methodToEvaluate]);

	return locMethod;
}

