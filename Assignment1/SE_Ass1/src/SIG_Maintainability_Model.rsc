module SIG_Maintainability_Model

import IO;
import List;
import Read;
import Count;
import Duplication;
import DateTime;
import Visualization;

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

public list[int] volume(loc project){

	list[loc] files = returnListFiles(project);
	int linesOfCode = countCodeLinesProject(files);
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
	 
	return [rating, linesOfCode];

}



public list[int] duplication(loc project){

	st = now();

	list[loc] files = returnListFiles(project);
	int linesOfCode = countCodeLinesProject(files);
	list[str] lines = cleanLines(projectLines(project));
	list[int] duplicates = countDuplicates(lines);
	println("Duplicates: <duplicates[0]>");
	println("Lines: <duplicates[1]>");
	real result = (duplicates[1]*1.0/linesOfCode)*100;
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



public void main(loc project){

	list[int] vol = volume(project);
	int complex = 1;
	int unitsize = 1;
	list[int] dup = duplication(project);
	analys = analysability(vol[0],dup[0],unitsize);
	change = changeability(complex,dup[0]);
	testabl = testability(complex,unitsize);
	maintain = calculateRating([analys,change,testabl]);
	result = rating(maintain);
	
	volRat = rating(vol[0]);
	complexRat = rating(complex);
	unitsizeRat = rating(unitsize);
	dupRat = rating(dup[0]);
	analysRat = rating(analys);
	changeRat = rating(change);
	testablRat = rating(testabl);
	
	visualizeResults(volRat, complexRat, unitsizeRat, dupRat, analysRat, changeRat, 
						testablRat, result, vol[1], dup[1]);
	
	println("Maintainability: <result>");
	
}
