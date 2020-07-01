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

//Lower shell
//===========
module lowerShell(idimX = defIdimX,  //Inner X dimension
                  idimY = defIdimY,  //Inner Y dimension
                  idimZ = defIdimZ,  //Inner Z dimension
                  wallW = defWallW,  //Wall thickness
                  gapW  = defGapW) { //Gap between moving parts

    //Local variables          
    halfX = idimX/2;
    halfZ = idimZ/2;

    difference() {
        hull() {
            translate([halfX,wallW+gapW,-halfZ])        cylinder4n(h=halfZ,r=wallW);
            translate([halfX,wallW+gapW,-halfZ])        hemisphere4n(r=wallW,shs=true);
            translate([halfX,wallW+gapW+idimY,-halfZ])  cylinder4n(h=halfZ,r=wallW);
            translate([halfX,wallW+gapW+idimY,-halfZ])  hemisphere4n(r=wallW,shs=true);
            translate([-halfX,wallW+gapW+idimY,-halfZ]) cylinder4n(h=halfZ,r=wallW);
            translate([-halfX,wallW+gapW+idimY,-halfZ]) hemisphere4n(r=wallW,shs=true);
            translate([-halfX,wallW+gapW,-halfZ])       cylinder4n(h=halfZ,r=wallW);
            translate([-halfX,wallW+gapW,-halfZ])       hemisphere4n(r=wallW,shs=true);
        }
        translate([-halfX,wallW+gapW,-halfZ])           cube([idimX,idimY,halfZ+1]);
    }
}

//Upper shell
//===========
module upperShell(idimX = defIdimX,  //Inner X dimension
                  idimY = defIdimY,  //Inner Y dimension
                  idimZ = defIdimZ,  //Inner Z dimension
                  wallW = defWallW,  //Wall thickness
                  gapW  = defGapW) { //Gap between moving parts

    //Upper shell
    rotate([0,0,180])
    lowerShell(idimX = idimX,        //Inner X dimension
               idimY = idimY,        //Inner Y dimension
               idimZ = idimZ,        //Inner Z dimension
               wallW = wallW,        //Wall thickness
               gapW  = gapW);        //Gap between moving parts
}
//Upper and lower shell
//=====================
module shell(idimX = defIdimX,       //Inner X dimension
             idimY = defIdimY,       //Inner Y dimension
             idimZ = defIdimZ,       //Inner Z dimension
             wallW = defWallW,       //Wall thickness
             gapW  = defGapW) {      //Gap between moving parts

    //Lower shell
    lowerShell(idimX = idimX,        //Inner X dimension
               idimY = idimY,        //Inner Y dimension
               idimZ = idimZ,        //Inner Z dimension
               wallW = wallW,        //Wall thickness
               gapW  = gapW);        //Gap between moving parts

    //Upper shell
    upperShell(idimX = idimX,        //Inner X dimension
               idimY = idimY,        //Inner Y dimension
               idimZ = idimZ,        //Inner Z dimension
               wallW = wallW,        //Wall thickness
               gapW  = gapW);        //Gap between moving parts
}

if ($preview) {

    //Shell
    shell();
   
}
