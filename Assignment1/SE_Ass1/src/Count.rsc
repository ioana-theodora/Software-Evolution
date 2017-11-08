module Count

import IO;
import List;
import Read;

public int countTotalLines(list[str] file){
	return size(file);
}

public int countTotalLinesProject(list[loc] project){
	
	lines = 0;
	
	for(p <- project)
		lines += countTotalLines(readFileLines(p));

	return lines;
}

public int countBlankLines(list[str] file){
	count = 0;
	for(l <- file){
		if(/^[ \t\n]*$/ := l)
			count += 1;
	}
	
	return count;

}

public int countBlankLinesProject(list[loc] project){

	lines = 0;
	for(p <- project)
		lines += countBlankLines(readFileLines(p));

	return lines;
}

public int countCommentLines(list[str] file){
	count = 0;
	for(l <- file){
		if(/((\s|\/*)(\/\*|\s\*)|[^\w,\;]\s\/*\/|\/*\/)/ := l)
			count += 1;
			
	}

	return count;
}

public int countCommentLinesProject(list[loc] project){
	lines = 0;
	for(p <- project)
		lines += countCommentLines(readFileLines(p));
	
	return lines;

}


public int countCodeLines (list[str] file){

	int lines = size(file);
	lines = lines - (countBlankLines(file) + countCommentLines(file));

	return lines;
}

public int countCodeLinesProject(list[loc] project){
	lines = 0;
	for(p <- project)
		lines += countCodeLines(readFileLines(p));
	
	return lines;
}

