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
//#    1. Preparation                                                           #
//#       1. Make a copy of the CaseBuilderLib project template.                #
//#          The temmplate is intended to be used with the OpenSCAD             #
//#          configurator.                                                      #
//#          The design of a customized case is done in three stages.           #
//#          Start by setting the `Stage` variable to "Model"                   #
//#          (value = 1).                                                       #
//#                                                                             #
//#    2. Model Stage                                                           #
//#       1. Design a model the parts of your case content as children          #
//#          of the `CaseBuilder()` module.                                     #
//#          Construct each part of the content using primitive shapes.         #
//#          Complex shapes will be wrapped in a hull.                          #
//#          Use exact measures.                                                #
//#          Slack will be added to the cavities automatically.                 #
//#                                                                             #
//#       2. Configure the inner dimansions of the case by setting the          #
//#          `IdimX`, `IdimY`, and `IdimZ` variables.                           #
//#          If necessary, adjust the position of the content through the       #
//#          `ObjX`, `ObjY`, and `ObjZ` variables.                              #
//#                                                                             #
//#       3. If needed, add some grip holes by setting the variables            #
//#          `Gh1X`, `Gh2X`, or `Gh3X` to a value within the inner              #
//#          X dimension.                                                       #
//#          Further grip holes can be added by manually extending the          #
//#          `ghX` array within the instantiation of the                        #
//#          `CaseBuilder()` module.                                            #
//#                                                                             #
//#       4. Select a lock option through the `LockO` variable.                 #
//#          Options Are:                                                       #
//#          * No lock        (`LockO` = 0)                                     #
//#          * Elastic string (`LockO` = 1)                                     #
//#          * Pull Latch     (`LockO` = 2)                                     #
//#                                                                             #
//#       5. Add an optional label to the case by setting the string            #
//#          variable `LabT`. The font size can be adjusted through             #
//#          the variable `LabS`.                                               #
//#                                                                             #
//#          Continue by setting the `Stage` variable to "Check"                #
//#          (value = 2).                                                       #
//#                                                                             #
//#    3. Check Stage                                                           #
//#       1. Review the design.                                                 #
//#          Make sure to resolve all problems highlighted in red.              #
//#          The case can be opened or closed by adjusing the angle in          #
//#          the openA variable.                                                #
//#          The upper part of the case can be eclipsed through the             #
//#          UvisB variable.                                                    #
//#          The lower part of the case can be eclipsed through the             #
//#          LvisB variable.                                                    #
//#           Continue by setting the Stage variable to "Generate"              #
//#          (value = 3).                                                       #
//#                                                                             #
//#    4. Generate Stage                                                        #
//#       1. Do a final review of the design.                                   #
//#          Use the OpenA, UvisB, and LvisB variables for a                    #
//#          detailed inspection.                                               #
//#                                                                             #
//#       2. Render the design and generate a STL file                          #
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

//Lock Option
LockO=1; // [1:Elastic String, 2:Pull Latch]

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
                  lockO=LockO,           //Hinge option
                  ghX=[Gh1X,Gh2X,Gh3X],  //Grip hole offsets
                  labT=LabT,             //Label text
                  labS=LabS)) {          //Label size

        //!!! Your model goes here !!!
        translate([0,0,-12.5]) cylinder(25,d1=30,d2=0);

}
