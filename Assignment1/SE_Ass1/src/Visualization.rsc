module Visualization

import vis::Figure;
import vis::Render;

public void visualizeResults(str vol, str complexity, str unitSize, str dupl){

	row1 = [box(text("Volume")), box(text("<vol>"))];
	row2 = [box(text("Unit Complexity")), box(text("<complexity>"))];
	row3 = [box(text("Unit Size")), box(text("<unitSize>"))];
	row4 = [box(text("Duplication")), box(text("<dupl>"))];
	
	render(grid([row1, row2, row3, row4]));

}