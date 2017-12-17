module Type1Clones

private list[str] commentLines(list[str] lines){

	list[str] result = [];
	open = 0;
	for(l <- lines){
			
			if(/^[\s\t\n]*\/\// := l){
				result = result + l;
				
			}
			
			else if(/^.*\*\/[\s\t\n]*$/ := l){
				if(!(!/^[\s\t\n]*\/\*.*\*\/$/ := l && /^[\s\t\n]*<x:[\s\S]+>\/\*.*\*\/$/ := l)){
					result = result + l;
					open = 0;
				}	
			}
			
			
			else if(open == 1 && !(/^[ \t\n]*$/ := l)){
				result = result + l;
			}
			
			
			else if(/^[\s\t\n]*\/\*.*$/ := l){
				result = result + l;
				open = 1;
			}

			else if(/^[\s\t\n\S]*\/\*.*/ := l){
					if(!/^[\s\t\n\S]*\"[\s\S]*\/\*|^.*\*\// := l)
						open = 1;
			}		
	}

	return result;


}

public list[str] cleanLines(list[str] lines){

	list[str] result = [];
	list[str] comments = commentLines(lines);
	str aux = "";

	for(l <- lines){
		
		if(!(/^[ \t\n]*$/ := l) && (l notin comments) && !(/<word:import ><rest:.*;$>/ := l) 
				&& !(/^[ \t\n]*\{[\s\t\n]*$/ := l)  && !(/[ \t\n]*\}[\s\n\t]*$/ := l)
				&& !(/<first:package ><other:.*;$>/ := l)){ //&& !(/^[ \t\n]*@Override$/ := l) 
				//&& !(/^[ \t\n]*;$/ := l)){
				
			aux = trim(l);
			result = result + aux;
			
		}
	
	}

	return result;
}


public list[str] countDuplicates (list[list[str]] file){
	
	int max = size(file[0]);
	done = 0;
	string = file[0];
	
	while(done == 0){
			
		res = [x | list[str] x <- file, size(x) > max];
		
		if(isEmpty(res))
			done = 1;
		
		else{
			max = size(res[0]);
			string = res[0];
		
		}
	
	}
	
	list[str] equalLines = [];
	list[str] auxEL = [];
	index1 = 0;
	index2 = 0;
	count = 0;
	intersect = 0;
	list[list[str]] toCompare = delete(file,indexOf(file,string));
	
	for(c <- toCompare){
		maximum = size(c);
		while(index2 < max && index2 < maximum && index1 < max){
			if((string[index1] == c[index2])){
				 if((index1 + 5) < max && (index2 + 5) < max 
				    && (index2 + 5) < maximum
					&& (string[index1 + 5] == c[index2 + 5])){

					count += 1;
					if(intersect == 0)
						auxEL = auxEL + string[index1];
					
					else if(string[index1] in equalLines)
						auxEL = auxEL + string[index1];

					
					while((index1 + count) < max && (index2 + count) < max
							&& (index2 +  count) < maximum 
							&& (string[index1 + count] == c[index2 + count])){
						
						if(intersect == 0)
							auxEL = auxEL + string[index1 + count];
					
						else if(string[index1+count] in equalLines)
							auxEL = auxEL + string[index1 + count];
							
						count += 1;
					}
					
					if(count >= 6){
						index1 += count;
						equalLines = auxEL;
						auxEL = [];
					}
					
					else{
						index1 += 6;
						auxEL = [];
					}
					
				}
				
				else
					index1 += 6;
			
			}
			
			else
				index1 += 1;
				
			count = 0;
		}
		
		index1 = 0;
		index2 = 0;
		auxEL = [];
		intersect = 1;

	}
	
	return equalLines;
}

public void writeOnFile(list[str] lines, file){
	
	for(l <- lines)
		lines[indexOf(lines,l)] = l+"\n";
	
	writeFile(file,lines);

}