module Visualization

import vis::Figure;
import vis::Render;

public void visualizeResults(str vol, str complex, str unitsize, str dup, str analys,
								str change, str testabl, str maintain, int lOC, int dupLoc){

	row1 = [box(fillColor("grey")), box(text("low"), fillColor("lightgrey")), 
	box(text("medium"), fillColor("lightgrey")), box(text("high"),fillColor("lightgrey")), 
	box(text("very high"), fillColor("lightgrey"))];
	row2 = [box(text("Complexity per unit risk")), box(text("0")), box(text("0")), box(text("0")), 
	box(text("0"))];
	row3 = [box(text("Unit size risk")), box(text("0")), box(text("0")), box(text("0")), 
	box(text("0"))];
	row4 = [];
	row5 = [box(fillColor("grey")), box(text("LOC"),fillColor("lightgrey")), 
	box(text("Duplicated LOC"), fillColor("lightgrey")), box(text("Score"), fillColor("lightgrey"))];
	row6 = [box(text("Volume")), box(text("<lOC>")), box(text("-")), box(text("<vol>"))];
	row7 = [box(text("Complexity per unit")), box(text("-")), box(text("-")), box(text("<complex>"))];
	row8 = [box(text("Unit Size")), box(text("-")), box(text("-")), box(text("<unitsize>"))];
	row9 = [box(text("Duplication")), box(text("-")), box(text("<dupLoc>")), box(text("<dup>"))];
	row10 = [];
	row11 = [box(fillColor("grey")), box(text("Volume"), fillColor("lightgrey")), 
	box(text("Complexity"), fillColor("lightgrey")), box(text("Unit size"), fillColor("lightgrey")), 
	box(text("Duplication"), fillColor("lightgrey")), box(text("Score"),fillColor("lightgrey"))];
	row12 = [box(text("Analysability")), box(text("<vol>")), box(text("")), box(text("<unitsize>")), 
	box(text("<dup>")), box(text("<analys>"))];
	row13 = [box(text("Changeability")), box(text("")), box(text("<complex>")), box(text("")), 
	box(text("<dup>")), box(text("<change>"))];
	row14 = [box(text("Testability")), box(text("")), box(text("<complex>")), box(text("<unitsize>")), 
	box(text("")), box(text("<testabl>"))];
	row15 = [];
	row16 = [box(fillColor("grey")), box(text("Analysability"), fillColor("lightgrey")), 
	box(text("Changeability"), fillColor("lightgrey")), box(text("Testability"), fillColor("lightgrey")), 
	box(text("Score"), fillColor("lightgrey"))];
	row17 = [box(text("Maintainability")), box(text("<analys>")), box(text("<change>")), 
	box(text("<testabl>")), box(text("<maintain>"))];
	
	render(grid([row1, row2, row3, row4, row5, row6, row7, row8, row9, row10, row11, row12, row13,
					row14, row15, row16, row17]));

}