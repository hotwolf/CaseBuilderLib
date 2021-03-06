//###############################################################################
//# CaseBuilderLib - Gauge Case                                                 #
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
//#    A case for a gauge.                                                      #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   July  9, 2020                                                             #
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
IdimX=70; // [1:200]
//Inner Y dimension
IdimY=55;  // [1:200]
//Inner Y dimension
IdimZ=20;  // [1:200]

//Object offset in X direction
ObjX=0; // [-50:50]
//Object offset in Y direction
ObjY=0;  // [-50:50]
//Object offset in Z direction
ObjZ=-2.5;  // [-50:50]

//First grip hole's X offset
Gh1X=100;    // [-100:100]
//Second grip hole's X offset
Gh2X=-100; // [-100:100]
//Third grip hole's X offset
Gh3X=-100; // [-100:100]

//Lock Option
LockO=2; // [1:Elastic String, 2:Pull Latch]

//Label text
LabT="Thermometer";
//Label size
LabS=8; // [0:40]

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
                  lockO=LockO,           //Lock option   
                  ghX=[Gh1X,Gh2X,Gh3X],  //Grip hole offsets
                  labT=LabT,             //Label text
                  labS=LabS)) {          //Label size

        //Thermometer
        hull() {              
            transrot([30,19,0],   [0,270,0])    cylinder4n(h=60,d=10);
            transrot([30,-19,0],  [0,270,0])    cylinder4n(h=60,d=10);
            transrot([-30,-16,-5],[0,0,0])      cube([60,32,15]);
        }
        transrot([22.5,0,-5.7],[0,0,0])  cylinder4n(h=0.7,d=9);

        //Gauge
//        transrot([11.95,0,-13.3],[0,0,0])  cylinder4n(h=26.3,d=53.5);
//        transrot([11.95,0,4.1],[0,0,0])    cylinder4n(h=8.9,d=58.2);
//        transrot([54,0,-3.5],[0,270,0])    cylinder4n(h=20,d=9);
//        transrot([-34.8,0,-3.5],[0,90,0])  cylinder4n(h=20,d=8);
//        transrot([-48.8,0,-3.5],[0,90,0])  cylinder4n(h=14,d=4.5);
//        transrot([-54,0,-3.5],[0,90,0])    cylinder4n(h=5.2,d1=2,d2=4.5);
}
