//###############################################################################
//# CaseBuilderLib - Lock                                                       #
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
//#   A selection of lock options:                                              #
//#     1. Elastic string                                                       #
//#     2. Pull Latch                                                           #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   June 29, 2020                                                             #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib_Common.scad>

//Local parameters
//================
//Lock option 1: Elastic string
stringD = 3; //Diameter of the elasic string
knotD   = 5; //Diameter of the knot
knotOff = 2; //Knot offset

//Positive lower lock parts
module lowerLockPos(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    lockO  = pSet[idxLockO];  //Lock option



}

//Negative lower lock parts 
module lowerLockNeg(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    lockO  = pSet[idxLockO];  //Lock option

    //Elastic string option
    if (lockO==1) {
        translate([-idimX/2,-idimY/2+knotD/2+knotOff,-idimZ/2])         rotate([90,0,0])   torus4n(d1=knotD,d2=knotD,angle=90,$fn=12);
        translate([-idimX/2+knotD/2,-idimY/2+knotD/2+knotOff,-idimZ/2]) rotate([180,0,0])  cylinder4n(h=wallW+1,d=knotD,$fn=12);
        translate([-idimX/2,-idimY/2+knotD/2+knotOff,-idimZ/2+knotD/2]) rotate([0,270,0])  cylinder4n(h=wallW+1,d=stringD,$fn=12);

        translate([idimX/2,-idimY/2+knotD/2+knotOff,-idimZ/2])          rotate([90,0,180]) torus4n(d1=knotD,d2=knotD,angle=90,$fn=12);
        translate([idimX/2-knotD/2,-idimY/2+knotD/2+knotOff,-idimZ/2])  rotate([180,0,0])  cylinder4n(h=wallW+1,d=knotD,$fn=12);
        translate([idimX/2,-idimY/2+knotD/2+knotOff,-idimZ/2+knotD/2])  rotate([0,90,0])  cylinder4n(h=wallW+1,d=stringD,$fn=12);        
    }
    
    //Pull latch option
    if (lockO==2) {
        intersection() {
            hull() {
                translate([-15-gapW,-10-idimY/2,-8])         cube([30+2*gapW,10,4]);
                translate([-25-gapW,-10-idimY/2,-4+idimZ/2]) cube([50+2*gapW,10,4]);
            }    
            union() {       
                hull() {
                    translate([-idimX/2,-2-idimY/2,-4]) rotate([0,90,0]) cylinder4n(h=idimX,d=3);
                    translate([-idimX/2,-2-idimY/2,-6]) rotate([0,90,0]) cylinder4n(h=idimX,d=3);
                }
                translate([-idimX/2,-2-wallW-idimY/2,-7.5]) cube([idimX,wallW,5]);
                hull() {
                    translate([-idimX/2,-2-wallW-idimY/2,-2.5]) cube([idimX,wallW,4]);
                    translate([-idimX/2,-1-wallW-idimY/2,])    cube([idimX,wallW,2]);            
                }
            }        
        }
    }
 
    //Push latch option
     if (lockO==3) {



    }
   
}

//Positive upper lock parts
module upperLockPos(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    lockO  = pSet[idxLockO];  //Lock option

    //Pull latch option
    if (lockO==2) {
        intersection() {
            hull() {
               translate([-15,-10-idimY/2,-8]) cube([30,10,4]);
               translate([-25,-10-idimY/2,-4+idimZ/2]) cube([50,10,4]);
            }
            union() {
                translate([-idimX/2,-2-idimY/2,-4]) rotate([0,90,0]) cylinder4n(h=idimX,d=3);
                translate([-idimX/2,-2.75-idimY/2,-5.5]) rotate([0,90,0]) cylinder4n(h=idimX,d=1.5);
                translate([-idimX/2,-3.5-idimY/2,-5.5]) cube([idimX,1.5,idimZ/2]);
                hull() {
                    translate([-idimX/2,-3.5-idimY/2,-6+idimZ/2])   cube([idimX,1.5,2]);
                    translate([-idimX/2,-wallW-idimY/2,-2+idimZ/2]) cube([idimX,wallW,2]);
                }
            }
        }
    }
}

//Negative upper lock parts 
module upperLockNeg(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    lockO  = pSet[idxLockO];  //Lock option

    //Pull latch option
    if (lockO==2) {
        intersection() {
            hull() {
                translate([-15-gapW,-10-idimY/2,-8])         cube([30+2*gapW,10,4]);
                translate([-25-gapW,-10-idimY/2,-4+idimZ/2]) cube([50+2*gapW,10,4]);
            }    
            translate([-idimX/2,2*gapW-2-wallW-idimY/2,-1]) cube([idimX,wallW,-4+idimZ/2]);
        }
    }
}

//Attach lower lock
module attachLowerLock(pSet) {
    lowerLockPos(pSet);
    difference() {
        children();
        lowerLockNeg(pSet);
    }
}

//Attach upper lock
module attachUpperLock(pSet) {
    upperLockPos(pSet);
    difference() {
        children();
        upperLockNeg(pSet);
    }
}

//Space, taken up by the lock
module lockSpace(pSet) {
   lowerLockPos(pSet); 
   lowerLockNeg(pSet); 
   upperLockPos(pSet); 
   upperLockNeg(pSet); 
}

//Preview
if ($preview) {

    //Preview parameter set
    prevPSet = pSet(lockO=2);
    idimX    = prevPSet[idxIdimX];  //Inner X dimension        
    idimY    = prevPSet[idxIdimY];  //Inner Y dimension        
    idimZ    = prevPSet[idxIdimZ];  //Inner Z dimension        
    wallW    = prevPSet[idxWallW];  //Wall thickness
    gapW     = prevPSet[idxGapW];   //Gap between moving parts

    color("red")   lowerLockNeg(prevPSet); 
    color("green") upperLockPos(prevPSet);
    color("red")   upperLockNeg(prevPSet);

    color("gray",0.25) translate([0,0,idimZ/4]) cube([idimX,idimY,idimZ/2],center=true);
    color("gray",0.45) translate([0,0,-idimZ/4]) cube([idimX,idimY,idimZ/2],center=true);


}