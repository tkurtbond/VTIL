all : vtil.mem vtil-nopaging.doc

vtil-nopaging.mem : vtil.rno
        runoff/variant=nopaging/output=$(MMS$TARGET) $(MMS$SOURCE)

vtil-nopaging.doc : vtil-nopaging.mem
        @stripcrlf $(MMS$SOURCE) $(MMS$TARGET)

clean : 
        del/log *.exe.*,*.obj.*,*.lis.*,*.map.*

zipsrc : 
        today = f$cvtime (,, "DATE")
        set def [-]
        zipfile = "[.project_backups]vtil_" + today + ".zip"
	! It's not really accurate unless we start from scratch.
	if f$search (zipfile) .nes. "" then delete 'zipfile';*/log
	zip -r 'zipfile' vtil.dir -x *.obj *.exe *.hlb *.lis *.map 

        
