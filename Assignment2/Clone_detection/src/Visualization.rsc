module Visualization
//-------------------------------
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
//-------------------------------
import Set;
import IO;
import List;
import vis::Figure;
import vis::Render;

/*public int filesVisualization(){
	return 1;
}*/

public loc fileSrc(Declaration compilationUnit){
	return compilationUnit.src;
}

public str srcToStr(loc locationFile){
	return locationFile.path;
}

public str fileName(loc locationFile){
	sourceToString = srcToStr(locationFile);
	if(/<name:\w+.java>/ := sourceToString)
		return name;
}

public int getLinesOfCode(loc locationFile){
	return size(readFileLines(locationFile));
}

public void visualizationClonesFiles(set[Declaration] astsFromProjects){
	set[loc] srcs = {};
	set[str] filesNames = {};
	set[int] linesOfCode = {};
	list[Figure] files = [];
	for(astFromProject <- astsFromProjects){
		srcs += fileSrc(astFromProject);
		filesNames += fileName(fileSrc(astFromProject));
		linesOfCode += getLinesOfCode(fileSrc(astFromProject));
	}
	//return srcs;
	//return filesNames;
	//return linesOfCode;
	//boxes = [ box([size(10, 10), text(fileName)]) | fileName <- toList(filesNames) ];
	for(fileName <- filesNames){
		files += box(text(fileName, top(), fontColor("blue"), fontSize(10)), fillColor("white"), size(50, 50), lineWidth(2), shadow(true));
	}
	/*row1 = [box(fillColor("grey")), box(text("low"), fillColor("lightgrey")), 
	box(text("medium"), fillColor("lightgrey")), box(text("high"),fillColor("lightgrey")), 
	box(text("very high"), fillColor("lightgrey"))];*/
	
	//render(grid([files]));
	render(hcat(files, gap(50)));
	//render(hvcat(files, width(500), left()));
}