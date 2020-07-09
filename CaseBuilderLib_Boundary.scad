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
  
//Lower outer boundary error indicators
module lowerOuterBErr(pSet) {
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
        translate([-inf-idimX/2,-idimY/2,-idimZ/2]) cube([inf,idimY,idimZ/2]);
        children();
    }
    
    //Positive X-Range check
    rotate([0,90,0])
    translate([0,0,idimX/2+errOff])
    linear_extrude(1)
    projection()
    rotate([0,-90,0])
    intersection() {    
        translate([idimX/2,-idimY/2,-idimZ/2]) cube([inf,idimY,idimZ/2]);
        children();
    }
 
    //Negative Y-Range check
    rotate([90,0,0])
    translate([0,0,idimY/2+errOff])
    linear_extrude(1)
    projection()
    rotate([-90,0,0])
    intersection() {    
        translate([-idimX/2,-inf-idimY/2,-idimZ/2]) cube([idimX,inf,idimZ/2]);
        children();
    }
   
     //Positive Y-Range check
    rotate([-90,0,0])
    translate([0,0,idimY/2+errOff])
    linear_extrude(1)
    projection()
    rotate([90,0,0])
    intersection() {    
        translate([-idimX/2,idimY/2,-idimZ/2]) cube([idimX,inf,idimZ/2]);
        children();
    }
   
    //Negative Z-Range check
    rotate([180,0,0])
    translate([0,0,idimZ/2+errOff])
    linear_extrude(1)
    projection()
    rotate([180,0,0])
    intersection() {    
        translate([-idimX/2,-idimY/2,-inf-idimZ/2]) cube([idimX,idimY,inf]);
        children();
    }
}

//Upper outer boundary error indicators
module upperOuterBErr(pSet) {
    rotate([180,0,0])
    lowerOuterBErr(pSet)
    rotate([180,0,0]) children();
}

//All outer boundary error indicators
module outerBErr(pSet) {
  lowerOuterBErr(pSet) children();
  upperOuterBErr(pSet) children();
}

//Lower inner boundary error indicators
//children(0): object
//children(1): inner boundary
module lowerInnerBErr(pSet) {
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
        intersection() {    
            translate([-idimX/2,-idimY/2,-idimZ/2]) cube([idimX/2,idimY,idimZ/2]);
            children(1);
        }
        children(0);
    }
    
    //Positive X-Range check
    rotate([0,90,0])
    translate([0,0,idimX/2+errOff])
    linear_extrude(1)
    projection()
    rotate([0,-90,0])
     intersection() {
        intersection() {    
            translate([0,-idimY/2,-idimZ/2]) cube([idimX/2,idimY,idimZ/2]);
            children(1);
        }
        children(0);
    }
    
    //Negative Y-Range check
    rotate([90,0,0])
    translate([0,0,idimY/2+errOff])
    linear_extrude(1)
    projection()
    rotate([-90,0,0])
    intersection() {
        intersection() {    
            translate([-idimX/2,-idimY/2,-idimZ/2]) cube([idimX,idimY/2,idimZ/2]);
            children(1);
        }
        children(0);
    }
  
     //Positive Y-Range check
    rotate([-90,0,0])
    translate([0,0,idimY/2+errOff])
    linear_extrude(1)
    projection()
    rotate([90,0,0])
    intersection() {
        intersection() {    
            translate([-idimX/2,0,-idimZ/2]) cube([idimX,idimY/2,idimZ/2]);
            children(1);
        }
        children(0);
    }
   
    //Negative Z-Range check
    rotate([180,0,0])
    translate([0,0,idimZ/2+errOff])
    linear_extrude(1)
    projection()
    rotate([180,0,0])

    intersection() {
        intersection() {    
            translate([-idimX/2,-idimY/2,-idimZ/2]) cube([idimX,idimY,idimZ/2]);
            children(1);
        }
        children(0);
    }
}

//Upper inner boundary error indicators
//children(0): object
//children(1): inner boundary
module upperInnerBErr(pSet) {
    rotate([180,0,0])
    lowerInnerBErr(pSet) {
       rotate([180,0,0]) children(0);
       rotate([180,0,0]) children(1);
    }
}

//Trim object to lower boundary
module lowerTrim(pSet) {
   //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    intersection() {
        translate([-idimX/2,-idimY/2,-idimZ/2]) cube([idimX,idimY,idimZ/2]);
        children();
    }
}

//Trim object to upper boundary
module upperTrim(pSet) {
   //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    intersection() {
        translate([-idimX/2,-idimY/2,0]) cube([idimX,idimY,idimZ/2]);
        children();
    }
}

//Trim object to over all boundary
module trim(pSet) {
   //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension

    intersection() {
        translate([-idimX/2,-idimY/2,-idimZ/2]) cube([idimX,idimY,idimZ]);
        children();
    }
}
