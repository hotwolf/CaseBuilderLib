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

use     <CaseBuilderLib_Hinge.scad>

//Color scheme
//============
objC      = "yellow"; //Object color
filC      = "orange"; //Filament color
errC      = "red";    //Error color
cavC      = "blue";   //Cavity color
ghC       = "blue";   //Grip hole color
dimC      = "gray";   //Color of dimension indicators
labC      = "gray";   //Label color

//Default values
//==============
defStage  =    1;     //Design stage
defOpenA  =  180;     //Opening angle
defUvisB  = true;     //Show upper part
defLvisB  = true;     //Show lower part
defIdimX  =   70;     //Inner X dimension
defIdimY  =   50;     //Inner Y dimension
defIdimZ  =   30;     //Inner Z dimension
defWallW  =    3;     //Wall thickness
defGapW   =    0.2;   //Gap between moving parts
defHSegW  =   10;     //Length of a hinge segment
defHSegD  =    5;     //Diameter of a hinge segment
defSlackX =    2;     //Object's slack in X direction
defSlackY =    2;     //Object's slack in Y direction
defSlackZ =    1;     //Object's slack in Z direction
defInlZ   =    3;     //Inlay offset in Z direction
defObjX   =    0;     //Object offset in X direction 
defObjY   =    0;     //Object offset in Y direction 
defObjZ   =    0;     //Object offset in Z direction 
defHingeO =    1;     //Hinge option     
defLockO  =    1;     //Lock option     
defGhX    =  [0];     //Grip hole positions
defGhW    =   15;     //Grip hole width
defLabT   =   "";     //Label text
defLabS   =    8;     //Label font size

//Parameter set
//=============
idxStage  =    0;     //Design stage
idxOpenA  =    1;     //Opening angle
idxUvisB  =    2;     //Show upper part
idxLvisB  =    3;     //Show lower part
idxIdimX  =    4;     //Inner X dimension
idxIdimY  =    5;     //Inner Y dimension
idxIdimZ  =    6;     //Inner Z dimension
idxWallW  =    7;     //Wall thickness
idxGapW   =    8;     //Gap between moving parts
idxHSegW  =    9;     //Length of a hinge segment
idxHSegD  =   10;     //Diameter of a hinge segment
idxSlackX =   11;     //Object's slack in X direction
idxSlackY =   12;     //Object's slack in Y direction
idxSlackZ =   13;     //Object's slack in Z direction
idxInlZ   =   14;     //Inlay offset in Z direction
idxObjX   =   15;     //Object offset in X direction 
idxObjY   =   16;     //Object offset in Y direction 
idxObjZ   =   17;     //Object offset in Z direction 
idxHingeO =   18;     //Hinge option     
idxLockO  =   19;     //Lock option     
idxGhX    =   20;     //Grip hole positions
idxGhW    =   21;     //Grip hole width
idxLabT   =   22;     //Label text
idxLabS   =   23;     //Label size

function pSet(stage  = defStage,   //Design stage
              openA  = defOpenA,   //Opening angle
              uvisB  = defUvisB,   //Show upper part
              lvisB  = defLvisB,   //Show lower part
              idimX  = defIdimX,   //Inner X dimension
              idimY  = defIdimY,   //Inner Y dimension
              idimZ  = defIdimZ,   //Inner Z dimension
              wallW  = defWallW,   //Wall thickness
              gapW   = defGapW,    //Gap between moving parts
              hSegW  = defHSegW,   //Length of a hinge segment
              hSegD  = defHSegD,   //Diameter of a hinge segment
              slackX = defSlackX,  //Object's slack in X direction
              slackY = defSlackY,  //Object's slack in Y direction
              slackZ = defSlackZ,  //Object's slack in Z direction
              inlZ   = defInlZ,    //Inlay offset in Z direction
              objX   = defObjX,    //Object offset in X direction 
              objY   = defObjY,    //Object offset in Y direction 
              objZ   = defObjZ,    //Object offset in Z direction 
              hingeO = defHingeO,  //Hinge option     
              lockO  = defLockO,   //Lock option     
              ghX    = defGhX,     //Grip hole positions
              ghW    = defGhW,     //Grip hole width
              labT   = defLabT,    //Label text
              labS   = defLabS) =  //Label size
             [stage,               //Design stage
              openA,               //Opening angle
              uvisB,               //Show upper part
              lvisB,               //Show lower part
              idimX,               //Inner X dimension
              idimY,               //Inner Y dimension
              idimZ,               //Inner Z dimension
              wallW,               //Wall thickness
              gapW,                //Gap between moving parts
              hSegW,               //Length of a hinge segment
              hSegD,               //Diameter of a hinge segment
              slackX,              //Object's slack in X direction
              slackY,              //Object's slack in Y direction
              slackZ,              //Object's slack in Z direction
              inlZ,                //Inlay offset in Z direction              
              objX,                //Object offset in X direction 
              objY,                //Object offset in Y direction 
              objZ,                //Object offset in Z direction 
              hingeO,              //Hinge option     
              lockO,               //Lock option     
              ghX,                 //Grip hole positions
              ghW,                 //Grip hole width
              labT,                //Label text
              labS];               //Label size
                        
 //Common variables             
inf = 1000;                        //Huge number

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
//Object offset
module objOff(pSet) {
    //Short cuts
    objX   = pSet[idxObjX];    //Object offset in X direction 
    objY   = pSet[idxObjY];    //Object offset in Y direction 
    objZ   = pSet[idxObjZ];    //Object offset in Z direction 

    translate([objX,objY,objZ]) children();
}

//Position the lower part of the case
module lowerPos(pSet) {
    //Short cuts
    lvisB  = pSet[idxLvisB];  //Show lower part
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    hingeO = pSet[defHingeO]; //Hinge option     
    hoffX  = hoffX(pSet);     //Hinge offset
    
    if (lvisB || (!$preview && is_indivisibleHinge(pSet)))    
        translate([0,-hoffX-wallW-idimY/2,0]) children(); 
}

//Positon the upper part of the case
module upperPos(pSet) {
    //Short cuts
    uvisB  = pSet[idxUvisB];  //Show upper part
    openA  = pSet[idxOpenA];  //Opening angle
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    hingeO = pSet[idxHingeO]; //Hinge option     
    hoffX  = hoffX(pSet);     //Hinge offset

    if (uvisB || (!$preview && is_indivisibleHinge(pSet)))    
        rotate([$preview ? -openA : -180,0,0]) translate([0,-hoffX-wallW-idimY/2,0]) children(); 
}

//Safe intersection
module safeIntersection() {
    difference () {
        intersection() {
            union() {
                children(0);
                translate([inf,inf,inf]) cube(1,center=true);
            }
            union() {
                children(1);
                translate([inf,inf,inf]) cube(1,center=true);
            }
        }
        translate([inf,inf,inf]) cube(2,center=true);     
    }
}

//Combined translate and rotate
module transrot(trans=[0,0,0],rot=[0,0,0]) {
    translate(trans) rotate(rot) children();
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
         is_undef(d)  ? r : d/2 : r2 : d2/2;        
                    
    cylinder(h=h,r1=R1,r2=R2,$fn=r2sides4n(max(R1,R2)));
}
 

module circle4n(r, d = undef) {
    R = is_undef(d) ? r : d / 2;
    circle(R,$fn=r2sides4n(R));
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
    rotate_extrude($fn=r2sides4n(R))
        rotate(-90)
            semicircle4n(R);
}         

//Hemiphere with multiple of 4 vertices
module hemisphere4n(r = 1, d = undef, shs =false) {
    R = is_undef(d) ? r : d / 2;
    rotate_extrude($fn=r2sides4n(R))
        rotate(shs ? 90 : -90)
            quadrant4n(R);
}

//Torus with multiple of 4 vertices
module torus4n(r1,            //Radius of the circle profile
               r2,            //Radius of the sweep
               d1    = undef, //Diameter of the circle profile
               d2    = undef, //Diameter of the sweep
               angle = 360) { //Angle of the sweep
    //First radius                
    R1 = is_undef(d1) ? r1 : d1/2;        

    //Second radius                
    R2 = is_undef(d2) ? r2 : d2/2;        

    //Torus
    rotate_extrude(angle=angle,$fn=r2sides4n(R1+R2))               
    translate([R2,0,0])               
    circle(R1,$fn=r2sides4n(R1));    
}

//Empty shape
module dummy() {}