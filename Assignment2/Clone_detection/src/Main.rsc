module Main
//------------------
import Type1Clones;
import Type2Clones;
import Utile;
import Visualization;
import Serializing;
//------------------
import IO;
import Set;
import util::Resources;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
//import lang::java::jdt::m3::AST;
import util::ValueUI;

public void Main(loc project){
	astsFromProject = getAstsFromProject(project);
	//text(astsFromProject);
	//text(visualizationClonesFiles(astsFromProject));
	methodsFromAsts = getMethodsfromAsts(astsFromProject);
	//text(methodsFromAsts);
	serilizationsFromMethodsASTS = serializingASTS(methodsFromAsts);
	text(serilizationsFromMethodsASTS);
	
	
	locationAndSerialization = mappingSubtreesWithLocation(methodsFromAsts);
	text(locationAndSerialization);
	
	
	/*locationsOfMethods = getMethodsLocation(methodsFromAsts);
	//text(locationsOfMethods);
	readLineMethods = getMethodsReadLine(locationsOfMethods);
	text(readLineMethods);*/
	
	////////////////// "REPORT" /////////////////////////////////////////////////

	/*lOc = countCodeLinesProject(project.ls);

	//the serialized subtrees will be here
	list[str] serializedSubTrees = [];
	//Not sure if we still this, maybe duplicates can do this right away?
	SuffixTree suffixT = buildST(serializedSubTrees);
	//each list[int] of dups is the indexes from serializedSubTrees that have
	//duplicated code fragments
	list[list[int]] dups = duplicates(suffixT);
	//each list[str] is the duplicated lines of code for each group of dups
	list[list[str]] duplicatedStrs = [];
	//this will help after
	list[list[str]] aux = [];
	
	
	for(d <- dups){
		for(ds <- d){
			//goes to each subtree that have duplicated code, get location, 
			//get lines of code (list[str])
			 location = serializedSubTrees[ds]; //need the location of each subtree
			 									//by using the serialized result
			 lines = cleanLines(readFileLines(location));
			 aux = aux + [lines];
	
		}
		duplicatedStrs = duplicatedStrs + [countDuplicates(aux)];
		writeOnFile(duplicatedStrs,|project://Clone_detection/src/type1clones.txt|);
	}
	
	countDupLines = 0;
	
	for(dstr <- duplicatedStrs)
		countDupLines += size(dstr);

	numOfClones = size(duplicatedStrs);
	numCloneClass = 0;
	
	for(d <- dups, size(d) > 2)
		numCloneClass += 1;
		
	int max = size(duplicatedStrs[0]);
	done = 0;
	maxClone = duplicatedStrs[0];	
		
	while(done == 0){
			
		res = [x | list[str] x <- duplicatedStrs, size(x) > max];
		
		if(isEmpty(res))
			done = 1;
		
		else{
			max = size(res[0]);
			maxClone = res[0];
		
		}
	
	}
	
	//saves the indexes of the clone classes
	list[int] cloneClasses = [indexOf(dups,x) | x <- dups, size(x) > 2];
	
	maxClass = size(duplicatedStrs[cloneClasses[0]]);
	biggerClass = duplicatedStrs[cloneClasses[0]];

	for(cc <- cloneClasses){	
		
		if(max < size(duplicatedStrs[cc])){
			max = size(duplicatedStrs[cc]);
			biggerClass = duplicatedStrs[cc];
		}
	
	}
	
	percentage = countDupLines/lOc;
	
	println("Duplicated Lines: <percantage>%");
	println("Number of clones: <numOfClones>");
	println("Number of clone classes: <numCloneClass>");
	println("Biggest Clone: <max> lines.");
	println("Biggest Clone Class: <maxClass> lines.");
	println("Example Clone1: <maxClone>");
	println("Example Clone2: <biggerClass>");*/
}
