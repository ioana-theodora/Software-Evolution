module SIG_Maintainability_Model

import IO;
import List;
import Read;
import Count;

public void volume(loc project){

	list[loc] files = returnListFiles(project);
	int linesOfCode = countCodeLinesProject(files);
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