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

    minkowski() {
        translate([0,0,-slackZ]) scale([slackX,slackY,1]) cylinder4n(h=2*slackZ,r=1,$fn=r2sides4n(max(slackX,slackY)));
        children();
    }
}        
 
//Calculate rotary clearance
module clearance(pSet) {
    //Short cuts
    idimY  = pSet[idxIdimY];                //Inner Y dimension
    wallW  = pSet[idxWallW];                //Wall thickness
    gapW   = pSet[idxGapW];                 //Gap between moving parts

    offset = gapW+wallW+idimY/2;            //Offset from pivot point
    steps  = r2sides4n(gapW+wallW+idimY)/4; //Determine rotary steps
  
    hull() {
        for (rotX=[0:-90/steps:-90]) {
            upperIdimTrim(pSet)
            translate([0,offset,0])
            rotate([-rotX,0,0]) 
            translate([0,-offset,0])
            children();
        }
    }
}

//Calculate lower opening
module lowerOpening(pSet) {
    hull() {
        linear_extrude(1)
        projection() 
        lowerIdimTrim(pSet)
        children();
 
        lowerIdimTrim(pSet)
        children();
    }
}    

//Calculate upper opening
module upperOpening(pSet) {
    hull() {
        linear_extrude(1)
        projection() 
        upperIdimTrim(pSet)
        children();
 
        upperIdimTrim(pSet)
        children();
    }
}    

//Lower cavity shape
module lowerCav(pSet) {
    //Cascade operations
    lowerOpening(pSet)
    slack(pSet)
    children();
}

//Upper cavity shape
module upperCav(pSet) {
    //Cascade operations
    upperOpening(pSet)
    slack(pSet)
    clearance(pSet)
    children();
}
