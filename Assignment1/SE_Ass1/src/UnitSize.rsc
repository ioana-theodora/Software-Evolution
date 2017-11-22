module UnitSize

import IO;
import List;
import Count;

public list[int] evaluateUnitSize(list[loc] units){

	lowRiskLines = 0;
	mediumRiskLines = 0;
	highRiskLines = 0;
	veryHighRiskLines = 0;
	list[str] lines = [];
	countLines = 0;
	
	for(u <- units){
		lines = readFileLines(u);
		countLines = countCodeLines(lines);
		
		if(countLines >= 0 && countLines < 10)
			lowRiskLines += countLines;
			
		else if(countLines >= 10 && countLines < 50)
			mediumRiskLines += countLines;
			
		else if(countLines >= 50 && countLines < 100)
			highRiskLines += countLines;
			
		else if(countLines >= 100)
			veryHighRiskLines += countLines;
	}

	return [lowRiskLines, mediumRiskLines, highRiskLines, veryHighRiskLines];

}