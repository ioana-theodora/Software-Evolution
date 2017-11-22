module Read

import IO;
import List;
import Set;
import util::Resources;
import util::FileSystem;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

//not sure if this method is necessary
public list[str] readFileIntoArray(loc file){
	return readFileLines(file);

}

public list[loc] returnListFiles(loc project){
	model = createM3FromEclipseProject(project);
	return toList(files(model));
	
}

public list[str] projectLines (loc project){
	list[str] result = [];
	list[loc] files = returnListFiles(project);
	
	for(f <- files){
		result = result + readFileLines(f);
	
	}
	
	return result;

}

public list[loc] returnListUnits(loc project){
	
	model = createM3FromEclipseProject(project);
	return toList(methods(model));
}

