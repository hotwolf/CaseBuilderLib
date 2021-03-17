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
    openA  = pSet[idxOpenA];  //Opening angle
    uvisB  = pSet[idxUvisB];  //Show upper part
    lvisB  = pSet[idxLvisB];  //Show lower part
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
    objX   = pSet[idxObjX];   //Object offset in X direction 
    objY   = pSet[idxObjY];   //Object offset in Y direction 
    objZ   = pSet[idxObjZ];   //Object offset in Z direction 
    hingeO = pSet[defHingeO]; //Hinge option        
    lockO  = pSet[idxLockO];  //Lock option   
    ghX    = pSet[idxGhX];    //Grip hole positions
    ghW    = pSet[idxGhW];    //Grip hole width
    labT   = pSet[idxLabT];   //Label text
    labS   = pSet[idxLabS];   //Label size
 
    //Model stage
    //===========
    if ((stage==1)&&($preview)) {

        //Draw object
        color(objC) 
        objOff(pSet) 
        children();
               
        //Draw grip hole positions
        if (lvisB==true) { color(ghC,0.55) ghPos(pSet); }
        echo("lvisB: ",LvisB); 

      
        //Visualize inner dimensions
        if (uvisB) color(dimC,0.25) upperIdimBb(pSet);
        if (lvisB) color(dimC,0.35) lowerIdimBb(pSet);
       
        //Preview label
        color(labC,0.75) flatLabel(pSet);
    }       

    //Check stage
    //===========
    if ((stage==2)&&($preview)) {

        //Lower part
        lowerPos(pSet) {
            
            //Show object
            color(objC) objOff(pSet) lowerIdimTrim(pSet) children();
            color(objC) objOff(pSet) upperIdimTrim(pSet) children();
            
            //Show cavities
            for (idx=[0:$children-1]) {
                color(cavC,0.45) 
                lowerCav(pSet)
                objOff(pSet)         
                children(idx);
            }            
   
            //Show grip holes
            color(ghC,0.45)         
            ghShapes(pSet) 
            for (idx=[0:$children-1]) {
                lowerCav(pSet) 
                objOff(pSet)         
                children(idx);
            }
 
            //Show lock restrictions
            color(dimC,0.45) 
            lowerIdimTrim(pSet)
            lockSpace(pSet);
 
            //Show inner dimensions
            color(dimC,0.35) lowerIdimBb(pSet);

            //Show dimension violations
            color(errC) 
            lowerOuterErr(pSet) 
            for (idx=[0:$children-1]) {
                lowerCav(pSet) 
                objOff(pSet)         
                children(idx);
            }
            
            //Show cavity/lock conflicts 
            color(errC) 
            lowerInnerErr(pSet) 
            safeIntersection() {
                for (idx=[0:$children-1]) {
                    lowerCav(pSet) 
                    objOff(pSet)         
                    children(idx);
                }
                lockSpace(pSet);
            }
            
            //Show grip hole/lock conflicts 
           color(errC) 
            lowerInnerErr(pSet) 
            safeIntersection() {
                ghShapes(pSet) 
                for (idx=[0:$children-1]) {
                    lowerCav(pSet) 
                    objOff(pSet)         
                    children(idx);
                }
                lockSpace(pSet);
            }
        }

        //Upper part
        upperPos(pSet) {
            
            //Show cavities
            for (idx=[0:$children-1]) {
                color(cavC,0.45) 
                upperCav(pSet)         
                objOff(pSet)         
                children(idx);
            }            
    
            //Show lock restrictions
            color(dimC,0.45) 
            upperIdimTrim(pSet)
            lockSpace(pSet);
 
            //Show inner dimensions
            color(dimC,0.25) upperIdimBb(pSet);

            //Show dimension violations
            color(errC) 
            upperOuterErr(pSet)
            for (idx=[0:$children-1]) {
                color(cavC,0.45) 
                upperCav(pSet)         
                objOff(pSet)         
                children(idx);
            }            
           
            //Show cavity/lock conflicts 
            color(errC) 
            upperInnerErr(pSet) 
            safeIntersection() {
                for (idx=[0:$children-1]) {
                    upperCav(pSet) 
                    objOff(pSet)         
                    children(idx);
                }
                lockSpace(pSet);
            }
         }
     }
   
    //Generate stage
    //==============
    if ((stage==3)||(!$preview)) {

       //Lower part
        lowerPos(pSet) {
            
            //Show object
            if ($preview) color(objC) objOff(pSet) children();
 
            //Draw inlay
            color(filC)
            difference() {
                lowerInlBb(pSet);
                union() {  
                    for (idx=[0:$children-1]) {
                        lowerCav(pSet) 
                        objOff(pSet)         
                        children(idx);
                    }
                    ghShapes(pSet) 
                    for (idx=[0:$children-1]) {
                        lowerCav(pSet) 
                        objOff(pSet)         
                        children(idx);
                    }
                }   
            }         

            //Draw shell
            color(filC)
            lowerShell(pSet);
        }

       //Upper part
        upperPos(pSet) {
            
             //Draw inlay
            color(filC)
            difference() {
                upperInlBb(pSet);
                 for (idx=[0:$children-1]) {
                    upperCav(pSet) 
                    objOff(pSet)         
                    children(idx);
                }
            }            

            //Draw shell
            color(filC)
            upperShell(pSet);
        }
    }
}

