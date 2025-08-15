//###############################################################################
//# CaseBuilderLib - Label                                                      #
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
//#   A label for the case                                                      #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   July 1, 2020                                                              #
//#      - Initial release                                                      #
//#   February 16, 2025                                                         #
//#      - Supports multiple lines of text
//###############################################################################

include <CaseBuilderLib_Common.scad>

//Common calculations for label positioning
function getBaseZ(pSet) = 
    let(
        idimZ = pSet[idxIdimZ],
        wallW = pSet[idxWallW]
    )
    wallW + idimZ/2;

//Sum an array - replacement for missing OpenSCAD sum function
function sumArray(arr, i=0) = 
    i >= len(arr) ? 0 : arr[i] + sumArray(arr, i+1);

//Calculate gap between adjacent lines based on their font sizes
function getLineGap(size1, size2, spacing=1.2) = 
    (size1 + size2)/2 * spacing;

//Calculate total offset for a given line by accumulating all previous gaps
function getLineOffset(fontSizes, lineIndex, spacing=1.2) = 
    let(
        numLines = len(fontSizes),
        halfHeight = lineIndex == 0 ? 0 :
            [for(i = [0:lineIndex-1])
                getLineGap(fontSizes[i], fontSizes[i+1], spacing)]
    )
    lineIndex == 0 ? 0 : sumArray(halfHeight);

//Convert single text to single-element array
function normalizeTextToArray(value) = 
    is_string(value) ? [value] : value;

//Convert single size to array matching text length
function normalizeSizeToArray(size, textArray) = 
    is_list(size) ? size :  // If it's already a list, return as is
    [for(i = [0:len(textArray)-1]) size];  // Otherwise create array of same size

//Flat label
module flatLabel(pSet) {
    //Short cuts and normalization
    labT   = normalizeTextToArray(pSet[idxLabT]);       //Label text array
    labS   = normalizeSizeToArray(pSet[idxLabS], labT); //Label size array
    baseZ  = getBaseZ(pSet);
    
    numLines = len(labT);
    totalHeight = getLineOffset(labS, numLines-1);
    
    rotate([0,0,pSet[idxIdimX]<pSet[idxIdimY] ? 270 : 0])
    for(i = [0:numLines-1]) {
        offset = totalHeight/2 - getLineOffset(labS, i);
        translate([0, offset, baseZ]) 
            text(text=labT[i], size=labS[i], halign="center", valign="center");
    }
}

//Engrave label into top shell
module engraveLabel(pSet) {
    //Short cuts and normalization
    labT   = normalizeTextToArray(pSet[idxLabT]);       //Label text array
    labS   = normalizeSizeToArray(pSet[idxLabS], labT); //Label size array
    baseZ  = getBaseZ(pSet) - 0.4;                      //Apply offset for engraving
    
    numLines = len(labT);
    totalHeight = getLineOffset(labS, numLines-1);
    
    difference() {
        children();
        
        rotate([0,0,pSet[idxIdimX]<pSet[idxIdimY] ? 270 : 0])
        for(i = [0:numLines-1]) {
            offset = totalHeight/2 - getLineOffset(labS, i);
            translate([0, offset, baseZ]) 
                linear_extrude(0.8) 
                text(text=labT[i], size=labS[i], halign="center", valign="center");
        }
    }
}
