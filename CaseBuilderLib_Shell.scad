//###############################################################################
//# CaseBuilderLib - Basic shell                                                #
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
//#   The plan shell without hinge and latch.                                   #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   June 29, 2020                                                             #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib_Common.scad>
use     <CaseBuilderLib_Label.scad>
use     <CaseBuilderLib_Hinge.scad>
use     <CaseBuilderLib_Lock.scad>

//Shell shape
//===========
module shellShape(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    

    difference() {
        hull() {
            translate([idimX/2,idimY/2,-idimZ/2])   cylinder4n(h=idimZ/2,r=wallW);
            translate([idimX/2,idimY/2,-idimZ/2])   hemisphere4n(r=wallW,shs=true);

            translate([idimX/2,-idimY/2,-idimZ/2])  cylinder4n(h=idimZ/2,r=wallW);
            translate([idimX/2,-idimY/2,-idimZ/2])  hemisphere4n(r=wallW,shs=true);

            translate([-idimX/2,idimY/2,-idimZ/2])  cylinder4n(h=idimZ/2,r=wallW);
            translate([-idimX/2,idimY/2,-idimZ/2])  hemisphere4n(r=wallW,shs=true);

            translate([-idimX/2,-idimY/2,-idimZ/2]) cylinder4n(h=idimZ/2,r=wallW);
            translate([-idimX/2,-idimY/2,-idimZ/2]) hemisphere4n(r=wallW,shs=true);
        }
        cube([idimX,idimY,1+idimZ],center=true);
    }
}

//Lower shell
//===========
module lowerShell(pSet) {
    //Shell shape
    attachLowerHinge(pSet)
    attachLowerLock(pSet)
    shellShape(pSet);
}

//Upper shell
//===========
module upperShell(pSet) {
    //Shell shape
    engraveLabel(pSet)
    attachUpperHinge(pSet)
    attachUpperLock(pSet)
    rotate([180,0,0]) shellShape(pSet);
}

//Preview
if ($preview) {

    lowerShell(pSet());
    upperShell(pSet());
    
}