//###############################################################################
//# CaseBuilderLib - Grip Holes                                                 #
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
//#   A cavities for user defined objects.                                      #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   July 1, 2020                                                              #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib_Common.scad>

//Grip hole positions
module ghPos(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    ghX    = pSet[idxGhX];    //Grip hole positions
    ghW    = pSet[idxGhW];    //Grip hole width

    //Iterate over grip hole array
    for (x=ghX) {
        //Only draw grip holes that are within the boundary
        if (((x+ghW/2)<=(idimX/2)) && ((x-ghW/2)>=(-idimX/2))) {
           translate([x,0,-idimZ/4]) cube([ghW,idimY,idimZ/2],center=true); 
        }
    }
}

//Determine the depth of a grip hole
module ghDepth() {
    //Generate a pole with the depth of the grip hole
    module depthPole() {
        rotate([270,0,0])       
        linear_extrude(1)
        projection(cut=false)
        rotate([0,90,0])    
        linear_extrude(1)
        projection(cut=false)
        rotate([90,0,0])
        children();
    }

    //Extract the depth pole in X and Y direction
    minkowski() {
        translate([-inf/2,-inf/2,0]) cube([inf,inf,1]);
        depthPole() children();
    }
}

//Grip hole profile
module ghProfile(pSet) {
    //Short cuts
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    ghW    = pSet[idxGhW];    //Grip hole width

    hull() {
        translate([0,-idimY/2+ghW/2,-idimZ/2]) cylinder4n(h=1+idimZ/2,d=ghW);
        translate([0,idimY/2-ghW/2,-idimZ/2])  cylinder4n(h=1+idimZ/2,d=ghW);
    }
}

//Grip hole shapes
module ghShapes(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    ghX    = pSet[idxGhX];    //Grip hole positions
    ghW    = pSet[idxGhW];    //Grip hole width

    //Iterate over grip hole array
    for (x=ghX) {
        //Ignore grip holes that are out of boundary
        if (((x+ghW/2)<=(idimX/2)) && ((x-ghW/2)>=(-idimX/2))) {
            //Construct grip hole
            intersection() {    
                translate([x,0,0]) ghProfile(pSet);
  
               ghDepth()
               intersection() {
                    translate([x,0,-idimZ/4]) cube([ghW,idimY,idimZ/2],center=true);
                    children();
                }
            }
        }
    }
}