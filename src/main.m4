include(common-makefile/src/include_once.m4)
define(_MAKEFILE_AUTHOR, Alejandro Gallo)dnl
define(_MAKEFILE_URL, https://github.com/alejandrogallo/clang-makefile)dnl
include_once(common-makefile/src/version.m4)

## <<HELP
#
#                           CLANG MAKEFILE
#
## HELP

# Local configuration
-include config.mk

include_once(common-makefile/src/os.m4)
include_once(common-makefile/src/shell-utils.m4)
include_once(common-makefile/src/log.m4)

define(
_MAKEFILE_UPDATE_URL,
 https://raw.githubusercontent.com/alejandrogallo/clang-makefile/master/dist/Makefile
)dnl
include_once(common-makefile/src/update.m4)

include_once(common-makefile/src/print-variable.m4)
include_once(common-makefile/src/help.m4)
include_once(common-makefile/src/help-target.m4)

# vim: cc=80
dnl vim: noexpandtab
