MSGFLAGS=/LIST/OBJECT=$(MMS$TARGET_NAME)$(OBJ)
! /SHOW=EXPANSION can be useful in MFLAGS
MFLAGS=/DEBUG/LIST/CROSS/OBJECT=$(MMS$TARGET_NAME)$(OBJ)
LINKFLAGS=/DEBUG/MAP/FULL

all : vtil.exe vtil.mem vtil-nopaging.doc

vtil.exe : vtil.obj, vtil_msg.obj
        LINK$(LINKFLAGS)/EXE=$(MMS$TARGET) $(MMS$SOURCE_LIST)

vtil.obj : vtil.mar

vtil-nopaging.mem : vtil.rno
        runoff/variant=nopaging/output=$(MMS$TARGET) $(MMS$SOURCE)

vtil-nopaging.doc : vtil-nopaging.mem
        @stripcrlf $(MMS$SOURCE) $(MMS$TARGET)

clean : codeclean docclean

codeclean : 
        del/log *.exe.*,*.obj.*,*.lis.*,*.map.*

docclean : 
        del/log *.mem.*,*.doc.*

! Include the *.LIS *.MAP files, because I can't generate them except
! on vms.
! But exclude the *.EXE and *.PDF files.  The later can't be built
! on my VMS system, and the this target is for zipping up the source
! so I can put in in github using a Unix box.
zipsrc : 
        today = f$cvtime (,, "DATE")
        set def [-]
        zipfile = "[.project_backups]vtil_" + today + ".zip"
	! It's not really accurate unless we start from scratch.
	if f$search (zipfile) .nes. "" then delete 'zipfile';*/log
	zip -r 'zipfile' vtil.dir -x *.obj *.exe *.hlb *.pdf

        





