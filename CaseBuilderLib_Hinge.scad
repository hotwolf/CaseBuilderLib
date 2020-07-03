//###############################################################################
//# CaseBuilderLib - Hinge                                                      #
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
//#   A fully printed hinge.                                                    #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   June 29, 2020                                                             #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib_Common.scad>

//Hinge segments
//==============
//Male segment - positive
module hingeMalePos(wallW = defWallW,    //Wall thickness
                    gapW  = defGapW,     //Gap between moving parts
                    segW  = defHSegW,    //Length of the segment
                    segD  = defHSegD) {  //Diameter of the segment

    //Local variables
    cylH = segW-gapW*sqrt(2);            //Height of the cylinder shape
    cylR = segD/2;                       //Diameter of the cylinder shape

    hull() {
        translate([-cylH/2,0,0]) rotate([0,90,0]) cylinder4n(h=cylH,r=cylR);
        translate([-cylH/2,gapW,-2*cylR])         cube([cylH,cylR-gapW,2*cylR]);
    }
    translate([cylH/2,0,0])  rotate([0,90,0]) cylinder4n(h=cylR,r1=cylR,r2=0);
    translate([-cylH/2,0,0]) rotate([0,-90,0]) cylinder4n(h=cylR,r1=cylR,r2=0);
}

//Male segment - negative
module hingeMaleNeg(wallW = defWallW,    //Wall thickness
                    gapW  = defGapW,     //Gap between moving parts
                    segW  = defHSegW,    //Length of the segment
                    segD  = defHSegD) {  //Diameter of the segment

    //Local variables
    cylH = segW+2*gapW*sqrt(2);;         //Height of the cylinder shape
    cylR = gapW+segD/2;                  //Diameter of the cylinder shape

    hull() {
        translate([-cylH/2,0,0]) rotate([0,90,0]) cylinder4n(h=cylH,r=cylR);
        translate([-cylH/2,gapW,-2*cylR])         cube([cylH,cylR-gapW,2*cylR]);
    }
//    translate([cylH/2,0,0])  rotate([0,90,0]) cylinder4n(h=cylR-gapW,r1=cylR-gapW,r2=0);
//    translate([-cylH/2,0,0]) rotate([0,-90,0]) cylinder4n(h=cylR-gapW,r1=cylR-gapW,r2=0);
}

//Female segment - positive
module hingeFemalePos(wallW = defWallW,    //Wall thickness
                      gapW  = defGapW,     //Gap between moving parts
                      segW  = defHSegW,    //Length of the segment
                      segD  = defHSegD) {  //Diameter of the segment

    //Local variables
    cylH = segW-gapW*sqrt(2);              //Height of the cylinder shape
    cylR = segD/2;                         //Diameter of the cylinder shape

    difference() {
        hull() {
            translate([-cylH/2,0,0]) rotate([0,90,0]) cylinder4n(h=cylH,r=cylR);
            translate([-cylH/2,-cylR,-2*cylR])         cube([cylH,cylR-gapW,2*cylR]);
        }
        union() {
            translate([-cylH/2,0,0]) rotate([0,90,0])  cylinder4n(h=cylR,r1=cylR,r2=0);
            translate([cylH/2,0,0])  rotate([0,-90,0]) cylinder4n(h=cylR,r1=cylR,r2=0);
        }
    }
}
 
//Female segment - negative
module hingeFemaleNeg(wallW = defWallW,    //Wall thickness
                      gapW  = defGapW,     //Gap between moving parts
                      segW  = defHSegW,    //Length of the segment
                      segD  = defHSegD) {  //Diameter of the segment

    //Local variables
    cylH = segW+2*gapW*sqrt(2);            //Height of the cylinder shape
    cylR = gapW+segD/2;                    //Diameter of the cylinder shape

    hull() {
        translate([-cylH/2,0,0]) rotate([0,90,0]) cylinder4n(h=cylH,r=cylR);
        translate([-cylH/2,-cylR,-2*cylR])         cube([cylH,cylR-gapW,2*cylR]);
     }
 }
 

//
if ($preview) {

//    hingeMalePos();
//    hingeMaleNeg();
    hingeFemalePos();
    hingeFemaleNeg();


    //Lower shell
//    translate([-defIdimX/2,defGapW,-defIdimZ]) cube([defIdimX,defIdimZ,defIdimZ]);
    
    //Upper shell
//    translate([-defIdimX/2,-defGapW-defIdimZ,-defIdimZ]) cube([defIdimX,defIdimZ,defIdimZ]);
    
    
  
}



