module SIG_Maintainability_Model

import IO;
import List;
import Set;
import Read;
import Count;
import Duplication;
import DateTime;
import Visualization;
import Complexity;
import util::Resources;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import util::ValueUI;
import UnitSize;
import util::Math;


int linesOfCode;
real unitLow;
real unitMed;
real unitHigh;
real unitVHigh;
real compLow;
real compMed;
real compHigh;
real compVHigh;

private int calculateRating(list[int] values){

	int rating = 0;
	real average = (sum(values)*1.0)/size(values);
	
	if(average >= 1 && average < 2)
			rating = 1;	
	
	else if(average >= 2 && average < 3)
			rating = 2;	
			
	
	else if(average >= 3 && average < 4)
			rating = 3;	

	
	else if(average >= 4 && average < 5)
			rating = 4;	
	
	
	else
		rating = 5;
	
	
	return rating;
}

private str rating(int val){

	str final = "";
	
	switch(val){
		case 5: final = "++"; 
	
		case 4: final = "+";
		
		case 3: final = "o";
		
		case 2: final = "-";
		
		case 1: final = "--";
	
	}
	
	return final;

}

public int unitSize(loc project){
	
	list[loc] units = returnListUnits(project);
	list[int] values = evaluateUnitSize(units);
	unitLow = ((values[0]*1.0)/linesOfCode)*100;
	unitMed = ((values[1]*1.0)/linesOfCode)*100;
	unitHigh = ((values[2]*1.0)/linesOfCode)*100;
	unitVHigh = ((values[3]*1.0)/linesOfCode)*100;
	int rating = 0;

	if(unitMed < 25 && unitHigh < 0 && unitVHigh < 0)
		rating = 5;
		
	else if(unitMed < 30 && unitHigh < 5 && unitVHigh < 0)
		rating = 4;

	else if(unitMed < 40 && unitHigh < 10 && unitVHigh < 0)
		rating = 3;

	else if(unitMed < 50 && unitHigh < 15 && unitVHigh < 5)
		rating = 2;
		
	else
		rating = 1;
		
	println("low: <unitLow>");
	println("medium: <unitMed>");
	println("high: <unitHigh>");
	println("veryHigh: <unitVHigh>");
		
	return rating;
}

public int volume(loc project){

	list[loc] files = returnListFiles(project);
	linesOfCode = countCodeLinesProject(files);
	total = countTotalLinesProject(files);
	blanks = countBlankLinesProject(files);
	comments = countCommentLinesProject(files);
	println("Total: <total>");
	println("Blank: <blanks>");
	println("Comments: <comments>");
	println("LOC: <linesOfCode>");
	result = (linesOfCode/1000);
	str final = "";
	int rating = 0;
	
	if(result >= 0 && result < 66){
		final = "++";
		rating = 5;	
	}
		
	else if(result >= 66 && result < 246){
		final = "+";
		rating = 4;	
	}
		
	else if(result >= 246 && result < 665){
		final = "o";
		rating = 3;	
	}
		
	else if(result >= 665 && result < 1310){
		final = "-";
		rating = 2;	
	}
		
	else{
		final = "--";
		rating = 1;	
	}
	
	println("Volume: <final>");
	 
	return rating;

}



public list[int] duplication(loc project){

	st = now();

	list[loc] files = returnListFiles(project);
	list[str] lines = cleanLines(projectLines(project));
	list[int] duplicates = countDuplicates(lines);
	println("Duplicates: <duplicates[0]>");
	println("Lines: <duplicates[1]>");
	real result = (((duplicates[0]*6.0)+duplicates[1])/linesOfCode)*100;
	str final = "";
	int rating = 0;
	
	if(result >= 0 && result < 3){
		final = "++";
		rating = 5;
	}
		
	else if(result >= 3 && result < 5){
		final = "+";
		rating = 4;
	}
		
	else if(result >= 5 && result < 10){
		final = "o";
		rating = 3;
	}
		
	else if(result >= 10 && result < 20){
		final = "-";
		rating = 2;
	}	
		
	else{
		final = "--";
		rating = 1;
	}

	println("Duplication: <final>");
	
	println(createDuration(st,now()));
	
	return [rating, duplicates[1]];

}

public int analysability(int volume, int duplication, int unitsize){

	int result = calculateRating([volume,duplication,unitsize]);
	str final = rating(result);
	
	println("Analysability: <final>");
	
	return result;
}


public int changeability(int complexunit, int duplication){

	int result = calculateRating([complexunit,duplication]);
	str final = rating(result);
	
	println("Changeability: <final>");
	
	return result;
}


public int testability(int complexunit, int unitsize){

	int result = calculateRating([complexunit,unitsize]);
	str final = rating(result);
	
	println("Testability: <final>");
	
	return result;
}

public int complexity(loc project){
	astsProject = createAstsFromEclipseProject(project/*|project://smallsql0.21_src|*/, true);
	//text(astsProject);
	methodsAst = { m | /Declaration m := astsProject, m is method || m is constructor};
	//text(methodsAst);
	println(size(methodsAst));
	values = unitCyclomaticComplexity(methodsAst);
	compLow = ((values[0]*1.0)/linesOfCode)*100;
	compMed = ((values[1]*1.0)/linesOfCode)*100;
	compHigh = ((values[2]*1.0)/linesOfCode)*100;
	compVHigh = ((values[3]*1.0)/linesOfCode)*100;
	int rating = 0;

	if(compMed < 25 && compHigh < 0 && compVHigh < 0)
		rating = 5;
		
	else if(compMed < 30 && compHigh < 5 && compVHigh < 0)
		rating = 4;

	else if(compMed < 40 && compHigh < 10 && compVHigh < 0)
		rating = 3;

	else if(compMed < 50 && compHigh < 15 && compVHigh < 5)
		rating = 2;
		
	else
		rating = 1;
		
	println("complow: <compLow>");
	println("compmedium: <compMed>");
	println("comphigh: <compHigh>");
	println("compveryHigh: <compVHigh>");
		
	
	return rating;
}


public void main(loc project){

	linesOfCode = 0;
	unitLow = 0.0;
	unitMed = 0.0;
	unitHigh = 0.0;
	unitVHigh = 0.0;
	compLow = 0.0;
	compMed = 0.0;
	compHigh = 0.0;
	compVHigh = 0.0;

	int vol = volume(project);
	int complex = complexity(project);;
	int unitsize = unitSize(project);
	list[int] dup = duplication(project);
	analys = analysability(vol,dup[0],unitsize);
	change = changeability(complex,dup[0]);
	testabl = testability(complex,unitsize);
	maintain = calculateRating([analys,change,testabl]);
	result = rating(maintain);
	
	volRat = rating(vol);
	complexRat = rating(complex);
	unitsizeRat = rating(unitsize);
	dupRat = rating(dup[0]);
	analysRat = rating(analys);
	changeRat = rating(change);
	testablRat = rating(testabl);
	
	visualizeResults(volRat, complexRat, unitsizeRat, dupRat, analysRat, changeRat, 
						testablRat, result, linesOfCode, dup[1], ceil(unitLow), ceil(unitMed),
						ceil(unitHigh), ceil(unitVHigh), ceil(compLow), ceil(compMed),
						ceil(compHigh), ceil(compVHigh));
	
	println("Maintainability: <result>");
	
}