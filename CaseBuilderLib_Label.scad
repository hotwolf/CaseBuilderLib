//###############################################################################
//# CaseBuilderLib - Label                                                      #
//###############################################################################
//#    Copyright 2020 Dirk Heisswolf                                            #
//#    This file is part of the CaseBuilderLib project.                         #
//#                                                                             #
//#    This project is free software: you can redistribute it and/or modify     #
//#    it under the terms of the GNU General Public License as published by     #
//#    the Free Software Foundation, either version 3 of the License, or        #
//#    (at your option) any later version.                                      #
//#                                                                             #
//#    This project is distributed in the hope that it will be useful,          #
//#    but WITHOUT ANY WARRANTY; without even the implied warranty of           #
//#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
//#    GNU General Public License for more details.                             #
//#                                                                             #
//#    You should have received a copy of the GNU General Public License        #
//#    along with this project.  If not, see <http://www.gnu.org/licenses/>.    #
//#                                                                             #
//###############################################################################
//# Description:                                                                #
//#   A label for the case                                                      #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   July 1, 2020                                                              #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib_Common.scad>

//Flat label
module flatLabel(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    labT   = pSet[idxLabT];   //Label text
    labS   = pSet[idxLabS];   //Label size
    
    //Label
    translate([0,0,wallW+idimZ/2]) text(text=labT,size=labS,halign="center",valign="center");
}

//Engrave label into top shell
module engraveLabel(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    labT   = pSet[idxLabT];   //Label text
    labS   = pSet[idxLabS];   //Label size
    
    //Engrave
    difference() {
        children();
        translate([0,0,wallW-0.4+idimZ/2]) linear_extrude(0.8) text(text=labT,size=labS,halign="center",valign="center");
    }
}
