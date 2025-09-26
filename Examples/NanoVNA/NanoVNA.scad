//###############################################################################
//# CaseBuilderLib - NanoVNA                                                    #
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
//#    A case for a NanoVNA-H4.                                                 #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   September 24, 2025                                                        #
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
IdimX=168; // [1:200]
//Inner Y dimension
IdimY=100;  // [1:200]
//Inner Y dimension
IdimZ=21;  // [1:200]

//Object offset in X direction
ObjX=50; // [-50:50]
//Object offset in Y direction
ObjY=-26;  // [-50:50]
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
LabT="NanoVNA";
//Label size
LabS=24; // [0:40]

$fn = 128;

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
    
    //Case
    transrot([-132.4,0,-18.4/2],[0,0,0])
        cube([132.4,74.6,18.4]);        

    //Adapters
    transrot([8,43,0],[0,0,0]) cylinder(h=3.6, d=9.2, $fn=6);  
    transrot([8,30,0],[0,0,0]) cylinder(h=3.6, d=9.2, $fn=6);  
    transrot([8,17,0],[0,0,0]) cylinder(h=3.6, d=9.2, $fn=6);    
    transrot([8, 4,0],[0,0,0]) cylinder(h=3.6, d=9.2, $fn=6);        

    transrot([33,67,0],[0,270,0]) cylinder(h=18.4, d=15.3);        
    transrot([33,67,0],[0,270,0]) cylinder(h=30, d=8);        
    transrot([14.6,67,0],[0,270,0]) cylinder(h=3.2, d1= 15.3, d2=10.6);        

    transrot([8,55,0],[0,0,0]) cylinder(h=7, d=6.3);        
}

//Extra cutouts
union() {

  lowerPos(pSet) {
    
    //Adapters
    transrot([8+ObjX,43+ObjY,-8],[0,0,0]) cylinder(h=5.6, d=9.6, $fn=6);  
    transrot([8+ObjX,30+ObjY,-8],[0,0,0]) cylinder(h=5.6, d=9.6, $fn=6);  
    transrot([8+ObjX,17+ObjY,-8],[0,0,0]) cylinder(h=5.6, d=9.6, $fn=6);    
    transrot([8+ObjX, 4+ObjY,-8],[0,0,0]) cylinder(h=5.6, d=9.6, $fn=6);        

    transrot([8+ObjX,55+ObjY,-10],[0,0,0]) cylinder(h=10, d=6.7);        
    
    //Cable holders  
    hull() {
        translate([-81,-33,-10.5]) cylinder4n(h=11,r1=4,r2=2);
        translate([-81,-46,-10.5]) cylinder4n(h=11,r1=4,r2=2);
        translate([ 81,-33,-10.5]) cylinder4n(h=11,r1=4,r2=2);
        translate([ 81,-46,-10.5]) cylinder4n(h=11,r1=4,r2=2);
      }   
    hull() {
        translate([ 68, 28,-10.5]) cylinder4n(h=11,r1=4,r2=2);
        translate([ 81, 28,-10.5]) cylinder4n(h=11,r1=4,r2=2);
        translate([ 68,-46,-10.5]) cylinder4n(h=11,r1=4,r2=2);
        translate([ 81,-46,-10.5]) cylinder4n(h=11,r1=4,r2=2);
      }   
      
  }
      
  upperPos(pSet) {
      
      //Cable holders  
    hull() {
        translate([-81,-33,-0.5]) cylinder4n(h=11,r1=2,r2=4);
        translate([-81,-46,-0.5]) cylinder4n(h=11,r1=2,r2=4);
        translate([ 81,-33,-0.5]) cylinder4n(h=11,r1=2,r2=4);
        translate([ 81,-46,-0.5]) cylinder4n(h=11,r1=2,r2=4);
      }   
    hull() {
        translate([ 68, 28,-0.5]) cylinder4n(h=11,r1=2,r2=4);
        translate([ 81, 28,-0.5]) cylinder4n(h=11,r1=2,r2=4);
        translate([ 68,-46,-0.5]) cylinder4n(h=11,r1=2,r2=4);
        translate([ 81,-46,-0.5]) cylinder4n(h=11,r1=2,r2=4);
      }   
     }
  }

}

