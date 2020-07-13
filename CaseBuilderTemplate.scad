//###############################################################################
//# CaseBuilderLib - Project Template                                           #
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
//#    This is a template for a new case design.                                #
//#                                                                             #
//###############################################################################
//# How to use this template:                                                   #
//#                                                                             #
//#    0. Prepare                                                               #
//#       0.0 Create a copy of this file for every new case design.             #
//#                                                                             #
//#    1. Model                                                                 #
//#       1.0 Set the $stage variable to design.                                #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//#    2. Check                                                                 #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//#    3. Generate                                                              #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   June 30, 2020                                                             #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib.scad>

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
IdimY=30;  // [1:200]
//Inner Y dimension
IdimZ=30;  // [1:200]

//Object offset in X direction
ObjX=0; // [-50:50]
//Object offset in Y direction
ObjY=0;  // [-50:50]
//Object offset in Z direction
ObjZ=0;  // [-50:50]

//First grip hole's X offset
Gh1X=0;    // [-100:100]
//Second grip hole's X offset
Gh2X=-100; // [-100:100]
//Third grip hole's X offset
Gh3X=-100; // [-100:100]

//Hinge Option
HingeO=1; // [1:Single Print, 2:Separable]

//Lock Option
LockO=1; // [1:Elastic String, 2:Pull Latch, 3: Push Latch]

//Label text
LabT="Optional label";
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
                hingeO=HingeO,           //Hinge option        
                 lockO=LockO,            //Lock option   
                   ghX=[Gh1X,Gh2X,Gh3X], //Grip hole offsets
                  labT=LabT,             //Label text
                  labS=LabS)) {          //Label size
 
        //!!! Your model goes here !!!
        //translate([0,0,12.5]) cylinder(25,d1=30,d2=0);
        translate([-20,-15,-15]) cube([10,10,10],center=true);
        translate([0,0,0])     cube([10,10,10],center=true);
        translate([20,15,15])   cube([10,10,10],center=true);

}