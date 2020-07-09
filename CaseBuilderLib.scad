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
use     <CaseBuilderLib_Shell.scad>
use     <CaseBuilderLib_Label.scad>
use     <CaseBuilderLib_Lock.scad>

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
    inlZ   = pSet[idxInlZ];   //Inlay offset in Z direction
    ghX    = pSet[idxGhX];    //Grip hole positions
    ghW    = pSet[idxGhW];    //Grip hole width
    labT   = pSet[idxLabT];   //Label text
    labS   = pSet[idxLabS];   //Label size
    lockO  = pSet[idxLockO];  //Lock option

    //Model stage
    //===========
    if ((stage==1)&&($preview)) {

        //Draw children and color code boundary violations
        color(objC) trim(pSet) children();
               
        //Draw grip hole positions
        color(ghC,0.55) ghPos(pSet);
      
        //Visualize inner dimensions
        color(dimC,0.25) upperIdimBb(pSet);
        color(dimC,0.45) lowerIdimBb(pSet);

        //Draw error
        color(errC)  outerBErr(pSet) children();
        
        //Preview label
        color(labC,0.75) flatLabel(pSet);
    }       

    //Check stage
    //===========
    if ((stage==2)&&($preview)) {
    
       //Show lock restictions
        if (lockO!=0) {
            color(dimC,0.65) 
            shift(pSet) 
            lowerTrim(pSet)
            lockSpace(pSet);
            color(dimC,0.45)
            open(pSet)
            upperTrim(pSet) 
            lockSpace(pSet);               
        }
         
        //Show lower cavity
        for (idx=[0:1:$children-1])
        color(cavC) 
        shift(pSet) 
        lowerTrim(pSet)
        lowerCavShape(pSet) 
        children(idx);
            
        //Show upper cavity
        for (idx=[0:1:$children-1])
        color(cavC) 
        open(pSet)
        upperTrim(pSet)
        upperCavShape(pSet) 
        children(idx);
        
        //Show grip holes
        color(ghC,0.60)        
        shift(pSet) ghShapes(pSet) 
        for (idx=[0:1:$children-1]) lowerCavShape(pSet) children(idx);

        //Show lower errors indicators
        color(errC)
        shift(pSet) 
        for (idx=[0:1:$children-1]) {
             lowerOuterBErr(pSet) lowerCavShape(pSet) children(idx);
             lowerInnerBErr(pSet) {
                 lowerCavShape(pSet) children(idx);
                 lockSpace(pSet);
             }
         }
 
        //Show uppwer errors indicators
        color(errC)
        open(pSet) 
        for (idx=[0:1:$children-1]) {
             upperOuterBErr(pSet) upperCavShape(pSet) children(idx);
             lowerInnerBErr(pSet) {
                 upperCavShape(pSet) children(idx);
                 lockSpace(pSet);
             }
         }
 
        //Visualize inner dimensions
        color(dimC,0.45) shift(pSet) lowerIdimBb(pSet);
        color(dimC,0.25) open(pSet)  upperIdimBb(pSet);

        //Preview label
        color(labC,0.75) open(pSet) flatLabel(pSet);
    }

    //Generate stage
    //==============
   if ((stage==3)||(!$preview)) {

        //Draw lower inlay
        color(filC)
        shift(pSet) 
        difference() {
            lowerInlBb(pSet);
            union() {
                //Cavity
                for (idx=[0:1:$children-1]) lowerCavShape(pSet) children(idx);
                //Grip holes
                ghShapes(pSet) 
                for (idx=[0:1:$children-1]) lowerCavShape(pSet) children(idx);
                //Lock
                lowerLockNeg(pSet);
            }   
        } 

        //Draw upper inlay
        color(filC)
        open(pSet)
        difference() {
            upperInlBb(pSet);
            union() {
                //Cavity
                for (idx=[0:1:$children-1]) upperCavShape(pSet) children(idx);
                //Lock
                lowerLockNeg(pSet);
            }
        } 
 
        //Draw lower shell
        color(filC)
        shift(pSet) lowerShell(pSet);

        //Draw upper shell
        color(filC)
        open(pSet) upperShell(pSet);

        //Hover object uver open case
        if ($preview) {
            color(objC)
            translate([0,0,0]) shift(pSet) children();
        }
    }
}

if ($preview) {

    //Shell
//    shell();
   
}



