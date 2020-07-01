//###############################################################################
//# CaseBuilderLib - A library for custom 3D printed cases                      #
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
//#   Main include file.                                                        #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   June 29, 2020                                                             #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib_Common.scad>

//Main builder module
module CaseBuilder(stage=3,          //Design stage  
                   idimX=defIdimX,   //Inner X dimension
                   idimY=defIdimY,   //Inner X dimension
                   idimZ=defIdimZ,   //Inner X dimension
                     ghX=defGhX,     //Grip hole positions
                     ghW=defGhW,     //Grip hole width
                    labT=defLabT,    //Label text
                    labS=defLabS) {  //Label size

    //Model stage
    if ((stage==1)&&($preview)) {

        //Draw children and color code boundary violations
        for (idx=[0:1:$children-1])  {

            //Draw parts out of range range red
            color("red")
//            hull() {
                difference() {
                    children(idx);
                    cube([idimX,idimY,idimZ],center=true);
                }
//            }

            //Draw parts within range green
            color("green")
            hull() {
                intersection() {
                    children(idx);
                    cube([idimX,idimY,idimZ],center=true);
                }
            }        
        }
    
        //Visualize inner dimensions
        color("gray",0.25) translate([0,0,idimZ/4])  cube([idimX,idimY,idimZ/2],center=true);
        color("gray",0.45) translate([0,0,-idimZ/4]) cube([idimX,idimY,idimZ/2],center=true);
        
    }       
}







if ($preview) {

    //Shell
//    shell();
   
}



