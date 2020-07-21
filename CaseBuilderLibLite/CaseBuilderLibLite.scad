//###############################################################################
//# CaseBuilderLib - CaseBuilderLibLite                                         #
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
//#    This is a simplified version of the CaseBuilderLib, which aims to be     #
//#    compatible to the Thingiverse configurator.                              #
//#    The BaseBuilderLibLite only supports the generation of empty cases       #
//#    (shell). The design of customized cavities is not supported.             #
//#    All relevant includes of the CaseBuilderLib have been concatinated into  #
//#    one source file.                                                         #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   July 22, 2020                                                             #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

/* [Design Options] */
//Inner X dimension
IdimX=70; // [1:200]
//Inner Y dimension
IdimY=30;  // [1:200]
//Inner Y dimension
IdimZ=20;  // [1:200]

//Label text
LabT="Optional label";
//Label size
LabS=8; // [0:40]

//###############################################################################
//# CaseBuilderLib - Default values and common functions                        #
//###############################################################################
//Empty shape
module dummy() {}

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
defLockO  =    2;     //Lock option
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

//###############################################################################
//# CaseBuilderLib - Hinge                                                      #
//###############################################################################
//Global functions
//================
//Hinge offset
function hoffX(pSet) = pSet[idxGapW];

//Check for indivisible hinge
function is_indivHinge(pSet) = true;

//Positive lower hinge start segment
module lowerHStartPos(pSet,$fn=24) {
    //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = (hsegW-gapW*sq2)/2; //Height of the cylinder shape
    cylR   = hsegD/2;            //Radius of the cylinder shape

    hull() {
        sphere4n(r=cylR);
        rotate([0,90,0])            cylinder4n(h=cylH,r=cylR);
        translate([0,gapW,-2*cylR]) cube([cylH,cylR-gapW,2*cylR]);
    }
    translate([cylH,0,0]) rotate([0,90,0]) cylinder4n(h=cylR,r1=cylR,r2=0);
}

//Negative lower hinge start segment
module lowerHStartNeg(pSet,$fn=24 ) {
    //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = (hsegW+gapW*sq2)/2; //Height of the cylinder shape
    cylR   = gapW+hsegD/2;       //Radius of the cylinder shape
    conR   = hsegD/2;            //Radius of the cone shape

    rotate([180,0,0]) {
        hull() {
            sphere4n(r=cylR);
            rotate([0,90,0])            cylinder4n(h=cylH,r=cylR);
            translate([0,gapW,-2*cylR]) cube([cylH,cylR-gapW,2*cylR]);
        }
        translate([cylH,0,0]) rotate([0,90,0]) cylinder4n(h=conR,r1=conR,r2=0);
    }
}

//Positive lower hinge end segment
module lowerHEndPos(pSet,$fn=24) {
    //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = (hsegW-gapW*sq2)/2; //Height of the cylinder shape
    cylR   = hsegD/2;            //Radius of the cylinder shape

    hull() {
        sphere4n(r=cylR);
        rotate([0,270,0])               cylinder4n(h=cylH,r=cylR);
        translate([-cylH,gapW,-2*cylR]) cube([cylH,cylR-gapW,2*cylR]);
    }
    translate([-cylH,0,0]) rotate([0,270,0]) cylinder4n(h=cylR,r1=cylR,r2=0);
}

//Negative lower hinge end segment
module lowerHEndNeg(pSet,$fn=24) {
    //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = (hsegW+gapW*sq2)/2; //Height of the cylinder shape
    cylR   = gapW+hsegD/2;       //Radius of the cylinder shape
    conR   = hsegD/2;            //Radius of the cone shape

    rotate([180,0,0]) {
        hull() {
            sphere4n(r=cylR);
            rotate([0,270,0])               cylinder4n(h=cylH,r=cylR);
            translate([-cylH,gapW,-2*cylR]) cube([cylH,cylR-gapW,2*cylR]);
        }
        translate([-cylH,0,0]) rotate([0,270,0]) cylinder4n(h=conR,r1=conR,r2=0);
    }
}

//Positive upper hinge end segment
module upperHEndPos(pSet,$fn=24) {
    //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = (hsegW-gapW*sq2)/2; //Height of the cylinder shape
    cylR   = hsegD/2;            //Radius of the cylinder shape

    difference() {
        hull() {
            sphere4n(r=cylR);
            rotate([0,270,0])         cylinder4n(h=cylH,r=cylR);
            translate([-cylH,gapW,0]) cube([cylH,cylR-gapW,2*cylR]);
        }
        translate([-cylH,0,0]) rotate([0,90,0]) cylinder4n(h=cylR,r1=cylR,r2=0);
    }
}

//Negative upper hinge end segment
module upperHEndNeg(pSet,$fn=24) {
    //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = (hsegW+gapW*sq2)/2; //Height of the cylinder shape
    cylR   = gapW+hsegD/2;       //Radius of the cylinder shape
    conR   = hsegD/2;            //Radius of the cone shape

    rotate([180,0,0]) {
        hull() {
            sphere4n(r=cylR);
            rotate([0,270,0])         cylinder4n(h=cylH,r=cylR);
            translate([-cylH,gapW,0]) cube([cylH,cylR-gapW,2*cylR]);
        }
    }
}

//Positive lower hinge segment
module lowerHSegPos(pSet,$fn=24) {
     //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = hsegW-gapW*sq2;     //Height of the cylinder shape
    cylR   = hsegD/2;            //Radius of the cylinder shape

    hull() {
        translate([-cylH/2,0,0]) rotate([0,90,0]) cylinder4n(h=cylH,r=cylR);
        translate([-cylH/2,gapW,-2*cylR])         cube([cylH,cylR-gapW,2*cylR]);
    }
    translate([cylH/2,0,0])  rotate([0,90,0])  cylinder4n(h=cylR,r1=cylR,r2=0);
    translate([-cylH/2,0,0]) rotate([0,270,0]) cylinder4n(h=cylR,r1=cylR,r2=0);
}

//Negative lower hinge segment
module lowerHSegNeg(pSet,$fn=24) {
    //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = hsegW+gapW*sq2;     //Height of the cylinder shape
    cylR   = gapW+hsegD/2;       //Radius of the cylinder shape
    conR   = hsegD/2;            //Radius of the cone shape

    rotate([180,0,0]) {
        hull() {
            translate([-cylH/2,0,0]) rotate([0,90,0]) cylinder4n(h=cylH,r=cylR);
            translate([-cylH/2,gapW,-2*cylR])         cube([cylH,cylR-gapW,2*cylR]);
        }
        translate([cylH/2,0,0]) rotate([0,90,0])   cylinder4n(h=conR,r1=conR,r2=0);
        translate([-cylH/2,0,0]) rotate([0,270,0]) cylinder4n(h=conR,r1=conR,r2=0);
    }
}

//Positive upper hinge segment
module upperHSegPos(pSet,$fn=24) {
    //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = hsegW-gapW*sq2;     //Height of the cylinder shape
    cylR   = hsegD/2;            //Radius of the cylinder shape

    difference() {
        hull() {
            translate([cylH/2,0,0]) rotate([0,270,0])         cylinder4n(h=cylH,r=cylR);
            translate([-cylH/2,gapW,0]) cube([cylH,cylR-gapW,2*cylR]);
        }
        union() {
            translate([-cylH/2,0,0]) rotate([0,90,0])  cylinder4n(h=cylR,r1=cylR,r2=0);
            translate([cylH/2,0,0])  rotate([0,270,0]) cylinder4n(h=cylR,r1=cylR,r2=0);

        }
    }
}

//Negative upper hinge segment
module upperHSegNeg(pSet,$fn=24) {
    //Short cuts
    wallW  = pSet[idxWallW];     //Wall thickness
    gapW   = pSet[idxGapW];      //Gap between moving parts
    hsegW  = pSet[idxHSegW];     //Length of a hinge segment
    hsegD  = pSet[idxHSegD];     //Diameter of a hinge segment
    sq2    = sqrt(2);            //Square root of 2
    cylH   = hsegW+gapW*sq2;     //Height of the cylinder shape
    cylR   = gapW+hsegD/2;       //Radius of the cylinder shape
    conR   = hsegD/2;            //Radius of the cone shape

    rotate([180,0,0]) {
        hull() {
            translate([cylH/2,0,0]) rotate([0,270,0]) cylinder4n(h=cylH,r=cylR);
            translate([-cylH/2,gapW,0])               cube([cylH,cylR-gapW,2*cylR]);
        }
    }
}

//Dummy hinge segment
module dummyHSeg(pSet) {
//    cube(center=true);
}

//Hinge assembly
//children(0): Start segment
//children(1): Odd segment
//children(2): Even segment
//children(3): Odd end segment
//children(4): Even end segment
module hingeAssembly(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    hsegW  = pSet[idxHSegW];  //Length of a hinge segment
    hsegD  = pSet[idxHSegD];  //Diameter of a hinge segment

    //Hinge alignment
    hsegCnt = floor((idimX-2*wallW)/hsegW); //Number of hinge segments (end pieces count as half)
    hdimX   = hsegW*hsegCnt;                //X-dimension of the hinge (without end piece spheres)

    //Start segment
    translate([-hdimX/2,0,0]) children(0);

    //End segment
    translate([hdimX/2,0,0])
    if (is_even(hsegCnt)) children(4);
    else                  children(3);

    //Inner segments
    for (idx=[1:hsegCnt-1])
        translate([(idx*hsegW)-hdimX/2,0,0])
        if (is_even(idx)) children(2);
        else              children(1);

}

//Positive lower hinge
module lowerHingePos(pSet) {
    hingeAssembly(pSet) {
        lowerHStartPos(pSet); //children(0): Start segment
        dummyHSeg(pSet);      //children(1): Odd segment
        lowerHSegPos(pSet);   //children(2): Even segment
        dummyHSeg(pSet);      //children(3): Odd end segment
        lowerHEndPos(pSet);   //children(4): Even end segment
    }
}

//Negative lower hinge
module lowerHingeNeg(pSet) {
    hingeAssembly(pSet) {
        dummyHSeg(pSet);      //children(0): Start segment
        upperHSegNeg(pSet);   //children(1): Odd segment
        dummyHSeg(pSet);      //children(2): Even segment
        upperHEndNeg(pSet);   //children(3): Odd end segment
        dummyHSeg(pSet);      //children(4): Even end segment
    }
}

//Positive upper hinge
module upperHingePos(pSet) {
    hingeAssembly(pSet) {
        dummyHSeg(pSet);      //children(0): Start segment
        upperHSegPos(pSet);   //children(1): Odd segment
        dummyHSeg(pSet);      //children(2): Even segment
        upperHEndPos(pSet);   //children(3): Odd end segment
        dummyHSeg(pSet);      //children(4): Even end segment
    }
}

//Negative upper hinge
module upperHingeNeg(pSet) {
    hingeAssembly(pSet) {
        lowerHStartNeg(pSet); //children(0): Start segment
        dummyHSeg(pSet);      //children(1): Odd segment
        lowerHSegNeg(pSet);   //children(2): Even segment
        dummyHSeg(pSet);      //children(3): Odd end segment
        lowerHEndNeg(pSet);   //children(4): Even end segment
    }
}

//Attach lower hinge
module attachLowerHinge(pSet) {
    //Short cuts
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts

    difference() {
        children(0);
        translate([0,gapW+wallW+idimY/2,0]) rotate([0,0,180]) lowerHingeNeg(pSet);
    }
    translate([0,gapW+wallW+idimY/2,0]) rotate([0,0,180]) lowerHingePos(pSet);
}

//Attach upper hinge
module attachUpperHinge(pSet) {
    //Short cuts
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts

    difference() {
        children(0);
        translate([0,gapW+wallW+idimY/2,0]) rotate([0,0,180]) upperHingeNeg(pSet);
    }
    translate([0,gapW+wallW+idimY/2,0]) rotate([0,0,180]) upperHingePos(pSet);
}

//###############################################################################
//# CaseBuilderLib - Lock                                                       #
//###############################################################################
//Local parameters
//================
//Lock option 1: Elastic string
stringD = 3; //Diameter of the elasic string
knotD   = 5; //Diameter of the knot
knotOff = 2; //Knot offset

//Positive lower lock parts
module lowerLockPos(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    lockO  = pSet[idxLockO];  //Lock option
}

//Negative lower lock parts
module lowerLockNeg(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    lockO  = pSet[idxLockO];  //Lock option

    //Elastic string option
    if (lockO==1) {
        translate([-idimX/2,-idimY/2+knotD/2+knotOff,-idimZ/2])         rotate([90,0,0])   torus4n(d1=knotD,d2=knotD,angle=90,$fn=12);
        translate([-idimX/2+knotD/2,-idimY/2+knotD/2+knotOff,-idimZ/2]) rotate([180,0,0])  cylinder4n(h=wallW+1,d=knotD,$fn=12);
        translate([-idimX/2,-idimY/2+knotD/2+knotOff,-idimZ/2+knotD/2]) rotate([0,270,0])  cylinder4n(h=wallW+1,d=stringD,$fn=12);

        translate([idimX/2,-idimY/2+knotD/2+knotOff,-idimZ/2])          rotate([90,0,180]) torus4n(d1=knotD,d2=knotD,angle=90,$fn=12);
        translate([idimX/2-knotD/2,-idimY/2+knotD/2+knotOff,-idimZ/2])  rotate([180,0,0])  cylinder4n(h=wallW+1,d=knotD,$fn=12);
        translate([idimX/2,-idimY/2+knotD/2+knotOff,-idimZ/2+knotD/2])  rotate([0,90,0])  cylinder4n(h=wallW+1,d=stringD,$fn=12);
    }

    //Pull latch option
    if (lockO==2) {
        intersection() {
            hull() {
                translate([-15-gapW,-10-idimY/2,-8])         cube([30+2*gapW,10,4]);
                translate([-25-gapW,-10-idimY/2,-4+idimZ/2]) cube([50+2*gapW,10,4]);
            }
            union() {
                hull() {
                    translate([-idimX/2,-2-idimY/2,-4]) rotate([0,90,0]) cylinder4n(h=idimX,d=3);
                    translate([-idimX/2,-2-idimY/2,-6]) rotate([0,90,0]) cylinder4n(h=idimX,d=3);
                }
                translate([-idimX/2,-2-wallW-idimY/2,-7.5]) cube([idimX,wallW,5]);
                hull() {
                    translate([-idimX/2,-2-wallW-idimY/2,-2.5]) cube([idimX,wallW,4]);
                    translate([-idimX/2,-1-wallW-idimY/2,])    cube([idimX,wallW,2]);
                }
            }
        }
    }

    //Push latch option
     if (lockO==3) {



    }

}

//Positive upper lock parts
module upperLockPos(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    lockO  = pSet[idxLockO];  //Lock option

    //Pull latch option
    if (lockO==2) {
        intersection() {
            hull() {
               translate([-15,-10-idimY/2,-8]) cube([30,10,4]);
               translate([-25,-10-idimY/2,-4+idimZ/2]) cube([50,10,4]);
            }
            union() {
                translate([-idimX/2,-2-idimY/2,-4]) rotate([0,90,0]) cylinder4n(h=idimX,d=3);
                translate([-idimX/2,-2.75-idimY/2,-5.5]) rotate([0,90,0]) cylinder4n(h=idimX,d=1.5);
                translate([-idimX/2,-3.5-idimY/2,-5.5]) cube([idimX,1.5,idimZ/2]);
                hull() {
                    translate([-idimX/2,-3.5-idimY/2,-6+idimZ/2])   cube([idimX,1.5,2]);
                    translate([-idimX/2,-wallW-idimY/2,-2+idimZ/2]) cube([idimX,wallW,2]);
                }
            }
        }
    }
}

//Negative upper lock parts
module upperLockNeg(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    lockO  = pSet[idxLockO];  //Lock option

    //Pull latch option
    if (lockO==2) {
        intersection() {
            hull() {
                translate([-15-gapW,-10-idimY/2,-8])         cube([30+2*gapW,10,4]);
                translate([-25-gapW,-10-idimY/2,-4+idimZ/2]) cube([50+2*gapW,10,4]);
            }
            translate([-idimX/2,2*gapW-2-wallW-idimY/2,-1]) cube([idimX,wallW,-4+idimZ/2]);
        }
    }
}

//Attach lower lock
module attachLowerLock(pSet) {
    lowerLockPos(pSet);
    difference() {
        children();
        lowerLockNeg(pSet);
    }
}

//Attach upper lock
module attachUpperLock(pSet) {
    upperLockPos(pSet);
    difference() {
        children();
        upperLockNeg(pSet);
    }
}

//Space, taken up by the lock
module lockSpace(pSet) {
   lowerLockPos(pSet);
   lowerLockNeg(pSet);
   upperLockPos(pSet);
   upperLockNeg(pSet);
}

//###############################################################################
//# CaseBuilderLib - Label                                                      #
//###############################################################################
//Flat label
module flatLabel(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    labT   = pSet[idxLabT];   //Label text
    labS   = pSet[idxLabS];   //Label size

    //Label
    translate([0,0,wallW+idimZ/2]) text(text=labT,size=labS,halign="center",valign="center");
}

//Engrave label into top shell
module engraveLabel(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    labT   = pSet[idxLabT];   //Label text
    labS   = pSet[idxLabS];   //Label size

    //Engrave
    difference() {
        children();
        translate([0,0,wallW-0.4+idimZ/2]) linear_extrude(0.8) text(text=labT,size=labS,halign="center",valign="center");
    }
}

//###############################################################################
//# CaseBuilderLib - Shell                                                      #
//###############################################################################
//Shell shape
//===========
module shellShape(pSet) {
    //Short cuts
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts


    difference() {
        hull() {
            translate([idimX/2,idimY/2,-idimZ/2])   cylinder4n(h=idimZ/2,r=wallW);
            translate([idimX/2,idimY/2,-idimZ/2])   hemisphere4n(r=wallW,shs=true);

            translate([idimX/2,-idimY/2,-idimZ/2])  cylinder4n(h=idimZ/2,r=wallW);
            translate([idimX/2,-idimY/2,-idimZ/2])  hemisphere4n(r=wallW,shs=true);

            translate([-idimX/2,idimY/2,-idimZ/2])  cylinder4n(h=idimZ/2,r=wallW);
            translate([-idimX/2,idimY/2,-idimZ/2])  hemisphere4n(r=wallW,shs=true);

            translate([-idimX/2,-idimY/2,-idimZ/2]) cylinder4n(h=idimZ/2,r=wallW);
            translate([-idimX/2,-idimY/2,-idimZ/2]) hemisphere4n(r=wallW,shs=true);
        }
        cube([idimX,idimY,idimZ],center=true);
    }
}

//Lower shell
//===========
module lowerShell(pSet) {
    //Shell shape
    attachLowerHinge(pSet)
    attachLowerLock(pSet)
    shellShape(pSet);
}

//Upper shell
//===========
module upperShell(pSet) {
    //Shell shape
    engraveLabel(pSet)
    attachUpperHinge(pSet)
    attachUpperLock(pSet)
    rotate([180,0,0]) shellShape(pSet);
}

//###############################################################################
//# CaseBuilderLib - Main                                                       #
//###############################################################################

//Main builder module
module CaseBuilder(pSet) {
    //Short cuts
    stage  = pSet[idxStage];  //Design stage
    openA  = pSet[idxOpenA];  //Opening angle
    uvisB  = pSet[idxUvisB];  //Show upper part
    lvisB  = pSet[idxLvisB];  //Show lower part
    idimX  = pSet[idxIdimX];  //Inner X dimension
    idimY  = pSet[idxIdimY];  //Inner Y dimension
    idimZ  = pSet[idxIdimZ];  //Inner Z dimension
    wallW  = pSet[idxWallW];  //Wall thickness
    gapW   = pSet[idxGapW];   //Gap between moving parts
    hsegW  = pSet[idxHSegW];  //Length of a hinge segment
    hsegD  = pSet[idxHSegD];  //Diameter of a hinge segment
    slackX = pSet[idxSlackX]; //Object's slack in X direction
    slackY = pSet[idxSlackY]; //Object's slack in Y direction
    slackZ = pSet[idxSlackZ]; //Object's slack in Z direction
    inlZ   = pSet[idxInlZ];   //Inlay offset in Z direction
    objX   = pSet[idxObjX];   //Object offset in X direction
    objY   = pSet[idxObjY];   //Object offset in Y direction
    objZ   = pSet[idxObjZ];   //Object offset in Z direction
    hingeO = pSet[defHingeO]; //Hinge option
    lockO  = pSet[idxLockO];  //Lock option
    ghX    = pSet[idxGhX];    //Grip hole positions
    ghW    = pSet[idxGhW];    //Grip hole width
    labT   = pSet[idxLabT];   //Label text
    labS   = pSet[idxLabS];   //Label size

    //Generate scase
    //==============
   //Lower part
    lowerPos(pSet) {

        //Draw shell
        color(filC)
        lowerShell(pSet);
    }

   //Upper part
    upperPos(pSet) {

        //Draw shell
        color(filC)
        upperShell(pSet);
    }
}

CaseBuilder(pSet(idimX=IdimX,            //Inner X dimension
                 idimY=IdimY,            //Inner X dimension
                 idimZ=IdimZ,            //Inner X dimension
                  labT=LabT,             //Label text
                  labS=LabS));           //Label size
