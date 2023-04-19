//###############################################################################
//# CaseBuilderLib - AirMouse                                                 #
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
//#    A case for a WeChip R2 air mouse.                                        #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   April  13, 2023                                                           #
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
IdimX=166; // [1:200]
//Inner Y dimension
IdimY=80;  // [1:200]
//Inner Y dimension
IdimZ=21;  // [1:200]

//Object offset in X direction
ObjX=0; // [-50:50]
//Object offset in Y direction
ObjY=10;  // [-50:50]
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
LabT="Air Mouse";
//Label size
LabS=24; // [0:40]

difference() { //for extra cut outs
    
CaseBuilder(pSet(stage=Stage,            //Design stage  
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
                  labS=LabS)) {          //Label size

        //Remote
        hull() {
          for (x = [162/2-54/2,54/2-162/2])            
          for (z = [2/2,-2/2]) {
            translate([x,0,z]) scale([54,54,18-2]) sphere4n(d=1,$fn=48);
          }    
        }           
        hull() {
          for (x = [116/2,-116/2])            
          for (y = [26/2,-26/2]) {
            translate([x,y,-18/2]) cylinder4n(h=18/2,d=10,$fn=24);
          }
        }
         
        //Dongle
        //transrot([-9-60,-40,0],[0,0,0]) cube([12.1,4.6,18.4],center=true);        
        transrot([-9-60,-40,6],[0,0,0]) cube([14.5,5,6.4]   ,center=true);        
               
        //Cable
        translate([-5-34/2-18/2-6,-40,0]) cube([34,14,16],center=true);             
        translate([-5-18/2-6/2,-40,0])    cube([8,14,6]  ,center=true);             
        translate([-5+162/2-90/2,-40,0])  cube([90,14,18],center=true);             

}

//Extra cutouts
union() {
  //Tight fitting dongle holder  
  translate([-9-60,-73.2,0]) cube([12.1,4.6,18.4],center=true);

  //Instructions
  translate([00,38.4,-10]) {   
    hull() {
      translate([0,0,0])  cube([106,70,0.6],center=true);
      translate([0,0,10]) cube([106,44,0.6],center=true);
    }      
    translate([0,0,10]) cube([106,60,20],center=true);
  }
}
}
