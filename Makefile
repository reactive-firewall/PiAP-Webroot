#!/usr/bin/env make -f

# License
#
# Copyright (c) 2017 Mr. Walls
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#


ifeq "$(ECHO)" ""
	ECHO=echo
endif

ifeq "$(LINK)" ""
	LINK=ln -sf
endif

ifeq "$(MAKE)" ""
	MAKE=make
endif

ifeq "$(WAIT)" ""
	WAIT=wait
endif

ifeq "$(INSTALL)" ""
	INSTALL=install
	ifeq "$(INST_OWN)" ""
		INST_OWN=-o root -g staff
	endif
	ifeq "$(INST_OPTS)" ""
		INST_OPTS=-m 755
	endif
endif

ifeq "$(LOG)" ""
	LOG=no
endif

ifeq "$(LOG)" "no"
	QUIET=@
endif

PHONY: must_be_root cleanup

build:
	$(QUIET)$(ECHO) "No need to build. Try make -f Makefile install"

init:
	$(QUIET)$(ECHO) "$@: Done."

install: webroot python-tools must_be_root
	$(QUITE) $(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

uninstall:
	$(QUITE)$(QUIET)python -m pip uninstall piaplib
	$(QUITE) $(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

purge: clean uninstall
	$(QUIET)python -m pip uninstall piaplib
	$(QUIET)$(ECHO) "$@: Done."

test: cleanup
	$(QUIET)php -l webroot/PiAP/index.php
	$(QUIET)php -l webroot/PiAP/pages/index.php
	$(QUIET)php -l webroot/PiAP/pages/functions.php
	$(QUIET)php -l webroot/PiAP/pages/dashboard_functions.php
	$(QUIET)php -l webroot/PiAP/pages/networking.php
	$(QUIET)php -l webroot/PiAP/pages/do_login.php
	$(QUIET)php -l webroot/PiAP/pages/logout.php
	$(QUIET)php -l webroot/PiAP/pages/session.php
	$(QUIET)php -l webroot/PiAP/pages/lan_setup.php
	$(QUIET)php -l webroot/PiAP/pages/wan_setup.php
	$(QUIET)php -l webroot/PiAP/pages/do_wan_setup.php
	$(QUIET)php -l webroot/PiAP/pages/do_lan_setup.php
	$(QUIET)php -l webroot/PiAP/pages/paranoia.php
	$(QUIET)php -l webroot/PiAP/pages/do_reboot.php
	$(QUIET)php -l webroot/PiAP/pages/power_off.php
	$(QUIET)php -l webroot/PiAP/pages/PiAP-config.php
	$(QUIET)php -l webroot/PiAP/pages/PiAP-lan-setup.php
	$(QUIET)php -l webroot/PiAP/pages/PiAP-wan-setup.php
	$(QUIET)php -l webroot/PiAP/pages/error.php
	$(QUIET)$(ECHO) "$@: Done."

test-tox: cleanup
	$(QUIET)tox --
	$(QUIET)$(ECHO) "$@: Done."

cleanup:
	$(QUIET)rm -f webroot/PiAP/pages/*~ 2>/dev/null || true
	$(QUIET)rm -f webroot/PiAP/*~ 2>/dev/null || true
	$(QUIET)rm -f webroot/PiAP/cache/* 2>/dev/null || true
	$(QUIET)rm -f ./*~ 2>/dev/null || true
	$(QUIET)rm -f webroot/PiAP/bin/*.pyc 2>/dev/null || true
	$(QUIET)rm -f webroot/*.pyc 2>/dev/null || true
	$(QUIET)rm -f *.DS_Store 2>/dev/null || true
	$(QUIET)rm -f webroot/*.DS_Store 2>/dev/null || true
	$(QUIET)rm -f webroot/*/*.DS_Store 2>/dev/null || true
	$(QUIET)rm -Rf ./.tox/ 2>/dev/null || true

clean: cleanup
	$(QUIET)$(MAKE) -s -C ./docs/ -f Makefile clean 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

python-tools:
	$(QUIET)python -m pip install "git+https://github.com/reactive-firewall/PiAP-python-tools.git"

must_be_root:
	runner=`whoami` ; \
	if test $$runner != "root" ; then echo "You are not root." ; exit 1 ; fi

%:
	$(QUIET)$(ECHO) "No Rule Found For $@" ; $(WAIT) ;

