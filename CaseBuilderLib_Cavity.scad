//###############################################################################
//# CaseBuilderLib - Cavity                                                     #
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
//#   June 29, 2020                                                             #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib_Common.scad>
use     <CaseBuilderLib_Boundary.scad>

//Add slack to the first child
module slack(pSet) {
    //Short cuts
    slackX = pSet[idxSlackX]; //Object's slack in X direction
    slackY = pSet[idxSlackY]; //Object's slack in Y direction
    slackZ = pSet[idxSlackZ]; //Object's slack in Z direction

    //Determine the number of steps
    steps = r2sides4n(max(slackX, slackY));
    
    //Build slack shape
    hull() {
        for (angle=[0:360/steps:359]) {
//            echo("angle: ", angle);
            
            translate([slackX*sin(angle),slackY*cos(angle),slackZ])  children(0);
            translate([slackX*sin(angle),slackY*cos(angle),-slackZ]) children(0);
        }
    }
}        
 
//Add rotary clearance to the first child
module clearance(pSet) {
    //Short cuts
    idimY  = pSet[idxIdimY];                //Inner Y dimension
    wallW  = pSet[idxWallW];                //Wall thickness
    gapW   = pSet[idxGapW];                 //Gap between moving parts

    offset = gapW+wallW+idimY/2;            //Offset from pivot point
    steps  = r2sides4n(gapW+wallW+idimY)/4; //Determine rotary steps
  
    for (idx=[0:1:$children-1])  {
        hull() {
            for (rotX=[0:-90/steps:-90]) {
                difference() {             
                    translate([0,offset,0])
                    rotate([-rotX,0,0]) 
                    translate([0,-offset,0])
                    children(0);
                    
                    lowerInfBb();
                }
            }
        }
    }
}

//Add lower opening for the first child
module lowerOpening(pSet) {
    hull() {
        difference() {
            children(0);
            upperInfBb();
        }
        linear_extrude(1)
        projection(cut=false) 
        difference() {
            children(0);
            upperInfBb();
        }
    }
}    

//Add upper opening for the first child
module upperOpening(pSet) {
    hull() {
        difference() {
            children(0);
            lowerInfBb();
        }
        translate([0,0,-1])
        linear_extrude(1)
        projection(cut=false) 
        difference() {
            children(0);
            lowerInfBb();
        }
    }
}    

//Lower cavity shape of the first child
module lowerCavShape(pSet) {
    //Cascade operations
    lowerOpening(pSet) {
        slack(pSet) {
            children(0);
        }
    }
}

//Upper cavity shape of the first child
module upperCavShape(pSet) {
    //Cascade operations
    upperOpening(pSet) {
        clearance(pSet) {
            slack(pSet) {
                children(0);
            }
        }
    }
}




