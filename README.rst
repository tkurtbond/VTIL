VTIL - VAX Threaded Interpretive Language
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

My undergrad senior project at the tail end of the 1980s was writing a
Forth-inspired Threaded Interpretive Language for VAX/VMS, which I
named VTIL.  I wrote it in VAX MACRO using subroutine threading, and
enjoyed the process immensely.

Eventually I didn't have access to the tape drives necessary to get
the source off tape anymore, and then the tapes disappeared for good.

However, recently printouts of the documentation (the paper I wrote
for my senior project and an incomplete but usable reference manual)
and the source code (on 132 character wide green bar paper; such
nostalgia!) came to light, so now I've typed it all in again,
for posterity.

I'm currently working on fixing all the bugs introduced by typos from
typing VTIL.MAR in again.

**WARNING:** Right now VTIL.MAR is **full** of typos!  It compiles and
runs, but many things don't work.

**WARNING:** This is not Forth!  A lot of words work like words in
Forth, but a lot of them do something completely different.
(``CREATE``, I'm looking at you.)

VTIL-pictures
=============

I had to take pictures of the source code to VTIL.MAR because my eyes
are no longer able to read from the top of a bifold of the wide green
bar paper to the bottom at any sensible distance.  So instead of
looking at two sheets of the wide green bar paper at a time on a desk,
I looked at a picture of one sheet in an image viewer, and was able to
enlarge the picture if necessary to figure out details when the ink on
the paper had faded.  Those pictures are available in a companion
repository for reference:

    https://github.com/tkurtbond/VTIL-pictures

Discussions of the difficulty I had compiling this once I'd gotten it
all typed in:

    https://groups.google.com/g/comp.os.vms/c/we6prnOvzRs/m/uaYgYoYZAwAJ
