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

ifeq "$(RM)" ""
	RM=rm -f
endif

ifeq "$(RMDIR)" ""
	RMDIR=$(RM)R
endif

ifeq "$(INSTALL)" ""
	INSTALL=`which install`
	ifeq "$(INST_OWN)" ""
		INST_OWN=-C -o root -g www-data
	endif
	ifeq "$(INST_OPTS)" ""
		INST_OPTS=-m 750
	endif
	ifeq "$(INST_FILE_OPTS)" ""
		INST_OPTS=-m 640
	endif
	ifeq "$(INST_DIR_OPTS)" ""
		INST_DIR_OPTS=-m 750 -d
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

install: install-webroot install-scripts install-styles install-pages install-cgi python-tools must_be_root
	$(QUITE) $(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

install-webroot: webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/webroot/PiAP/
	$(QUIET)$(ECHO) "$@: Done."

install-cgi: install-webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/webroot/PiAP/bin
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/client_status_table.bash /srv/webroot/PiAP/bin/client_status_table.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/compile_interface /srv/webroot/PiAP/bin/compile_interface
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/disk_status_table.bash /srv/webroot/PiAP/bin/disk_status_table.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/do_scan_the_air.bash /srv/webroot/PiAP/bin/do_scan_the_air.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/do_updatePiAP.bash /srv/webroot/PiAP/bin/do_updatePiAP.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/do_updateWiFi.bash /srv/webroot/PiAP/bin/do_updateWiFi.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/fw_status.bash /srv/webroot/PiAP/bin/fw_status.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/fw_status_table.bash /srv/webroot/PiAP/bin/fw_status_table.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/interface_AP_heal.bash /srv/webroot/PiAP/bin/interface_AP_heal.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/interface_list.bash /srv/webroot/PiAP/bin/interface_list.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/interface_PHY_sleep.bash /srv/webroot/PiAP/bin/interface_PHY_sleep.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/interface_status.bash /srv/webroot/PiAP/bin/interface_status.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/memory_status_table.bash /srv/webroot/PiAP/bin/memory_status_table.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/power_off.bash /srv/webroot/PiAP/bin/power_off.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/reboot.bash /srv/webroot/PiAP/bin/reboot.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/saltify.bash /srv/webroot/PiAP/bin/saltify.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/saltify.py /srv/webroot/PiAP/bin/saltify.py
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/scan_that_air.bash /srv/webroot/PiAP/bin/scan_that_air.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/scan_the_air.bash /srv/webroot/PiAP/bin/scan_the_air.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/service_AP_heal.bash /srv/webroot/PiAP/bin/service_AP_heal.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/temperature_status.bash /srv/webroot/PiAP/bin/temperature_status.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/updatePiAP.bash /srv/webroot/PiAP/bin/updatePiAP.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/updateWiFi.bash /srv/webroot/PiAP/bin/updateWiFi.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/user_list.bash /srv/webroot/PiAP/bin/user_list.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/user_status.bash /srv/webroot/PiAP/bin/user_status.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/user_status_table.bash /srv/webroot/PiAP/bin/user_status_table.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/write_wpa_config.bash /srv/webroot/PiAP/bin/write_wpa_config.bash
	$(QUIET)$(ECHO) "$@: Done."

uninstall-cgi: must_be_root
	$(QUIET)$(RMDIR) /srv/webroot/PiAP/bin 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/client_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/compile_interface 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/disk_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/do_scan_the_air.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/do_updatePiAP.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/do_updateWiFi.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/fw_status.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/fw_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/interface_AP_heal.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/interface_list.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/interface_PHY_sleep.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/interface_status.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/memory_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/power_off.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/reboot.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/saltify.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/saltify.py 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/saltify.pyc 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/scan_that_air.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/scan_the_air.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/service_AP_heal.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/temperature_status.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/updatePiAP.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/updateWiFi.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/user_list.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/user_status.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/user_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/bin/write_wpa_config.bash 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/webroot/PiAP/bin 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

install-scripts: install-webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/webroot/PiAP/scripts
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/scripts/hashing.js /srv/webroot/PiAP/scripts/hashing.js
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/scripts/sha512.js /srv/webroot/PiAP/scripts/sha512.js
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/webroot/PiAP/files
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/webroot/PiAP/files/text
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/files/text/sha512.js.LICENSE /srv/webroot/PiAP/files/text/sha512.js.LICENSE
	$(QUIET)$(ECHO) "$@: Done."

uninstall-scripts: must_be_root
	$(QUIET)$(RM) /srv/webroot/PiAP/scripts/hashing.js 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/scripts/sha512.js 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/webroot/PiAP/scripts 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/webroot/PiAP/files/text 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/webroot/PiAP/files/text/sha512.js.LICENSE 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

install-styles: install-webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/webroot/PiAP/styles
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/styles/main.css /srv/webroot/PiAP/styles/main.css
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/styles/grid.css /srv/webroot/PiAP/styles/grid.css
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/styles/sign_in.css /srv/webroot/PiAP/styles/sign_in.css
	$(QUIET)$(ECHO) "$@: Done."

uninstall-styles: must_be_root
	$(QUIET)$(RM) /srv/webroot/PiAP/styles/main.css 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/styles/grid.css 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/styles/sign_in.css 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/webroot/PiAP/styles 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

uninstall-pages: install-webroot must_be_root
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/index.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/functions.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/dashboard_functions.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/networking.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/do_login.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/logout.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/wan_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/lan_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/session.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/do_wan_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/do_lan_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/paranoia.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/do_reboot.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/power_off.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/PiAP-config.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/PiAP-lan-setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/PiAP-wan-setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/error.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/profile.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/updates.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/do_piaplib_update.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/webroot/PiAP/pages/PiAP-updates.php 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/webroot/PiAP/pages/ 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

install-pages: install-webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/index.php /srv/webroot/PiAP/index.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/webroot/PiAP/pages/
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/index.php /srv/webroot/PiAP/pages/index.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/functions.php /srv/webroot/PiAP/pages/functions.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/dashboard_functions.php /srv/webroot/PiAP/pages/dashboard_functions.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/networking.php /srv/webroot/PiAP/pages/networking.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/do_login.php /srv/webroot/PiAP/pages/do_login.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/logout.php /srv/webroot/PiAP/pages/logout.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/wan_setup.php /srv/webroot/PiAP/pages/wan_setup.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/lan_setup.php /srv/webroot/PiAP/pages/lan_setup.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/session.php /srv/webroot/PiAP/pages/session.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/do_wan_setup.php /srv/webroot/PiAP/pages/do_wan_setup.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/do_lan_setup.php /srv/webroot/PiAP/pages/do_lan_setup.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/paranoia.php /srv/webroot/PiAP/pages/paranoia.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/do_reboot.php /srv/webroot/PiAP/pages/do_reboot.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/power_off.php /srv/webroot/PiAP/pages/power_off.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/PiAP-config.php /srv/webroot/PiAP/pages/PiAP-config.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/PiAP-lan-setup.php /srv/webroot/PiAP/pages/PiAP-lan-setup.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/PiAP-wan-setup.php /srv/webroot/PiAP/pages/PiAP-wan-setup.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/error.php /srv/webroot/PiAP/pages/error.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/profile.php /srv/webroot/PiAP/pages/profile.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/updates.php /srv/webroot/PiAP/pages/updates.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/do_piaplib_update.php /srv/webroot/PiAP/pages/do_piaplib_update.php
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/pages/PiAP-updates.php /srv/webroot/PiAP/pages/PiAP-updates.php
	$(QUIET)$(ECHO) "$@: Done."

uninstall: uninstall-cgi uninstall-pages uninstall-scripts uninstall-styles
	$(QUITE)$(QUIET)python3 -m pip uninstall -y piaplib
	$(QUITE) $(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

purge: clean uninstall
	$(QUIET)python3 -m pip uninstall piaplib
	$(QUIET)$(ECHO) "$@: Done."

test: cleanup test-extras
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
	$(QUIET)php -l webroot/PiAP/pages/profile.php
	$(QUIET)php -l webroot/PiAP/pages/updates.php
	$(QUIET)php -l webroot/PiAP/pages/do_piaplib_update.php
	$(QUIET)php -l webroot/PiAP/pages/PiAP-updates.php
	$(QUIET)$(ECHO) "$@: Done."

test-extras:
	$(QUIET)flake8 --ignore=W191,W391 --max-line-length=100 --count webroot/PiAP/bin/saltify.py || true
	$(QUIET)$(ECHO) "$@: Done."
	
test-tox: cleanup
	$(QUIET)tox flake
	$(QUIET)$(ECHO) "$@: Done."

cleanup:
	$(QUIET)rm -f webroot/PiAP/pages/*~ 2>/dev/null || true
	$(QUIET)rm -f webroot/PiAP/styles/*~ 2>/dev/null || true
	$(QUIET)rm -f webroot/PiAP/scripts/*~ 2>/dev/null || true
	$(QUIET)rm -f webroot/PiAP/files/*~ 2>/dev/null || true
	$(QUIET)rm -f webroot/PiAP/cache/*~ 2>/dev/null || true
	$(QUIET)rm -f webroot/PiAP/bin/*~ 2>/dev/null || true
	$(QUIET)rm -f webroot/PiAP/bin/*.pyc 2>/dev/null || true
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
	$(QUIET)python3 -m pip install --upgrade "git+https://github.com/reactive-firewall/PiAP-python-tools.git"

must_be_root:
	runner=`whoami` ; \
	if test $$runner != "root" ; then echo "You are not root." ; exit 1 ; fi

%:
	$(QUIET)$(ECHO) "No Rule Found For $@" ; $(WAIT) ;

