module Serializing
//------------------
import Utile;
//------------------
import IO;
import Set;
import util::Resources;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import ParseTree;
import util::ValueUI;
import Node;
import String;


public str subTreeToString (Statement subTree){
	//text(subTree);
	str subTreeString = "";
	top-down visit (subTree) {
		case Statement s: {
			if(/<nameStatement:^\w+>/ := toString(s)){
				if(nameStatement != "expressionStatement" && nameStatement != "declarationStatement")
					subTreeString += nameStatement/* + " "*/;
				if(nameStatement == "declarationStatement")
					subTreeString += "=";
			}
		}
		case \characterLiteral(x):
			subTreeString += x/* + " "*/;
		case \fieldAccess(_, _, x):
			subTreeString += x/* + " "*/;
		case \fieldAccess(_,x):
			subTreeString += x/* + " "*/;
		case \number(x):
			subTreeString += x/* + " "*/;
		case \stringLiteral(x):
			subTreeString += x/* + " "*/;
		case \variable(x,_):
			subTreeString += x/* + " "*/;
		case \variable(x,_,_):
			subTreeString += x/* + " "*/;
		case \infix(_,x,_):
			subTreeString += x/* + " "*/;
    	case \postfix(_,x):
    		subTreeString += x/* + " "*/;
    	case \prefix(x,_):
    		subTreeString += x/* + " "*/;
    	case \markerAnnotation(x):
    		subTreeString += x/* + " "*/;
    	case \normalAnnotation(x,_):
    		subTreeString += x/* + " "*/;
    	case \memberValuePair(x,_):
    		subTreeString += x/* + " "*/;             
    	case \singleMemberAnnotation(x,_):
    		subTreeString += x/* + " "*/;
		case \assignment(_,x,_):
			subTreeString += x/* + " "*/;
		case \simpleName(nameVariable): 
			subTreeString += nameVariable/* + " "*/;
		case \methodCall(_,nameMethod,_):
			subTreeString += nameMethod/* + "() "*/;
		case \methodCall(_,_,nameMethod,_):
			subTreeString += nameMethod/* + "() "*/;
	}
	//text(subTreeString);
	return subTreeString;
}

public str serializingAST(Declaration astMethod){
	//text(astMethod);
	list[str] subTreesList = [];
	str methodWhole = "";
	top-down visit (astMethod) {
		case \block(subTrees):{
			//text(subTrees);
			for(int i <-[0..size(subTrees)]){
				subTreesList += subTreeToString(subTrees[i]);
			}
		}
		case \method(x,y,_,_,_):{
			subTreesList += toString(x)/* + " "*/;
			subTreesList += y/* + " "*/;
		}
	}
	for(method <-  subTreesList){
		methodWhole += method;
	}
	if(/<sequence:,*src=\|.+\|\(.+?\),decl=\|.+?\|>/ := methodWhole){
		methodWhole = replaceFirst(methodWhole, sequence, "");
	}
	if(/<sequence:typ=class\(\|java\+class:\/\/\/.+?\)\)\)>/ := methodWhole){
		methodWhole = replaceFirst(methodWhole, sequence, "");
	}
	//text(methodWhole);
	//text(subTreesList);
	return methodWhole;
}

public map[str,loc] mappingSubtreesWithLocation(set[Declaration] astsMethods){
	map[str,loc] mapping = ();
	astsList = toList(astsMethods);
	for(int i <- [0..size(astsList)]){
		mapping += (serializingAST(astsList[i]):astsList[i].src);
	}
	text(mapping);
	return mapping;
}

public list[str] serializingASTS(set[Declaration] astsMethods){
	list[str] nodeList = [];
	astsList = toList(astsMethods);
	//println(size(astsList));
	//text(astsList);
	for(int i <- [0..size(astsList)]){
		nodeList += serializingAST(astsList[i]);
	}
	text(nodeList);
	println(size(nodeList));
	return nodeList;
}