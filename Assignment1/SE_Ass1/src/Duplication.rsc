module Duplication

import IO;
import List;
import String;

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


public list[int] countDuplicates (list[str] file){

	/*count = 0;
	index1 = 0;
	index2 = 1;
	add = 1;
	int max = size(file);

	
	while(index1 < max){
		while(index2 < max){
			if(file[index1] == file[index2]){
				count += 1;
				while((count + index2) < max && (count + index1) < max && 
						(file[index1 + count]) == (file[index2 + count])){
					count +=1;
					
						
				}
				
			}
			
			if(count >= 6){
				duplicates += 1;
				lines += count;
				index2 += count;
				add = 6;
			}
			
			else
				index2 += 1;
				
			//if(add < count)
				//add = count;
				
			count = 0;
		}
		
		index1 += add;
		index2 = index1 + 1;
		add = 1;
	}*/
	
	duplicates = 0;
	lines = 0;
	count = 0;
	index1 = 0;
	index2 = 1;
	add = 1;
	int max = size(file);
	
	while(index1 < max){
		while(index2 < max){
			if((file[index1] == file[index2])){
				 if((index1 + 5) < max && (index2 + 5) < max 
					&& (file[index1 + 5] == file[index2 + 5])){

					count += 1;
					println("Is equal! <file[index1]> <file[index2]>");
					println("Is equal! <file[index1 + 5]> <file[index2 + 5]>");
					
					while((index1 + count) < max && (index2 + count) < max 
							&& (file[index1 + count] == file[index2 + count])){
						println("Is equal! <file[index1 + count]> <file[index2 + count]>");
						count += 1;
					}
					
					if(count >= 6){
						duplicates += 1;
						lines += count;
						index2 += count;
						add = 6;
						
					}
					
					else
						index2 += 6;
					
				}
				
				else
					index2 += 6;
			
			}
			
			else
				index2 += 1;
				
			count = 0;
		}
		
		index1 += add;
		index2 = index1 + 1;
		add = 1;

	}
	
	return [duplicates, lines];
	
	//return anotherApproach(file);

}

public map[str, list[int]] makeMap(list[str] lines){

	map[str, list[int]] result = ();
	int index = 0;
	
	while(index < size(lines)){
	
		str aux = lines[index];
		
		if(aux notin result)
			result[aux] = [];
		
		result[aux] = result[aux] + [index];
		index += 1;
	
	
	}
	
	return result;

}

public list[int] anotherApproach(list[str] file){

	map[str, list[int]] mapped = makeMap(file);
	duplicates = 0;
	lines = 0;
	init1 = 0;
	init2 = 1;
	str1 = ;
	count = 1;
	
	
	

	return [duplicates, lines];
}
