# CaseBuilderLib
Design 3D printed cases for random things!

![Title](Examples/Gauge/howto_title.jpg) 

## How to use this library:

1. **Preparation**
   1. Make a copy of the CaseBuilderLib project template 
      (**CaseBuilderTemplate.scad**).
      The temmplate is intended to be used with the OpenSCAD
      configurator. 

      ![Step 1.1a](Examples/Gauge/howto_step1_1a.jpg) 

      The design of a customized case is done in three stages.
      Start by setting the **`Stage`** variable to **"Model"** 
      (value = 1). 

      ![Step 1.1b](Examples/Gauge/howto_step1_1b.jpg)

2. **Model Stage**
   1. Design a model the parts of your case content as children
      of the **`CaseBuilder()`** module. 
      Construct each part of the content using primitive shapes. 
      Complex shapes will be wrapped in a hull.
      Use exact measures. 
      Slack will be added to the cavities automatically.

      ![Step 2.1](Examples/Gauge/howto_step2_1.jpg) 

   2. Configure the inner dimansions of the case by setting the
      **`IdimX`**, **`IdimY`**, and **`IdimZ`** variables.
      If necessary, adjust the position of the content through the
      **`ObjX`**, **`ObjY`**, and **`ObjZ`** variables.

      ![Step 2.2](Examples/Gauge/howto_step2_2.jpg) 

  3. If needed, add some grip holes by setting the variables
      **`Gh1X`**, **`Gh2X`**, or **`Gh3X`** to a value within the inner 
      X dimension.
      Further grip holes can be added by manually extending the
      **`ghX`** array within the instantiation of the 
      **`CaseBuilder()`** module.

      ![Step 2.3](Examples/Gauge/howto_step2_3.jpg) 

   4. Select a lock option through the **`LockO`** variable.
      Options Are:
      * No lock (**`LockO`** = **0**)
      * Elastic string (**`LockO`** = **1**)
      * Pull Latch  (**`LockO`** = **2**)

      ![Step 2.4](Examples/Gauge/howto_step2_4.jpg) 

   5. Add an optional label to the case by setting the string
      variable **`LabT`**. The font size can be adjusted through
      the variable **`LabS`**.

      ![Step 2.5b](Examples/Gauge/howto_step2_5a.jpg) 

      Continue by setting the **`Stage`** variable to **"Check"** 
      (value = 2). 

      ![Step 2.5b](Examples/Gauge/howto_step2_5b.jpg) 

3. **Check Stage**
   1. Review the design. 
      Make sure to resolve all problems highlighted in red.
      The case can be opened or closed by adjusing the angle in
      the **openA** variable.  
      The upper part of the case can be eclipsed through the 
      **UvisB** variable.
      The lower part of the case can be eclipsed through the 
      **LvisB** variable.

      ![Step 3.1a](Examples/Gauge/howto_step3_1a.jpg) 

       Continue by setting the **Stage** variable to **"Generate"** 
      (value = 3). 
      
      ![Step 3.1b](Examples/Gauge/howto_step3_1b.jpg) 

4. **Generate stage**
   1. Do a final review of the design.
      Use the **OpenA**, **UvisB**, and **LvisB** variables for a
      detailed inspection.

      ![Step 4.1](Examples/Gauge/howto_step4_1.jpg) 

  2. Render the design and generate a [STL file](https://github.com/hotwolf/CaseBuilderLib/blob/master/Examples/Gauge/Gauge.stl).

      ![Step 4.2](Examples/Gauge/howto_step4_2.jpg) 

   3. Slice and print.

      ![Step 4.3](Examples/Gauge/howto_step4_3.jpg)

