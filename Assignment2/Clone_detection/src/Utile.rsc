module Utile
//------------
import lang::java::jdt::m3::AST;
import util::ValueUI;
import IO;
import Set;
import List;
//import Tuple;


public set[Declaration] getAstsFromProject(loc project){
	return createAstsFromEclipseProject(project, true);
}

public set[Declaration] getMethodsfromAsts(set[Declaration] astsFromProject){
	return { methodsProject | /Declaration methodsProject := astsFromProject, methodsProject is method};
}

public loc getSrc(Declaration methodAst){
	return methodAst.src;
}

public set[loc] getMethodsLocation(set[Declaration] methodsAsts){
	return mapper(methodsAsts, getSrc);
}

public set[list[str]] getMethodsReadLine(set[loc] methodsLocations){ //set or list - what is more utile?
	//return stringMethods = mapper(methodsLocations, readFileLines);//do for here, but better than for after it works
	println("Total number of methods: <size(methodsLocations)>");
	set[list[str]] methodsGood = {};
	int counterGood = 0;
	set[loc] methodsBad = {};
	int counterBad = 0;
	for(methodLocation <- methodsLocations){
		try {methodsGood += readFileLines(methodLocation); counterGood += 1;}
		catch: {methodsBad += methodLocation; counterBad += 1;}
	}
	text(methodsGood);
	println("Good methods locations: <counterGood>");
	text(methodsBad);
	println("Bad methods location: <counterBad>");
	return methodsGood;
}