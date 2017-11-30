module Main
//------------------
import Type1Clones;
import Type2Clones;
import Utile;
//------------------
import IO;
import util::Resources;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
//import lang::java::jdt::m3::AST;
import util::ValueUI;

public void Main(loc project){
	astsFromProject = getAstsFromProject(project);
	//text(astsFromProject);
	methodsFromAsts = getMethodsfromAsts(astsFromProject);
	//text(methodsFromAsts);
	locationsOfMethods = getMethodsLocation(methodsFromAsts);
	//text(locationsOfMethods);
	readLineMethods = getMethodsReadLine(locationsOfMethods);
	text(readLineMethods);
}