//###############################################################################
//# CaseBuilderLib - SSD                                                 #
//###############################################################################
//#    Copyright 2023 Dirk Heisswolf                                            #
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
//#    A case for a Samsung SSD T7.                                             #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   August  8, 2023                                                           #
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
IdimX=120; // [1:200]
//Inner Y dimension
IdimY=62;  // [1:200]
//Inner Y dimension
IdimZ=33;  // [1:200]

//Object offset in X direction
ObjX=0; // [-50:50]
//Object offset in Y direction
ObjY=0;  // [-50:50]
//Object offset in Z direction
ObjZ=0;  // [-50:50]

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
LabT="SSD";
//Label size
LabS=24; // [0:40]

pSet=pSet( stage=Stage,            //Design stage  
           openA=OpenA,            //Opening angle
           uvisB=UvisB,            //Show upper part
           lvisB=LvisB,            //Show lower part
           idimX=IdimX,            //Inner X dimension
           idimY=IdimY,            //Inner X dimension
           idimZ=IdimZ,            //Inner X dimension
          slackX=1,                //Object's slack in X direction
          slackY=1,                //Object's slack in Y direction
          slackZ=1,                //Object's slack in Z direction    
            objX=ObjX,             //Object offset in X direction 
            objY=ObjY,             //Object offset in Y direction 
            objZ=ObjZ,             //Object offset in Z direction 
           lockO=LockO,            //Lock option   
             ghX=[Gh1X,Gh2X,Gh3X], //Grip hole offsets
            labT=LabT,             //Label text
            labS=LabS);            //Label size

difference() { //for extra cut outs

CaseBuilder(pSet) {

   hull() {       
     transrot([-42.55, 24.5,0],[0,90,0]) cylinder4n(d=8.2,h=83);
     transrot([-42.55,-24.5,0],[0,90,0]) cylinder4n(d=8.2,h=83);
   }

}

//Extra cutouts
union() {

  lowerPos(pSet) {
    difference() {
      hull() {
        translate([35,0,-16.1]) cylinder4n(h=22,r1=22.5+4,r2=22.5-2);
        translate([-35,0,-16.1]) cylinder4n(h=22,r1=22.5+4,r2=22.5-2);
      }
      hull() {
        translate([45,0,-16.1]) cylinder4n(h=23,d=9);
        translate([-45,0,-16.1]) cylinder4n(h=23,d=9);
      }
    }
  }
      
  upperPos(pSet) {
    difference() {
      hull() {
        translate([35,0,-5.9]) cylinder4n(h=22,r1=22.5-2,r2=22.5+4);
        translate([-35,0,-5.9]) cylinder4n(h=22,r1=22.5-2,r2=22.5+4);
      }
      hull() {
        translate([45,0,-6.9]) cylinder4n(h=23,d=9);
        translate([-45,0,-6.9]) cylinder4n(h=23,d=9);
      }
    }
  }

}
}
