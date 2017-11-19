module Duplication

import IO;
import List;
import String;


public list[str] cleanLines(list[str] lines){

	list[str] result = [];
	str aux = "";

	for(l <- lines){
		
		if(!(/^[ \t\n]*$/ := l) && !(/((\s|\/*)(\/\*|\s\*)|[^\w,\;]\s\/*\/|\/*\/)/ := l)
				&& !(/<word:import ><rest:.*;$>/ := l) && !(/^[ \t\n]*\{$/ := l)
				&& !(/[ \t\n]*}$/ := l) && !(/<first:package ><other:.*;$>/ := l)
				&& !(/^[ \t\n]*@Override$/ := l) && !(/^[ \t\n]*;$/ := l)){
				
			aux = replaceAll(l, " ", "");	
			aux = replaceAll(aux, "\t", "");
			aux = replaceAll(aux, "\n", "");
			result = result + aux;
			
		}
	
	}

	return result;
}


public list[int] countDuplicates (list[str] file){

	duplicates = 0;
	count = 0;
	lines = 0;
	index1 = 0;
	index2 = 1;
	add = 1;
	int max = size(file);

	
	while(index1 < max){
		while(index2 < max){
			if(file[index1] == file[index2]){
				count += 1;
				println("Is equal! <file[index1]> <file[index2]>");
				while((count + index2) < max && (count + index1) < max && 
						(file[index1 + count]) == (file[index2 + count])){
					println("Is equal! <file[index1+count]> <file[index2+count]>");
					count +=1;
					
						
				}
				
			}
			
			if(count >= 6){
				println("Duplicate found!");
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
	}
	
	
	
	return [duplicates, lines];

}
