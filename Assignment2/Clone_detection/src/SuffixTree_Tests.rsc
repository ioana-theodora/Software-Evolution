module SuffixTree_Tests

import IO;
import List;
import String;


import SuffixTrees;

test bool buildSuffixTree(){

	SuffixTree t1 = buildST(["abaaba","klabaaop"]);
	SuffixTree t2 = buildST(["abaaba","klabaaop"]);
	
	return t1 == t2;

}

test bool detectClonesType1(){

	SuffixTree t = buildST(["if + id id = id id call id","if id = id id call id ","abaaba"]);
	list[list[int]] result = duplicates(t);

	return size(result) == 1;

}

test bool detectClonesType1_noClone(){

	SuffixTree t = buildST(["if + id id = id id call id","uiklop ","abaaba"]);
	list[list[int]] result = duplicates(t);

	return size(result) == 0;

}

