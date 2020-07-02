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
use     <CaseBuilderLib_Boundary.scad>
use     <CaseBuilderLib_Cavity.scad>
use     <CaseBuilderLib_GripHole.scad>

//Main builder module
module CaseBuilder(pSet) {
    //Short cuts
    stage  = pSet[idxStage];  //Design stage  
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    hsegW  = pSet[idxHSegW];  //Length of a hinge segment
    hsegD  = pSet[idxHSegD];  //Diameter of a hinge segment
    slackX = pSet[idxSlackX]; //Object's slack in X direction
    slackY = pSet[idxSlackY]; //Object's slack in Y direction
    slackZ = pSet[idxSlackZ]; //Object's slack in Z direction
    coofZ  = pSet[idxCoffZ];  //Cavity offset in Z direction
    ghX    = pSet[idxGhX];    //Grip hole positions
    ghW    = pSet[idxGhW];    //Grip hole width
    labT   = pSet[idxLabT];   //Label text
    labS   = pSet[idxLabS];   //Label size

    //Model stage
    //===========
    if ((stage==1)&&($preview)) {

        //Draw children and color code boundary violations
        for (idx=[0:1:$children-1])  {
            idimBCheck(pSet) {
                children(idx);
            }
        }
                
        //Draw grip hole positions
        color("yellow",0.55)
        ghPos(pSet);
      
        //Visualize inner dimensions
        color("gray",0.25) upperIdimBb(pSet);
        color("gray",0.45) lowerIdimBb(pSet);
        
        //Preview label
        
    }       

    //Check stage
    //===========
    if ((stage==2)&&($preview)) {
    
        //Show lower cavity
        for (idx=[0:1:$children-1])  {
            shift(pSet) {
                lowerIdimBCheck(pSet) {
                    difference() {
                        lowerCavShape(pSet) {
                            children(idx);
                        }
                        upperInfBb();
                    }
                }
            }
        }

        //Show upper cavity
        for (idx=[0:1:$children-1])  {
            open(pSet) {
                upperIdimBCheck(pSet) {
                    difference() {
                        upperCavShape(pSet) {
                            children(idx);
                        }
                        lowerInfBb();
                    }
                }
            }
        }
        
        //Visualize inner dimensions
        color("gray",0.45) shift(pSet) lowerIdimBb(pSet);
        color("gray",0.25) open(pSet)  upperIdimBb(pSet);


    }

    //Generate stage
    //==============
   if ((stage==3)||(!$preview)) {


        //Draw shell



        //Hover object uver open case
        if ($preview) {
            color("yellow")
            translate([gapW+wallW+idimX/2,0,40+idimZ/2]) children();
        }
    }
}







if ($preview) {

    //Shell
//    shell();
   
}



