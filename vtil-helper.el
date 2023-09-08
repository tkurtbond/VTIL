;;; vtil-helper.el -- Helper functions for editing VTIl.RNO.

(defvar tkb-right-justify-end 79
  "Column to right align things upto.")

(defun tkb-right-justify ()
  "Justify whatever is in front of point so it's last character is just before
`tkb-right-justify-end', which lines things up with their right ends on the 
right margin."
  (interactive)
  (let ((d (save-excursion
	     (end-of-line)
	     (- tkb-right-justify-end (current-column)))))
    (save-excursion
      (if (> d 0)
	  (insert-char ? d)))))
(global-set-key "\C-ce" 'tkb-right-justify)

(defvar tkb-vtil-text-width 66
  "With of the body text in VTIL.RNO.")

(defun tkb-vtil-header (name stack)
  "Insert a header for an entry for a VTIL word in VTIL.RNO.
Prompt for NAME and STACK and insert a line with NAME on the left and STACK
on the right, right aligned with `tkb-vtil-text-width', and preceeded and 
followed by RUNOFF commands to ensure no filling is done and there are an 
appropriate number of blank lines before and after."
  (interactive "sName: \nsStack: ")
  (let ((stack (concat "( " stack " )")))
    (insert ".SKIP 2\n.NF\n")
    ;; Put an Accept flag (_) at beginning to escape errant dots.
    (insert "_" name)
    (indent-to (- (+ tkb-vtil-text-width 1)                ; allow for accept character
                  (length stack)) 1)
    (insert stack "\n")
    (insert ".FILL\n")
    (insert ".SKIP 1\n")))
(global-set-key "\C-ch" 'tkb-vtil-header)

(defun tkb-vtil-begin-code ()
  (interactive)
  (insert ".BL\n.NF\n.LM +5\n.LT\n"))
(global-set-key "\C-cV" 'tkb-vtil-begin-code)
(defun tkb-vtil-end-code ()
  (interactive)
  (insert ".EL\n.LM -5\n.BL\n"))
(global-set-key "\C-cv" 'tkb-vtil-end-code)

