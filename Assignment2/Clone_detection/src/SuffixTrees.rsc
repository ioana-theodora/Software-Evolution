module SuffixTrees

import Boolean;
import List;
import String;
import IO;

data SuffixTree = leaf(str S, int N)
				| tree(str S, list[SuffixTree] L);
				
/////////////////////////////////////////////////////////////////////////////
SuffixTree root;
list[int] indexesToChange = [];

public int getInt(SuffixTree t){

	switch(t){
	
		case leaf(_, n): return n;
		case tree(_, _): return -1;
	}


}

private str mergeStrings(str string1, str string2){

	sizeS1 = size(string1)-1;
	sizeS2 = size(string2);
	val1 = string1[sizeS1];
	val2 = string2[0];
	
	if(string1[1..(sizeS1+1)] == string2[0..(sizeS2-1)])
		return string1[0]+string2;
	
	if(val1 != val2){
		while(!startsWith(string2,string1[sizeS1..]) && sizeS1 >= 0)
				sizeS1 -= 1;
		
		return string1[0..sizeS1]+string2;
	}
				
	else{
		while(startsWith(string2,string1[sizeS1..]) && sizeS1 >= 0)
			sizeS1 -= 1;
	
	
		return string1[0..(sizeS1+1)]+string2;
		
	}
}

public str valueOf(SuffixTree t){
	
	switch(t){
	
		case leaf(str S, _): return S;
		case tree(str S, _): return S;
	}
}

public int numChilds(SuffixTree t){

	switch(t){
		case leaf(_,_): return 0;
		case tree(_,kids): return size(kids);
	}
}



private void update(SuffixTree t){
	
	//here
	list[SuffixTree] childs = [];
	switch(root){
	
		case tree(_,kids): {
			SuffixTree aux = leaf("",0);
			//here
			SuffixTree change = t;
			int index = 0;
			childs = kids;
			
			while(size(indexesToChange) != 1){
				if((size(indexesToChange) - index == 1)){
					children = [];
					if(index != 0){
						
						children = getListChilds(aux);
						children[indexesToChange[index]] = change; 
						change = tree(valueOf(aux),children);
						
					}
					
					indexesToChange = head(indexesToChange, (size(indexesToChange) - 1));
					index = 1;
					aux = kids[indexesToChange[0]];
					childs = getListChilds(aux);
					
				}
				
				else{
					aux = childs[indexesToChange[index]];
					childs = getListChilds(aux);
					index += 1;
				}
				
			}
			kids[indexesToChange[0]] = change;
			childs = kids;	
		}
	
	}
	
	indexesToChange = [];
	root = tree("",childs);


}
				
public list[SuffixTree]getListChilds(SuffixTree t){

	switch(t){
		case leaf(_,_): return [];
		case tree(_, kids): return kids; 
	
	}

}

public list[str] allChildsValues(SuffixTree t){

	switch(t){
		case leaf(_,_): return [];
		case tree(_,kids): return mapper(kids,valueOf);
	
	}
}
				
public bool hasChild(SuffixTree original, str child){

	switch(original){

		case leaf(_,_): return false;
		case tree(_,[]): return false;
		case tree(_, kids): {
			children = allChildsValues(original);
			return (child in children);
			}
	}
}
		
public SuffixTree getChild(str child){

	kids = getListChilds(root);
	get = [];
	
	//println("Find child: <child>");
	
	while(child != ""){
		get = [k | k <- kids, startsWith(child, valueOf(k))];
		child = replaceFirst(child, valueOf(get[0]), "");
		indexesToChange = indexesToChange + indexOf(kids,get[0]);
		kids = getListChilds(get[0]);
	}
	

	return get[0];
	
}

public list[SuffixTree] deleteLeafs(SuffixTree t){
	
	kids = getListChilds(t);
	leafs = getLeafs(t);
	
	for(l <- leafs){
	
		int index = indexOf(kids,l);
		kids = delete(kids,index);
	
	}

	return kids;
}
			
public list[SuffixTree] getLeafs(SuffixTree t){

	kids = getListChilds(t);
	list[SuffixTree] result = [];
	for(k <- kids){
		switch(k){
			case leaf(_,_): result = result + k;
			case tree(_,_): ;
		}
	}
	
	return result;
}


public list[SuffixTree] getAllLeafs(SuffixTree t){

	kids = getListChilds(t);
	list[SuffixTree] result = getLeafs(t);
	
	for(k <- kids){
	
		switch(k){
			case tree(_,_): result = result + getLeafs(k);
		}
	
	}
	
	return result;

}

public list[int] getIndexes(SuffixTree t){

	list[int] result = [];
	leafs = getAllLeafs(t);
	
	for(l <- leafs){
		x = getInt(l);
		if(x notin result)
			result = result + x;
	
	} 

	return sort(result);

}


public SuffixTree addNodeST(SuffixTree original, SuffixTree add){
	
	switch(original){
	
		case leaf(str S, int N): return tree(S, [add]);
		case tree(str S, list[SuffixTree] L): return tree(S, (L + add));
	
	}
	
}


private void compactST(SuffixTree t, str previous, int onRoot, int hasSibling, 
						int hasUncle){

	kids  = getListChilds(t);
	SuffixTree after = leaf("",0);
	SuffixTree before = leaf("",0);
	save = "";
	saveParent = "";
	
	if(!isEmpty(kids)){
		for(k <- kids){
			if(onRoot == 1)
				previous = valueOf(k);
		
			/*println("Actual: <k>");
			println("On Root?: <onRoot>");
			println("Has Sibling?: <hasSibling>");
			println("Has Uncle?: <hasUncle>");
			println("Previous received: <previous>");
			println("Save Parent: <saveParent>");*/
		
			if(numChilds(k) <= 1){
				if(hasSibling == 1){
					
					if(saveParent != "")
						previous = saveParent;

					else if(hasUncle == 1)
						saveParent = previous;
						
					else
						saveParent = valueOf(t);
					
					//println("Save Parent: <saveParent>");
					save = previous;
					previous = previous + valueOf(k);
				}
				before = getChild(previous);
				//println("Before: <before>");
				after = merge(before);
				//println("After: <after>");
				update(after);
				//println("Root now: <root>");
				
				if(hasUncle == 1 || hasSibling == 1){
					previous = mergeStrings(previous,valueOf(after));
					if(numChilds(after) > 1){
						//println("Previous sent: <previous>");
						compactST(after,previous,0,1,1);
					}
						
					else{
						//println("Previous sent: <previous>");
						compactST(k,previous,0,0,1);
					}
				}
				else{
					previous = save+valueOf(after);
					//println("Previous sent: <previous>");
					if(numChilds(after) > 1)
						compactST(after,previous,0,1,0);
					else
						compactST(k,previous,0,0,0);
				}
					
			}
			
			else{
				if(onRoot == 1)
					compactST(k,previous,0,1,0);	
					
				else{
					if(hasSibling == 1 && hasUncle == 1)
						compactST(k,(previous+valueOf(k)),0,1,1);
					else if(hasSibling == 1 && hasUncle == 0)
							if(saveParent == "")
								compactST(k,(previous+valueOf(k)),0,1,1);
							else
								compactST(k,(saveParent+valueOf(k)),0,1,1);
					else
						compactST(k,(previous+valueOf(k)),0,1,1);
					
				}
			}
		}
	}
	
}

private SuffixTree merge(SuffixTree t){
	
	switch(t){
		case leaf(_,_): return t;
		case tree(val,kids):{
			int intChild = getInt(kids[0]);
			valChild = valueOf(kids[0]);
			grandChilds = getListChilds(kids[0]);
			if(grandChilds == [])
				return leaf((valueOf(t)+valChild), intChild);
			 else
			 	return tree((valueOf(t)+valChild), grandChilds);
			
		}
	}
}

public SuffixTree buildST(list[str] values){

	root = tree("", []);
	SuffixTree aux ;
	currentIndex = 0;
	previousIndex = 0;
	currentValue = "";
	previousValue = "";
	indexList = 0;
	
	for(v <- values){
		currentValue = v[0];
		int max = size(v);
		while(currentIndex < max){
			if(!hasChild(root, currentValue))
				root = addNodeST(root, leaf(currentValue,indexList));
				
			if(previousValue == ""){
				previousIndex = currentIndex; 
				currentIndex += 1;
				if(currentIndex < max){
					previousValue = v[previousIndex..currentIndex];
					currentValue = v[currentIndex];
				}
				
			}
			
			else{
				aux = getChild(previousValue);
				if(!hasChild(aux, currentValue)){
					aux = addNodeST(aux, leaf(currentValue,indexList));
					update(aux);
				}
				
				else
					indexesToChange = [];
					
				if(previousIndex - 1 < 0)
					previousValue = "";
					
				else{
					previousIndex -= 1;
					previousValue = v[previousIndex..currentIndex];
				}
			
			}
	
		}
		/*println(v);
		println(root);*/
		indexList += 1;
		currentIndex = 0;
		previousIndex = 0;
		currentValue = "";
		previousValue = "";
	
	}
	
	compactST(root,"",1,0,0);
	listNoLeafs = deleteLeafs(root);
	root = tree("",listNoLeafs);
	
	return root;

}

public list[list[int]] main(list[str] values){

	suffixT = buildST(values);
	kids = getListChilds(suffixT);
	list[list[int]] result = [];
	
	for(k <- kids){
		lst = getIndexes(k);
		if(lst notin result)
			result = result + [lst];
	}

	return result;

}




