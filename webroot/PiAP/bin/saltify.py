#! /usr/bin/env python3
# -*- coding: utf-8 -*-

# Pocket PiAP-keyring-saltify stub
# ..................................
# Copyright (c) 2017-2019, Kendrick Walls
# ..................................
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# ..........................................
# http://www.apache.org/licenses/LICENSE-2.0
# ..........................................
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

try:
	import piaplib
	if piaplib.__name__ is None:
		raise ImportError("Failed to import saltify from piaplib.")
	from piaplib import keyring as keyring
	if keyring.__name__ is None:
		raise ImportError("Failed to import saltify from piaplib.")
	from keyring import saltify as saltify
	if saltify.__name__ is None:
		raise ImportError("Failed to import saltify from piaplib.")
except Exception:
	raise ImportError("Failed to import saltify from piaplib.")
	exit(255)


def main(argv=None):
	"""The main event"""
	# print("PiAP Keyring")
	try:
		try:
			saltify.main(argv)
		except Exception as cerr:
			print(str(cerr))
			print(str(cerr.args))
			print(str(" UNKNOWN - An error occured while handling the arguments. Command failure."))
			exit(3)
	except Exception:
		print(str(" UNKNOWN - An error occured while handling the failure. Cascading failure."))
		exit(3)
	exit(0)


if __name__ in u'__main__':
	try:
		import sys
		if sys.__name__ is None:
			raise ImportError(
				"The system seems to be suffering from a sudden and total exsistance failure"
			)
	except Exception:
		raise ImportError(
			"The system seems to be suffering from a sudden and total exsistance failure"
		)
		exit(255)
	try:
		main(sys.argv[1:])
	except Exception:
		print(str(" UNKNOWN - An error occured while handling the failure. Catastrophic failure."))
		exit(3)
