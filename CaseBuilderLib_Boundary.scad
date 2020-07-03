//###############################################################################
//# CaseBuilderLib - Boundary Boxes and Checks                                  #
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
//#   Boudary boxes and checks for multiple purposes.                           #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   July 1, 2020                                                              #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib_Common.scad>

//Boundary box around the inner dimensions 
module idimBb(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    cube([idimX,idimY,idimZ],center=true);
}

//Boundary box around the inner dimensions if the lower shell
module lowerIdimBb(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    translate([0,0,-idimZ/4]) cube([idimX,idimY,idimZ/2],center=true);
}

//Boundary box around the inner dimensions of the upper shell
module upperIdimBb(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    translate([0,0,idimZ/4]) cube([idimX,idimY,idimZ/2],center=true);
}

//Boundary box around the inner dimensions if the lower inlay
module lowerInlBb(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    inlZ   = pSet[idxInlZ];   //Inlay offset in Z direction

    translate([0,0,(-idimZ/4)-(inlZ/2)]) cube([idimX,idimY,(idimZ/2)-inlZ],center=true);
}

//Boundary box around the inner dimensions of the upper inlay
module upperInlBb(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    inlZ   = pSet[idxInlZ];   //Inlay offset in Z direction

    translate([0,0,(idimZ/4)+(inlZ/2)]) cube([idimX,idimY,(idimZ/2)-inlZ],center=true);
}

//Boundary check against the inner dimensions (one child only)
module idimBCheck(pSet) {
    //Draw parts out of range range red
    color("red")
    difference() {
        children(0);
        idimBb(pSet);
    }

    //Draw parts within range green
    color("green")
    hull() 
    intersection() {
        children(0);
        idimBb(pSet);
    }           
}

//Boundary check against the inner dimensions of the lower shell (one child only)
module lowerIdimBCheck(pSet) {
    //Draw parts out of range range red
    color("red")
    difference() {
        children(0);
        lowerIdimBb(pSet);
    }

    //Draw parts within range green
    color("green")
    hull()
    intersection() {
        children(0);
        lowerIdimBb(pSet);
    }        
}

//Boundary check against the inner dimensions of the upper shell (one child only)
module upperIdimBCheck(pSet) {
    //Draw parts out of range range red
    color("red")
    difference() {
        children(0);
        upperIdimBb(pSet);
    }

    //Draw parts within range green
    color("green")
    hull()
    intersection() {
        children(0);
        upperIdimBb(pSet);
    }        
}

//Lower infinite boundary
module lowerInfBb() {
    translate([0,0,-inf/2]) cube([2*inf,2*inf,inf],center=true);
}

//Upper infinite boundary
module upperInfBb() {
    translate([0,0,inf/2]) cube([2*inf,2*inf,inf],center=true);
}
    