VTIL tests
@@@@@@@@@@

These are VTIL scripts run on the VAX/VMS system (the SIMH VAX at
192.168.2.20, account ``vtil``) to find typos and bugs in VTIL.MAR.
Each line ends with a ``\`` comment giving the expected output.

The tools in ``../tools`` read the account's login and password from
``~/.netrc-vtil-vax`` (or ``$VAX_NETRC``) and never put the password on
a command line or print it:

``tools/vax-build``
    Copies VTIL.MAR and VTIL_MSG.MSG to the VAX, assembles and links
    VTIL.EXE there.

``tools/vtil-test tests/<name>.vtil...``
    Runs VTIL interactively over telnet, sends each line of each
    script, and writes the session to ``tests/<name>.out`` (not kept in
    git).  ``VTIL_IMAGE=VTILT`` runs another image instead.

``tools/vax-put``, ``tools/vax-get``
    Copy files to and from the account by FTP, in ASCII mode.

``expect -f tools/vax-dcl.exp '<command>'...``
    Runs DCL commands there and prints their output.

Some scripts need setup on the VAX first:

* ``blocks.vtil`` needs VTILBLOCKS.DAT: copy and build
  MAKE-VTILBLOCKS.MAR there and run it.
* ``load.vtil`` needs ``loadme.vtil`` and ``loadbad.vtil`` copied there
  with ``tools/vax-put``.
* ``trap.vtil`` and ``ctrlc.vtil`` test the condition handler and the
  Control/C trap, which the 1988 listing assembled but the current
  VTIL.MAR leaves out.  Copy ``vtilca.mar`` there and build that
  version as VTILT::

      MACRO/OBJECT=VTILT VTILCA+VTIL
      LINK/EXE=VTILT VTILT,VTIL_MSG

  then run them with ``VTIL_IMAGE=VTILT``.
