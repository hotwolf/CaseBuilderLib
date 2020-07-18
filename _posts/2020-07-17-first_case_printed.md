---
layout: post
title:  First case printed
---

The first case has been printed. 

![Open case]({{ site.url }}/images/2020-07-17-case_open.jpg)

The hinge works very well.

![Hinge]({{ site.url }}/images/2020-07-17-hinge.jpg)

And the latch also turned out pretty good at the first attempt.

![Lock]({{ site.url }}/images/2020-07-17-lock.jpg)

However the cavities turned out strange.
One side has a strange stringy surface and on the bottom of the other
side, there is only a thin membrane over some hollow space.

![Strings]({{ site.url }}/images/2020-07-17-strings.jpg)

As it turns out, this strange slizing result was caused by a bug in
the library. It created a 0.5mm gap between the inlay and the shell.

![Design bug]({{ site.url }}/images/2020-07-17-desughn_fault.jpg)

I'm amazed that my printer actually managed to print this.
The bug is now fixed and I think the CaseBuilderLib is ready for its
first release.
