module Main
//------------------
import Type1Clones;
import Type2Clones;
import Utile;
import SuffixTrees;
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
	
	
	
////////////////// "REPORT" /////////////////////////////////////////////////
	
	list[string] serializedSubTrees = [];
	SuffixTree suffixT = buildST(serializedSubTrees);
	list[list[int]] dups = duplicates(suffixT);
	//each list[str] is the duplicated lines of code for each group of dups
	list[list[str]] duplicatedStrs = [];
	//need to change aux type
	list[str] aux = [];
	
	//Need to change this for loop, just writing here the main idea
	for(d <- dups){
		for(ds <- d){
			//goes to each subtree that have duplicated code, get location, 
			//get lines of code (list[str])
			 aux = aux + serializedSubTrees[ds];
	
		}
		duplicatedStrs = duplicatedStrs + [countDuplicates(aux)];
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
	
	//NOT DONE!!!
	
}