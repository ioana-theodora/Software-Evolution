module SIG_Maintainability_Model

import IO;
import List;
import Read;
import Count;
import Duplication;


public void volume(loc project){

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
	
	if(result >= 0 && result < 66)
		final = "++";
		
	else if(result >= 66 && result < 246)
		final = "+";
		
	else if(result >= 246 && result < 665)
		final = "o";
		
	else if(result >= 665 && result < 1310)
		final = "-";
		
	else
		final = "--";
	
	println("Volume: " + final);

}



public void duplication(loc project){

	list[loc] files = returnListFiles(project);
	int linesOfCode = countCodeLinesProject(files);
	list[str] lines = cleanLines(projectLines(project));
	list[int] duplicates = countDuplicates(lines);
	println("Duplicates: <duplicates[0]>");
	println("Lines: <duplicates[1]>");
	real result = (duplicates[1]*1.0/linesOfCode)*100;
	str final = "";
	
	if(result >= 0 && result < 3)
		final = "++";
		
	else if(result >= 3 && result < 5)
		final = "+";
		
	else if(result >= 5 && result < 10)
		final = "o";
		
	else if(result >= 10 && result < 20)
		final = "-";
		
	else
		final = "--";

	println("Duplication: " + final);

}
