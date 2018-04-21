#!/usr/bin/env make -f

# License
#
# Copyright (c) 2017-2018 Mr. Walls
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
		INST_OWN=-C -o pocket-admin -g pocket-www
	endif
	ifeq "$(INST_OPTS)" ""
		INST_OPTS=-m 750
	endif
	ifeq "$(INST_FILE_OPTS)" ""
		INST_FILE_OPS=-m 640
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

.SUFFIXES: .zip .php .css .html .bash .sh .py .pyc .txt

PHONY: must_be_root cleanup

build:
	$(QUIET)$(ECHO) "No need to build. Try make -f Makefile install"

init:
	$(QUIET)$(ECHO) "$@: Done."

install: install-webroot install-scripts install-styles install-pages install-cgi install-images python-tools must_be_root
	$(QUITE) $(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

install-webroot: webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/
	$(QUIET)$(ECHO) "$@: Done."

install-cgi: install-webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/bin
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/client_status.bash /srv/PiAP/bin/client_status.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/compile_interface /srv/PiAP/bin/compile_interface
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/disk_status_table.bash /srv/PiAP/bin/disk_status_table.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/do_scan_the_air.bash /srv/PiAP/bin/do_scan_the_air.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/do_updatePiAP.bash /srv/PiAP/bin/do_updatePiAP.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/do_updateWiFi.bash /srv/PiAP/bin/do_updateWiFi.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/fw_status.bash /srv/PiAP/bin/fw_status.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/fw_status_table.bash /srv/PiAP/bin/fw_status_table.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/interface_AP_heal.bash /srv/PiAP/bin/interface_AP_heal.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/interface_list.bash /srv/PiAP/bin/interface_list.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/interface_PHY_sleep.bash /srv/PiAP/bin/interface_PHY_sleep.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/interface_status.bash /srv/PiAP/bin/interface_status.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/memory_status_table.bash /srv/PiAP/bin/memory_status_table.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/power_off.bash /srv/PiAP/bin/power_off.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/reboot.bash /srv/PiAP/bin/reboot.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/saltify.bash /srv/PiAP/bin/saltify.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/saltify.py /srv/PiAP/bin/saltify.py
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/scan_that_air.bash /srv/PiAP/bin/scan_that_air.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/scan_the_air.bash /srv/PiAP/bin/scan_the_air.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/service_AP_heal.bash /srv/PiAP/bin/service_AP_heal.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/temperature_status.bash /srv/PiAP/bin/temperature_status.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/updatePiAP.bash /srv/PiAP/bin/updatePiAP.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/updateWiFi.bash /srv/PiAP/bin/updateWiFi.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/user_list.bash /srv/PiAP/bin/user_list.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/user_status.bash /srv/PiAP/bin/user_status.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/user_status_table.bash /srv/PiAP/bin/user_status_table.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/write_wpa_config.bash /srv/PiAP/bin/write_wpa_config.bash
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_OPTS) ./webroot/PiAP/bin/generate_user_x509.bash /srv/PiAP/bin/generate_user_x509.bash
	$(QUIET)$(ECHO) "$@: Done."

uninstall-cgi: must_be_root
	$(QUIET)$(RMDIR) /srv/PiAP/bin 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/client_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/client_status.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/compile_interface 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/disk_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/do_scan_the_air.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/do_updatePiAP.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/do_updateWiFi.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/fw_status.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/fw_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/interface_AP_heal.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/interface_list.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/interface_PHY_sleep.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/interface_status.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/memory_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/power_off.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/reboot.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/saltify.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/saltify.py 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/saltify.pyc 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/scan_that_air.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/scan_the_air.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/service_AP_heal.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/temperature_status.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/updatePiAP.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/updateWiFi.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/user_list.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/user_status.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/user_status_table.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/write_wpa_config.bash 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/bin/generate_user_x509.bash 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/PiAP/bin 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

install-scripts: install-webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/scripts
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/scripts/hashing.js /srv/PiAP/scripts/hashing.js
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/scripts/sha512.js /srv/PiAP/scripts/sha512.js
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/files
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/files/text
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/files/text/sha512.js.LICENSE /srv/PiAP/files/text/sha512.js.LICENSE
	$(QUIET)$(ECHO) "$@: Done."

uninstall-scripts: must_be_root
	$(QUIET)$(RM) /srv/PiAP/scripts/hashing.js 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/scripts/sha512.js 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/PiAP/scripts 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/PiAP/files/text 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/PiAP/files/text/sha512.js.LICENSE 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

install-styles: install-webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/styles
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/styles/main.css /srv/PiAP/styles/main.css
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/styles/grid.css /srv/PiAP/styles/grid.css
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/styles/sign_in.css /srv/PiAP/styles/sign_in.css
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/styles/form_config.css /srv/PiAP/styles/form_config.css
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/styles/loaders.min.css /srv/PiAP/styles/loaders.min.css
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/files || true
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/files/text || true
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/files/text/loader.min.css.LICENSE /srv/PiAP/files/text/loader.min.css.LICENSE || true
	$(QUIET)$(ECHO) "$@: Done."

uninstall-styles: must_be_root
	$(QUIET)$(RM) /srv/PiAP/styles/main.css 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/styles/grid.css 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/styles/sign_in.css 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/styles/form_config.css 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/styles/loaders.min.css 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/files/text/loader.min.css.LICENSE 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/PiAP/styles 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

uninstall-pages: must_be_root
	$(QUIET)$(RM) /srv/PiAP/pages/index.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/functions.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/dashboard_functions.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/dashboard.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/networking.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/do_login.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/logview.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/logout.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/landing.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/menu_functions.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/scanning.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/wan_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/lan_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/session.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/do_wan_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/do_lan_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/paranoia.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/do_reboot.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/power_off.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/PiAP-config.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/PiAP-lan-setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/PiAP-wan-setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/error.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/profile.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/do_auth_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/do_legacy_auth_setup.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/download_x509.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/updates.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/do_piaplib_update.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/PiAP-updates.php 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/pages/scanning.php 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/PiAP/pages/ 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

install-pages: install-webroot must_be_root /srv/PiAP/pages/PiAP-updates.php /srv/PiAP/pages/do_piaplib_update.php /srv/PiAP/index.php /srv/PiAP/pages/functions.php /srv/PiAP/pages/dashboard.php /srv/PiAP/pages/dashboard_functions.php /srv/PiAP/pages/networking.php /srv/PiAP/pages/do_login.php /srv/PiAP/pages/logview.php /srv/PiAP/pages/logout.php /srv/PiAP/pages/landing.php /srv/PiAP/pages/wan_setup.php /srv/PiAP/pages/lan_setup.php /srv/PiAP/pages/session.php /srv/PiAP/pages/menu_functions.php /srv/PiAP/pages/scanning.php /srv/PiAP/pages/do_wan_setup.php /srv/PiAP/pages/do_lan_setup.php /srv/PiAP/pages/paranoia.php /srv/PiAP/pages/do_reboot.php /srv/PiAP/pages/power_off.php /srv/PiAP/pages/PiAP-config.php /srv/PiAP/pages/PiAP-lan-setup.php /srv/PiAP/pages/PiAP-wan-setup.php /srv/PiAP/pages/error.php /srv/PiAP/pages/profile.php /srv/PiAP/pages/do_auth_setup.php /srv/PiAP/pages/download_x509.php /srv/PiAP/pages/updates.php
	$(QUIET)$(ECHO) "$@: Done."

/srv/PiAP/pages/%.php: ./webroot/PiAP/pages/%.php install-webroot must_be_root /srv/PiAP/pages/
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) $< $@
	$(QUIET)$(ECHO) "$@: installed."

/srv/PiAP/index.php: ./webroot/PiAP/index.php install-webroot must_be_root /srv/PiAP/pages/
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/index.php /srv/PiAP/index.php

/srv/PiAP/pages/: must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/pages/

install-images: install-webroot must_be_root
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_DIR_OPTS) /srv/PiAP/images
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/images/logo.svg /srv/PiAP/images/logo.svg
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/images/logo.png /srv/PiAP/images/logo.png
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/images/logo.ico /srv/PiAP/images/logo.ico
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/images/logo.ico /srv/PiAP/logo.ico
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/images/logo_bright.svg /srv/PiAP/images/logo_bright.svg
	$(QUIET)$(INSTALL) $(INST_OWN) $(INST_FILE_OPTS) ./webroot/PiAP/images/transparent.gif /srv/PiAP/images/transparent.gif
	$(QUIET)$(ECHO) "$@: Done."

uninstall-images: must_be_root
	$(QUIET)$(RM) /srv/PiAP/logo.ico 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/faveicon.ico 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/images/favicon.ico 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/images/logo.svg 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/images/logo.png 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/images/logo_bright.svg 2>/dev/null || true
	$(QUIET)$(RM) /srv/PiAP/images/transparent.gif 2>/dev/null || true
	$(QUIET)$(RMDIR) /srv/PiAP/images 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

uninstall: uninstall-cgi uninstall-pages uninstall-scripts uninstall-styles uninstall-images
	$(QUITE)$(QUIET)python3 -m pip uninstall -y piaplib 2>/dev/null || true
	$(QUITE) $(WAIT)
	$(QUIET)$(ECHO) "$@: Done."

purge: clean uninstall
	$(QUIET)python3 -m pip uninstall -y piaplib 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

test: cleanup test-extras
	$(QUIET)php -l webroot/PiAP/index.php
	$(QUIET)php -l webroot/PiAP/pages/index.php
	$(QUIET)php -l webroot/PiAP/pages/dashboard.php
	$(QUIET)php -l webroot/PiAP/pages/functions.php
	$(QUIET)php -l webroot/PiAP/pages/dashboard_functions.php
	$(QUIET)php -l webroot/PiAP/pages/menu_functions.php
	$(QUIET)php -l webroot/PiAP/pages/networking.php
	$(QUIET)php -l webroot/PiAP/pages/do_login.php
	$(QUIET)php -l webroot/PiAP/pages/logout.php
	$(QUIET)php -l webroot/PiAP/pages/landing.php
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
	$(QUIET)php -l webroot/PiAP/pages/do_auth_setup.php
	$(QUIET)php -l webroot/PiAP/pages/download_x509.php
	$(QUIET)php -l webroot/PiAP/pages/PiAP-updates.php
	$(QUIET)php -l webroot/PiAP/pages/scanning.php
	$(QUIET)php -l webroot/PiAP/pages/logview.php
	$(QUIET)$(ECHO) "$@: Done."

test-extras: cleanup
	$(QUIET)flake8 --ignore=W191,W391 --max-line-length=100 --count webroot/PiAP/bin/saltify.py || true
	$(QUIET)$(ECHO) "$@: Done."

test-tox: cleanup
	$(QUIET)tox flake
	$(QUIET)$(ECHO) "$@: Done."

cleanup:
	$(QUIET)$(RM) webroot/PiAP/pages/*~ 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/styles/*~ 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/scripts/*~ 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/files/*~ 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/cache/*~ 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/bin/*~ 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/bin/*.pyc 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/*~ 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/**/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) webroot/**/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) webroot/.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) .DS_Store 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/cache/* 2>/dev/null || true
	$(QUIET)$(RM) ./*~ 2>/dev/null || true
	$(QUIET)$(RM) webroot/PiAP/bin/*.pyc 2>/dev/null || true
	$(QUIET)$(RM) webroot/*.pyc 2>/dev/null || true
	$(QUIET)$(RM) *.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) webroot/*.DS_Store 2>/dev/null || true
	$(QUIET)$(RM) webroot/*/*.DS_Store 2>/dev/null || true
	$(QUIET)$(RMDIR) ./.tox/ 2>/dev/null || true

clean: cleanup
	$(QUIET)$(MAKE) -s -C ./docs/ -f Makefile clean 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

python-tools:
	$(QUIET)$(ECHO) "$@: Upgrading python tools."
	$(QUIET)python3 -m pip install --upgrade "git+https://github.com/reactive-firewall/PiAP-python-tools.git@stable#egg=piaplib" 2>/dev/null || true
	$(QUIET)python -m pip install --upgrade "git+https://github.com/reactive-firewall/PiAP-python-tools.git@stable#egg=piaplib" 2>/dev/null || true
	$(QUIET)$(ECHO) "$@: Done."

must_be_root:
	runner=`whoami` ; \
	if test $$runner != "root" ; then echo "You are not root." ; exit 1 ; fi

%:
	$(QUIET)$(ECHO) "No Rule Found For $@" ; $(WAIT) ;

