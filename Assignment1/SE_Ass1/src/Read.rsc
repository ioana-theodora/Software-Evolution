module Read

import IO;
import List;
import util::Resources;

//not sure if this method is necessary
public list[str] readFileIntoArray(loc file){
	return readFileLines(file);

}

public list[loc] returnListFiles(loc project){

	list[loc] files = project.ls;
	
	while(!all(f <- files, isFile(f))){
		if(isDirectory(files[0]))
			files = tail(files) + files[0].ls;
		else
			files = tail(files);
	}
	
	return files;
	
}

