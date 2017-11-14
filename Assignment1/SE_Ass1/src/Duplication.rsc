module Duplication

import IO;
import List;


public list[str] removeBlankCommentLines (list[str] lines){

	list[str] result = [];

	for(l <- lines){
		
		if(!(/^[ \t\n]*$/ := l) && !(/((\s|\/*)(\/\*|\s\*)|[^\w,\;]\s\/*\/|\/*\/)/ := l))
			result = result + l;
	
	}

	return result;
}

public list[list[str]] possibleBlocks (list[str] lines){

	list[list[str]] result = [];
	int index = 0;
	
	while(index < (size(lines) - 6)){
		int count = 0;
		list[str] block = [];
		
		while(count <= 6){
			block = block + lines[index+count];
			count += 1;
		}
		
		result = result + [block];
		index += 1;
	}

	return result;
}

public int countDuplicates (list[list[str]] blocks){

	duplicates = 0;
	int index = 0;
	
	for(b <- blocks){
		for(bl <- (delete(blocks, index))){
			if(b == bl){
				duplicates += 1;
				blocks = delete(blocks, index);
				index -= 1;	
			}
		}
		
		index += 1;
	}
	
	return duplicates;

}