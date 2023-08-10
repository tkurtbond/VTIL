MFLAGS=/LIST/CROSS/OBJECT=$(MMS$TARGET_NAME)$(OBJ)/show=expansion
LINKFLAGS=/EXEC=$(MMS$TARGET)/MAP

all : vtil.exe vtil.mem vtil-nopaging.doc

vtil.exe : vtil.obj, vtil_msg.obj
        LINK$(LINKFLAGS)/EXE=$(MMS$TARGET) $(MMS$SOURCE_LIST)

vtil.obj : vtil.mar

vtil-nopaging.mem : vtil.rno
        runoff/variant=nopaging/output=$(MMS$TARGET) $(MMS$SOURCE)

vtil-nopaging.doc : vtil-nopaging.mem
        @stripcrlf $(MMS$SOURCE) $(MMS$TARGET)

clean : 
        del/log *.exe.*,*.obj.*,*.lis.*,*.map.*,*.mem.*,*.doc.*

! Include the *.lis *.map files, because I can't generate them except
! on vms.

zipsrc : 
        today = f$cvtime (,, "DATE")
        set def [-]
        zipfile = "[.project_backups]vtil_" + today + ".zip"
	! It's not really accurate unless we start from scratch.
	if f$search (zipfile) .nes. "" then delete 'zipfile';*/log
	zip -r 'zipfile' vtil.dir -x *.obj *.exe *.hlb

        





