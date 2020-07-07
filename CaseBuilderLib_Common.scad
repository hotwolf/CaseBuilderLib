//###############################################################################
//# CaseBuilderLib - Default values and common functions                        #
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
//#   Common functions and definitions of global variables.                     #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   June 29, 2020                                                             #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

//Default values
//==============
defStage  =   1;   //Design stage
defIdimX  = 100;   //Inner X dimension
defIdimY  =  50;   //Inner Y dimension
defIdimZ  =  30;   //Inner Z dimension
defWallW  =   3;   //Wall thickness
defGapW   =   0.2; //Gap between moving parts
defHSegW  =  10;   //Length of a hinge segment
defHSegD  =   5;   //Diameter of a hinge segment
defSlackX =   2;   //Object's slack in X direction
defSlackY =   2;   //Object's slack in Y direction
defSlackZ =   1;   //Object's slack in Z direction
defInlZ   =   3;   //Inlay offset in Z direction
defGhX    = [0];   //Grip hole positions
defGhW    =  15;   //Grip hole width
defLabT   =  "";   //Label text
defLabS   =   0;   //Label size

//Parameter set
//=============
idxStage  =   0;   //Design stage
idxIdimX  =   1;   //Inner X dimension
idxIdimY  =   2;   //Inner Y dimension
idxIdimZ  =   3;   //Inner Z dimension
idxWallW  =   4;   //Wall thickness
idxGapW   =   5;   //Gap between moving parts
idxHSegW  =   6;   //Length of a hinge segment
idxHSegD  =   7;   //Diameter of a hinge segment
idxSlackX =   8;   //Object's slack in X direction
idxSlackY =   9;   //Object's slack in Y direction
idxSlackZ =  10;   //Object's slack in Z direction
idxInlZ   =  11;   //Inlay offset in Z direction
idxGhX    =  12;   //Grip hole positions
idxGhW    =  13;   //Grip hole width
idxLabT   =  14;   //Label text
idxLabS   =  15;   //Label size

function pSet(stage  = defStage,  //Design stage
              idimX  = defIdimX,  //Inner X dimension
              idimY  = defIdimY,  //Inner Y dimension
              idimZ  = defIdimZ,  //Inner Z dimension
              wallW  = defWallW,  //Wall thickness
              gapW   = defGapW,   //Gap between moving parts
              hSegW  = defHSegW,  //Length of a hinge segment
              hSegD  = defHSegD,  //Diameter of a hinge segment
              slackX = defSlackX, //Object's slack in X direction
              slackY = defSlackY, //Object's slack in Y direction
              slackZ = defSlackZ, //Object's slack in Z direction
              inlZ   = defInlZ,   //Inlay offset in Z direction
              ghX    = defGhX,    //Grip hole positions
              ghW    = defGhW,    //Grip hole width
              labT   = defLabT,   //Label text
              labS   = defLabS) = //Label size
             [stage,              //Design stage
              idimX,              //Inner X dimension
              idimY,              //Inner Y dimension
              idimZ,              //Inner Z dimension
              wallW,              //Wall thickness
              gapW,               //Gap between moving parts
              hSegW,              //Length of a hinge segment
              hSegD,              //Diameter of a hinge segment
              slackX,             //Object's slack in X direction
              slackY,             //Object's slack in Y direction
              slackZ,             //Object's slack in Z direction
              inlZ,               //Inlay offset in Z direction
              ghX,                //Grip hole positions
              ghW,                //Grip hole width
              labT,               //Label text
              labS];              //Label size
                          
 //Common variables             
inf = 10000;                      //Huge number

//Common functions
//================
//Reuse from NopSCADlib:
function r2sides(r)   = $fn ? $fn : ceil(max(min(360/ $fa, r * 2 * PI / $fs), 5)); //Replicates the OpenSCAD logic to calculate the number of sides from the radius
function r2sides4n(r) = floor((r2sides(r) + 3) / 4) * 4;                           //Round up the number of sides to a multiple of 4 to ensure points land on all axes

//Check for even/odd numbers
function is_even(n) = (n/2) == floor(n/2);
function is_odd(n)  = (n/2) != floor(n/2);

//Common operations
//=================
//Shift first child from the center to the lower shell position
module shift(pSet) {
    //Short cuts
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts    
    translate([0,-gapW-wallW-idimY/2,0]) children(0); 
}

//Shift first child from the center to the opened upper shell positon
module open(pSet) {
    //Short cuts
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts    
    rotate([180,0,0]) translate([0,-gapW-wallW-idimY/2,0]) children(0); 
}

//Common shapes
//=============
//Cylinder with multiple of four sides
module cylinder4n(h,
                  r,
                  d  = undef,
                  r1 = undef,
                  r2 = undef,
                  d1 = undef,
                  d2 = undef) {
    //First radius                
    R1 = is_undef(d1) ?
         is_undef(r1) ?
         is_undef(d)  ? r : d/2 : r1 : d1/2;        
                    
     //Second radius                
    R2 = is_undef(d2) ?
         is_undef(r2) ?
         is_undef(d)  ? r : d/2 : r2 : d1/2;        
                    
    cylinder(h=h,r1=R1,r2=R2,$fn=r2sides4n(max(R1,R2)));
}
 

module circle4n(r, d = undef) {
    R = is_undef(d) ? r : d / 2;
    circle(R, $fn = r2sides4n(R));
}
  
//Semi circle in the positive Y domain (reuse from NopSCADlib)
module semicircle4n(r, d = undef)
    intersection() {
        R = is_undef(d) ? r : d / 2;
        circle4n(R);

        sq = R + 1;
        translate([-sq, 0])
            square([2 * sq, sq]);
    }
            
//Quadrant in the positive X and Y domain (reuse from NopSCADlib)
module quadrant4n(r, d = undef)
    intersection() {
        R = is_undef(d) ? r : d / 2;
        circle4n(R);

        sq = R + 1;
        translate([-sq, 0])
            square([sq, sq]);
    }
    
//Sphere with multiple of 4 vertices (reuse from NopSCADlib)
module sphere4n(r = 1, d = undef) {
    R = is_undef(d) ? r : d / 2;
    rotate_extrude($fn = r2sides4n(R))
        rotate(-90)
            semicircle4n(R);
}         

//Hemiphere with multiple of 4 vertices
module hemisphere4n(r = 1, d = undef, shs =false) {
    R = is_undef(d) ? r : d / 2;
    rotate_extrude($fn = r2sides4n(R))
        rotate(shs ? 90 : -90)
            quadrant4n(R);
}         
