# This makefile doesn't run on VAX/VMS.  It is only used for tasks done on 
# Unix machines where working with the git repository is done.

all: vtil-paper.pdf

vtil-paper.pdf: vtil-paper.ltx
	latexmk -pdf $<

zipsrc:
	cd .. && \
		zip vtil-unix-$$(date -Idate).zip VTIL \
			$$(find VTIL \( -name .git -o -name .~ \) -prune \
			-o ! \( -name .git\* -o \
				-name \*.mem -o -name \*.doc -o \
				-name \*.out -o -name \*.toc -o -name \*.aux -o \
				-name \*.log -o \
				-name .#\* \
			\) -print)
