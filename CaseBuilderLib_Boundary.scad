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

//Local parameters
//================
errOff = 1; //Error indicator offset

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

    translate([0,0,-idimZ/4-inlZ/2]) cube([idimX,idimY,(idimZ/2)-inlZ],center=true);
}

//Boundary box around the inner dimensions if the opper inlay
module upperInlBb(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    inlZ   = pSet[idxInlZ];   //Inlay offset in Z direction

    translate([0,0,idimZ/4+inlZ/2]) cube([idimX,idimY,(idimZ/2)-inlZ],center=true);
}

//Lower infinite boundary
module lowerInfBb() {
    translate([0,0,-inf/2]) cube([2*inf,2*inf,inf],center=true);
}

//Upper infinite boundary
module upperInfBb() {
    translate([0,0,inf/2]) cube([2*inf,2*inf,inf],center=true);
}


//Trim object to lower inner dimensions
module lowerIdimTrim(pSet) {
   //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    intersection() {
        translate([-idimX/2,idimY/2,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX)
        projection()
        rotate([90,0,0])
        linear_extrude(idimY)
        projection()
        children();
        children();
    }
}

//Trim object to upper inner dimensions
module upperIdimTrim(pSet) {
   //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    intersection() {
        translate([-idimX/2,idimY/2,0])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX)
        projection()
        rotate([90,0,0])
        linear_extrude(idimY)
        projection()
        children();
        children();
    }
 }

//Lower outer boundary error indicators
module lowerOuterErr(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    //Negative X-Range check
    rotate([0,-90,0])
    translate([0,0,idimX/2+errOff])
    linear_extrude(1)
    projection()
    rotate([0,90,0])
    intersection() {
        translate([-inf-idimX/2,idimY/2,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(inf)
        projection()
        rotate([90,0,0])
        linear_extrude(idimY)
        projection()
        children();
        children();
    }
   
    //Positive X-Range check
    rotate([0,90,0])
    translate([0,0,idimX/2+errOff])
    linear_extrude(1)
    projection()
    rotate([0,-90,0])    
    intersection() {
        translate([idimX/2,idimY/2,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(inf)
        projection()
        rotate([90,0,0])
        linear_extrude(idimY)
        projection()
        children();
        children();
    }

    //Negative Y-Range check
    rotate([90,0,0])
    translate([0,0,idimY/2+errOff])
    linear_extrude(1)
    projection()
    rotate([-90,0,0])
    intersection() {
        translate([-idimX/2,-idimY/2,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX)
        projection()
        rotate([90,0,0])
        linear_extrude(inf)
        projection()
        children();
        children();
    }

    //Positive Y-Range check
    rotate([-90,0,0])
    translate([0,0,idimY/2+errOff])
    linear_extrude(1)
    projection()
    rotate([90,0,0])
    intersection() {
        translate([-idimX/2,inf+idimY/2,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX)
        projection()
        rotate([90,0,0])
        linear_extrude(inf)
        projection()
        children();
        children();
    }
 
    //Negative Z-Range check
    rotate([180,0,0])
    translate([0,0,idimZ/2+errOff])
    linear_extrude(1)
    projection()
    rotate([180,0,0])
    intersection() {
        translate([-idimX/2,idimY/2,-inf-idimZ/2])
        linear_extrude(inf)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX)
        projection()
        rotate([90,0,0])
        linear_extrude(idimZ)
        projection()
        children();
        children();
    }
}

//Upper outer boundary error indicators
module upperOuterErr(pSet) {
    rotate([180,0,0])
    lowerOuterErr(pSet)
    rotate([180,0,0]) children();
}

//Lower inner boundary error indicators
//children(): conflicts
module lowerInnerErr(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    //Negative X-Range check
    rotate([0,-90,0])
    translate([0,0,idimX/2+errOff])
    linear_extrude(1)
    projection()
    rotate([0,90,0])   
    intersection() {
        translate([-idimX/2,idimY/2,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX/2)
        projection()
        rotate([90,0,0])
        linear_extrude(idimY)
        projection()
        children();
        children();
    }

    //Positive X-Range check
    rotate([0,90,0])
    translate([0,0,idimX/2+errOff])
    linear_extrude(1)
    projection()
    rotate([0,-90,0])
    intersection() {
        translate([0,idimY/2,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX/2)
        projection()
        rotate([90,0,0])
        linear_extrude(idimY)
        projection()
        children();
        children();
    }
  
    //Negative Y-Range check
    rotate([90,0,0])
    translate([0,0,idimY/2+errOff])
    linear_extrude(1)
    projection()
    rotate([-90,0,0])
    intersection() {
        translate([-idimX/2,0,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX)
        projection()
        rotate([90,0,0])
        linear_extrude(idimY/2)
        projection()
        children();
        children();
    }

    //Positive Y-Range check
    rotate([-90,0,0])
    translate([0,0,idimY/2+errOff])
    linear_extrude(1)
    projection()
    rotate([90,0,0])
    intersection() {
    translate([-idimX/2,idimY/2,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX)
        projection()
        rotate([90,0,0])
        linear_extrude(idimY/2)
        projection()
        children();
        children();
    }

    //Negative Z-Range check
    rotate([180,0,0])
    translate([0,0,idimZ/2+errOff])
    linear_extrude(1)
    projection()
    rotate([180,0,0])
    intersection() {
        translate([-idimX/2,idimY/2,-idimZ/2])
        linear_extrude(idimZ/2)
        projection()
        rotate([0,90,0])
        linear_extrude(idimX)
        projection()
        rotate([90,0,0])
        linear_extrude(idimY)
        projection()
        children();
        children();
    }
}

//Upper inner boundary error indicators
//children(): conflicts
module upperInnerErr(pSet) {
    rotate([180,0,0])
    lowerInnerErr(pSet) {
       rotate([180,0,0]) children();
    }
}
