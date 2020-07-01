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
defCoffZ  =   5;   //Cavity offset in Z direction
defGhX    =  [];   //Grip hole positions
defGhW    =  15;   //Grip hole width
defLabT   =  "";   //Label text
defLabS   =   0;   //Label size

//Common functions
//================
//Reuse from NopSCADlib:
function r2sides(r)   = $fn ? $fn : ceil(max(min(360/ $fa, r * 2 * PI / $fs), 5)); //Replicates the OpenSCAD logic to calculate the number of sides from the radius
function r2sides4n(r) = floor((r2sides(r) + 3) / 4) * 4;                           //Round up the number of sides to a multiple of 4 to ensure points land on all axes

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
