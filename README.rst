PiAP-Webroot beta
=================

This is still in beta. Not production ready. DO NOT USE YET.

.. image:: https://travis-ci.org/reactive-firewall/PiAP-Webroot.svg?branch=master
    :target: https://travis-ci.org/reactive-firewall/PiAP-Webroot

Pocket PiAP
...........
Copyright (c) 2017, Kendrick Walls

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Known Issues
------------

PS-0 - CWE-655 - User on-boarding MUST be easyer
PS-1 - CWE-779 - logs cause data leak
PS-2 - CWE-16 - Configuration hardening
PS-3 - CWE-100 & CWE-149 - passwords with special charterers are courupted by input form
PS-4 - CWE-654 - need MFA
PS-5 - CWE-565 - need to harden cookies for surviving hostile environments
PS-6 - CWE-310 - Need to enable proper TLS and encryption everywhere
PS-7 - CWE-770 - need anti-brute force logic

CWE-657 - see above

Possible Improvements:
---------------------
- clean up code
- test test and more testing
- add encryption and file signing
- add more examples to docs
