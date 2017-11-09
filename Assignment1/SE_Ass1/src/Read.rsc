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
	return toList(visibleFiles(project));
	
}

public list[loc] returnListUnits(loc project){
	
	model = createM3FromEclipseProject(project);
	return toList(methods(model));
}

