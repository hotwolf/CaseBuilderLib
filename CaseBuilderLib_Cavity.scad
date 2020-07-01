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

//Shift an object away from the hinge
module shift(wallW = defWallW,    //Wall thickness
             gapW  = defGapW) {   //Gap between moving parts
    translate([0,gapW+wallW,0]) children();
}

//Add slack to an object
module slack(slackX = defSlackX,   //Object's slack in X direction
             slackY = defSlackY,   //Object's slack in Y direction
             slackZ = defSlackZ) { //Object's slack in Z direction
    for (idx=[0:1:$children-1])  {
        hull() {
            translate([slackX/2,slackX/2,slackZ/2])    children(idx); 
            translate([slackX/2,-slackX/2,slackZ/2])   children(idx); 
            translate([-slackX/2,slackX/2,slackZ/2])   children(idx); 
            translate([-slackX/2,-slackX/2,slackZ/2])  children(idx); 
    
            translate([slackX/2,slackX/2,-slackZ/2])   children(idx); 
            translate([slackX/2,-slackX/2,-slackZ/2])  children(idx); 
            translate([-slackX/2,slackX/2,-slackZ/2])  children(idx); 
            translate([-slackX/2,-slackX/2,-slackZ/2]) children(idx); 
        }        
    }
}

//Cut off the upper section of an object
module upperSection(idimX = defIdimX,   //Inner X dimension
                    idimY = defIdimY,   //Inner Y dimension
                    idimZ = defIdimZ,   //Inner Z dimension
                    wallW = defWallW,   //Wall thickness
                    gapW  = defGapW,    //Gap between moving parts
                    coffZ = defCoffZ) { //Cavity offset in Z direction
    intersection() {     
        translate([gapW+wallW,0,coffZ]) cube([idimX,idimY,(idimZ/2)-coffZ]);
        union() { children(); }
    }
}

//Cut off the lower section of an object
module lowerSection(idimX = defIdimX,   //Inner X dimension
                    idimY = defIdimY,   //Inner Y dimension
                    idimZ = defIdimZ,   //Inner Z dimension
                    wallW = defWallW,   //Wall thickness
                    gapW  = defGapW,    //Gap between moving parts
                    coffZ = defCoffZ) { //Cavity offset in Z direction
    intersection() {     
        translate([gapW+wallW,0,-(idimZ/2)]) cube([idimX,idimY,(idimZ/2)-coffZ]);
        union() { children(); }
    }
}

module cavityShape(upper=false) {
   for (idx=[0:1:$children-1])  {
         hull() {
            translate([0,0,upper ? -1 : 0])
            linear_extrude(1) {
                projection(cut=false) children(idx);
            }
            children(idx);
        }
    }
}

//Space for opening the upper shell
module rotarySpace(rmax=(defGapW+defWallW+defIdimY)) {
    steps = r2sides4n(rmax)/4;   //Determine rotary steps
    for (idx=[0:1:$children-1])  {
        hull() {
            for (rotX=[0:90/steps:90]) {
                rotate([-rotX,0,0]) children(idx);
            }
        }
    }
}

//Test objects
module obj1() {
   translate([defIdimX/2,(defIdimY/2)+10,-(defIdimZ-10)/2]) cylinder(h=defIdimZ-10,r1=10,r2=0);
}
module obj2() {
   translate([defIdimX/2,(defIdimY/2)-10,-(defIdimZ-10)/2]) cylinder(h=defIdimZ-10,r1=0,r2=10);
}


if ($preview) {

    //Plain object
//    obj1();
//    obj2();
  
    //Shifted object
//    shift() { 
//        obj1();
//        obj2();
//    }
 
     //Object with slack
//     slack() { 
//         obj1();
//         obj2();
//     }
  
     //Upper section
//     upperSection() {
//         obj1();
//         obj2();
//     } 
    
     //Lower section
     lowerSection() {
         obj1();
         obj2();
     } 
    
    //Cavity shape
//    cavityShape(upper=true) { 
//        upperSection() { obj1(); }
//        upperSection() { obj2(); }
//    }

    //Cavity shape
//    rotarySpace() { 
//        upperSection() { obj1(); }
//        upperSection() { obj2(); }
//    }

}



