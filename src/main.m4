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

VERSION ?= \"0.0.0\"
BINDIR ?= bin
SRCDIR ?= src
EXECUTABLE ?= $(BINDIR)/main
EXEC_COMPILER ?= $(CXX)
EXEC_FLAGS ?= $(CXXFLAGS)

CLEAN_FILES ?= \
$(wildcard $(OBJFILES)) \
$(wildcard $(DEPFILES)) \
$(wildcard $(EXECUTABLE)) \
$(wildcard $(BINDIR)) \

SOURCES = $(CFILES) $(CXXFILES)

OBJFILES = \
$(shell echo $(SOURCES) | sed "s/\.\S*/.o/g") \

DEPFILES = \
$(shell echo $(SOURCES) | sed "s/\.\S*/.d/g") \

ifneq ($(MAKECMDGOALS), clean)
-include $(DEPFILES)
endif

.DEFAULT_GOAL := $(EXECUTABLE)
all: $(EXECUTABLE)

objs: $(OBJFILES) ## Make object files
deps: $(DEPFILES) ## Make dependencies

$(EXECUTABLE): $(OBJFILES)
	$(ECHO) $(call print-cmd-name,$(EXEC_COMPILER)) $(@)
	$(DBG_FLAG)mkdir -p $(BINDIR)
	$(DBG_FLAG)$(EXEC_COMPILER) $(OBJFILES) -o $@ $(EXEC_FLAGS) $(LD_FLAGS)


include_once(common-makefile/src/os.m4)
include_once(common-makefile/src/shell-utils.m4)
include_once(common-makefile/src/log.m4)

include_once(cxx.m4)
include_once(c.m4)
include_once(tags.m4)

define(
_MAKEFILE_UPDATE_URL,
 https://raw.githubusercontent.com/alejandrogallo/clang-makefile/master/dist/Makefile
)dnl
include_once(common-makefile/src/update.m4)
include_once(common-makefile/src/clean.m4)
include_once(common-makefile/src/print-variable.m4)
include_once(common-makefile/src/help.m4)
include_once(common-makefile/src/help-target.m4)
# vim: cc=80
dnl vim: noexpandtab
