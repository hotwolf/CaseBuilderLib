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

/* [Stage] */
//Design stage
Stage=1; // [1:Model, 2:Check, 3:Generate]

/* [Dimensions] */
//Inner X dimension
IdimX=100; // [1:200]
//Inner Y dimension
IdimY=50;  // [1:200]
//Inner Y dimension
IdimZ=30;  // [1:200]

/* [Grip Holes] */
//First grip hole's X offset
Gh1X=0;    // [-100:100]
//Second grip hole's X offset
Gh2X=-100; // [-100:100]
//Third grip hole's X offset
Gh3X=-100; // [-100:100]

/* [Label] */
//Label text
LabT="";
//Label size
LabS=-100; // [0:64]

CaseBuilder(pSet(stage=Stage,                //Design stage  
                 idimX=IdimX,                //Inner X dimension
                 idimY=IdimY,                //Inner X dimension
                 idimZ=IdimZ,                //Inner X dimension
                 ghX  = [Gh1X,Gh2X,Gh3X])) { //Grip hole offsets

        //!!! Model the content of the case here !!!
//        union() {
        translate([0,10,-12.5]) cylinder(25,d1=30,d2=0);     
        translate([0,-10,-12.5]) cylinder(25,d1=0,d2=30);     
//        }

}
