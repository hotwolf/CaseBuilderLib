//###############################################################################
//# CaseBuilderLib - Hinge                                                      #
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
//#   A fully printed hinge.                                                    #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   June 29, 2020                                                             #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

include <CaseBuilderLib_Common.scad>

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

//Preview
if ($preview) {

    //Hinge segments   
//    color("green") lowerHStartPos(pSet());
//    #color("red")  lowerHStartNeg(pSet());
//    color("green") lowerHEndPos(pSet());
//    #color("red")  lowerHEndNeg(pSet());
//    color("green") upperHEndPos(pSet());
//    #color("red")  upperHEndNeg(pSet());
//    color("green") lowerHSegPos(pSet());
//    #color("red")  lowerHSegNeg(pSet());
//    color("green") upperHSegPos(pSet());
//    #color("red")  upperHSegNeg(pSet());
//    color("green") lowerHingePos(pSet());
//    #color("red")  lowerHingeNeg(pSet());
//    color("green") upperHingePos(pSet());
//    #color("red")  upperHingeNeg(pSet());

    attachLowerHinge(pSet()) {
        //Short cuts
        pSet   = pSet();
        idimX  = pSet[idxIdimX];  //Inner X dimension        
        idimY  = pSet[idxIdimY];  //Inner Y dimension        
        wallW  = pSet[idxWallW];  //Wall thickness
        gapW   = pSet[idxGapW];   //Gap between moving parts
        translate([-idimX/2,-20+wallW+idimY/2,-20]) cube([idimX,20,20]);
    }
    
    attachUpperHinge(pSet()) {
        //Short cuts
        pSet   = pSet();
        idimX  = pSet[idxIdimX];  //Inner X dimension        
        idimY  = pSet[idxIdimY];  //Inner Y dimension        
        wallW  = pSet[idxWallW];  //Wall thickness
        gapW   = pSet[idxGapW];   //Gap between moving parts
        translate([-idimX/2,-20+wallW+idimY/2,0]) cube([idimX,20,20]);
    }
}