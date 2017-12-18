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


/*public list[node] serializingAST(node iNode){
	text(iNode);
	list[node] nodeList = [];
	top-down visit (iNode) {
		case node x: {
			nodeList += x;
		}
	}
	text(nodeList);
	return nodeList;
}*/

public str subTreeToString (Statement subTree){
	text(subTree);
	str subTreeString = "";
	top-down visit (subTree) {
		case Statement s: {
			if(/<nameStatement:^\w+>/ := toString(s))
				subTreeString += nameStatement + " ";
		}
		case \simpleName(nameVariable): 
			subTreeString += nameVariable + " ";
		case \methodCall(_,nameMethod,_):
			subTreeString += nameMethod + "() ";
		case \methodCall(_,_,nameMethod,_):
			subTreeString += nameMethod + "() ";
	}
	text(subTreeString);
	return "0";
}

public list[str] serializingAST(Declaration astMethod){
	text(astMethod);
	list[str] subTreesList = [];
	top-down visit (astMethod) {
		case \block(subTrees):{
			text(subTrees);
			for(int i <-[0..size(subTrees)]){
				subTreesList += subTreeToString(subTrees[i]);
			}
		}
	}
	text(subTreesList);
	return subTreesList;
}

public list[node] serializingASTS(set[Declaration] astsMethods){
	list[node] nodeList = [];
	astsList = toList(astsMethods);
	println(size(astsList));
	text(astsList);
	/*for(astMethod <- astsMethods){
		nodeList += serializingAST(astMethod);
	}*/
	text(astsList[38].decl);
	///nodeList += serializingAST(a[1]);
	text(serializingAST(astsList[38]));
	//println(nodeList);
	println(size(nodeList));
	return nodeList;
}