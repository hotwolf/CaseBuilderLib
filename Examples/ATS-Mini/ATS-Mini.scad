//###############################################################################
//# CaseBuilderLib - ATS-Mini                                                   #
//###############################################################################
//#    Copyright 2025 Dirk Heisswolf                                            #
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
//#    A case for a ATS-Mini radio.                                             #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   July  26, 2023                                                           #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <../../CaseBuilderLib.scad>

/* [View] */
//Design stage
Stage=1; // [1:Model, 2:Check, 3:Generate]

//Opening angle
OpenA=180; // [0:180]

//Show upper part
UvisB = true;

//Show lower part
LvisB = true;

/* [Design Options] */
//Inner X dimension
IdimX=132; // [1:200]
//Inner Y dimension
IdimY=62;  // [1:200]
//Inner Y dimension
IdimZ=33.4;  // [1:200]

//Object offset in X direction
ObjX=-63; // [-50:50]
//Object offset in Y direction
ObjY=-5.5;  // [-50:50]
//Object offset in Z direction
ObjZ=-3.5;  // [-50:50]

//First grip hole's X offset
//Gh1X=-7+162/2-90/2;    // [-100:100]
Gh1X=-1000; // [-100:100]
//Second grip hole's X offset
//Gh2X=-7-34/2-18/2-6; // [-100:100]
Gh2X=-1000; // [-100:100]
//Third grip hole's X offset
Gh3X=-1000; // [-100:100]

//Lock Option
LockO=2; // [1:Elastic String, 2:Pull Latch]

//Label text
LabT="Radio";
//Label size
LabS=28; // [0:40]

/* [More...] */
//Parts
Parts = 1; // [1:Case, 2:Spool]

//Detail
$fn = 128; // [8:512]

if (Parts==1)
difference() { //for extra cut outs
    
pSet =      pSet(stage=Stage,            //Design stage  
                 openA=OpenA,            //Opening angle
                 uvisB=UvisB,            //Show upper part
                 lvisB=LvisB,            //Show lower part
                 idimX=IdimX,            //Inner X dimension
                 idimY=IdimY,            //Inner X dimension
                 idimZ=IdimZ,            //Inner X dimension
                  objX=ObjX,             //Object offset in X direction 
                  objY=ObjY,             //Object offset in Y direction 
                  objZ=ObjZ,             //Object offset in Z direction 
                 lockO=LockO,            //Lock option   
                   ghX=[Gh1X,Gh2X,Gh3X], //Grip hole offsets
                  labT=LabT,             //Label text
                  labS=LabS);            //Label size

CaseBuilder(pSet) {          //Label size

      
        $fn= 24;
        //Radio
        translate([0,0,0]) cube([81,34.3,19]);
        //Knob
        translate([81-13,34.3/2,-12]) cylinder(h=12, d=16.2);
        //Antenna
        translate([11.3,0,9]) rotate([270,0,180]) cylinder(h=10, d=9.1);
        translate([11.3,0,9]) rotate([270,0,180]) cylinder(h=23, d=6);
        translate([11.3,-20.5,9]) rotate([0,90,0]) cylinder(h=115, d=5);
        //Earbuds
        translate([96,26,-12]) cylinder(h=16, d=17);
        translate([96,26,0]) rotate([0,90,270]) cylinder(h=16, d=8);
        *translate([96,26,0]) rotate([0,90,270]) cylinder(h=30, d=2);
        translate([118,26,-12]) cylinder(h=16, d=17);
        translate([118,26,0]) rotate([0,90,270]) cylinder(h=16, d=8);
        *translate([118,26,0]) rotate([0,90,270]) cylinder(h=30, d=2);
    
}

//Extra cutouts
union() {
    lowerPos(pSet) {
        //Ditch
        hull() {
            translate([-20,-14,2-IdimZ/2]) cylinder(h=18, r1=6, r2=4);   
            translate([60,-14,2-IdimZ/2]) cylinder(h=18, r1=6, r2=4);   
            translate([-20,-24,2-IdimZ/2]) cylinder(h=18, r1=6, r2=4);   
            translate([60,-24,2-IdimZ/2]) cylinder(h=18, r1=6, r2=4);   
        }        
         hull() {
            translate([28,-4,2-IdimZ/2]) cylinder(h=18, r1=6, r2=4);   
            translate([60,-4,2-IdimZ/2]) cylinder(h=18, r1=6, r2=4);   
            translate([28,-24,2-IdimZ/2]) cylinder(h=18, r1=6, r2=4);   
            translate([60,-24,2-IdimZ/2]) cylinder(h=18, r1=6, r2=4);   
        }
        
        //Cable tunnel
        #translate([99-IdimX/2,20,-4]) rotate([0,90,270]) cylinder(h=30, d=4);
        #translate([121-IdimX/2,20,-4]) rotate([0,90,270]) cylinder(h=30, d=4);
       
        //Spool
        translate([(IdimY-IdimX)/2,0,-IdimZ/2]) cylinder(h=20, d=IdimY-2);
        
    }
}
}
            
//Spool
if (Parts==2)
union() {
    //Upper part
    difference() {
        union() {
            translate([IdimY/2,0,0]) cylinder(h=2, d=IdimY-2.4);
            translate([IdimY/2,0,6]) cube([8,10,12], center=true);
            difference() {
                translate([IdimY/2,0,0]) cylinder(h=3, d=20);
                translate([IdimY/2,0,6]) rotate([0,90,0]) cylinder(h=20, d=8, center=true);
            }
        }
        union() {
            translate([0.19*IdimY,0,0])  cylinder(h=10, d=18, center=true);
            translate([0.81*IdimY,0,0])  cylinder(h=10, d=18, center=true);
            translate([IdimY/2,0,6]) rotate([0,90,0]) cylinder(h=20, d=3.58, center=true);
        }
    }
   
    
    
    //Lower part
    difference() {
        union() {
            translate([-IdimY/2,0,0]) cylinder(h=2, d=IdimY-2.4);
            translate([-IdimY/2,0,0]) cylinder(h=9, d=20);
       }
        union() {
            translate([-0.19*IdimY,0,0])  cylinder(h=10, d=18, center=true);
            translate([-0.81*IdimY,0,0])  cylinder(h=10, d=18, center=true);
            translate([-IdimY/2,0,6]) cube([8,10,14], center=true);
           translate([-IdimY/2,0,6]) rotate([0,90,0]) cylinder(h=20, d=8, center=true);
          }
     }
}
