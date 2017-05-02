
# File: common-makefile/src/version.m4
MAKEFILE_VERSION = v0-8-gddce032
MAKEFILE_DATE = 02-05-2017 14:23
MAKEFILE_AUTHOR = Alejandro Gallo
MAKEFILE_URL = https://github.com/alejandrogallo/clang-makefile
MAKEFILE_LICENSE = GPLv3




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

SOURCES ?= $(CFILES) $(CXXFILES) $(FCFILES)

OBJFILES = \
$(shell echo $(SOURCES) | sed "s/\.\S*/.o/g") \

DEPFILES = \
$(shell echo $(SOURCES) | sed "s/\.\S*/.d/g") \

ifneq ($(MAKECMDGOALS), clean)
ifneq ($(MAKECMDGOALS), help)
-include $(DEPFILES)
endif
endif

.DEFAULT_GOAL := $(EXECUTABLE)
all: $(EXECUTABLE)

objs: $(OBJFILES) ## Make object files
deps: $(DEPFILES) ## Make dependencies

$(EXECUTABLE): $(OBJFILES)
	$(ECHO) $(call print-cmd-name,$(EXEC_COMPILER)) $(@)
	$(DBG_FLAG)mkdir -p $(BINDIR)
	$(DBG_FLAG)$(EXEC_COMPILER) $(OBJFILES) -o $@ $(EXEC_FLAGS) $(LD_FLAGS)


# File: common-makefile/src/os.m4
# Recognise OS
ifeq ($(shell uname),Linux)
LINUX := 1
OSX   :=
else
LINUX :=
OSX   := 1
endif




# File: common-makefile/src/shell-utils.m4

# Shell used
SH ?= bash
# Alias for `SHELL'
SHELL ?= $(SH)
# Python interpreter
PY ?= python
# Alias for `PY'
PYTHON ?= $(PY)
# Perl command
PERL ?= perl
# Grep program version
GREP ?= grep
# Find utility
FIND ?= find
# `sed` program version
SED ?= $(if $(OSX),gsed,sed)
# `awk` program to use
AWK ?= $(if $(OSX),gawk,awk)
# For creating tags
CTAGS ?= ctags
# To get complete paths
READLINK ?= $(if $(OSX),greadlink,readlink)
# `xargs` program to use
XARGS ?= xargs
# `tr` program to use
TR ?= tr
# `git` version to use
GIT ?= git
# `which` program to use
WHICH ?= which
# `sort` program to use
SORT ?= sort
# `uniq` program to use
UNIQ ?= uniq
# `Makefile` binary
MAKE ?= $(or $(MAKE),make)
# `rm` command
RM ?= rm
# C++ compiler
CXX ?= g++
# C compiler
CC ?= gcc
# Fortran compiler
FC ?= gfortran



# File: common-makefile/src/log.m4

# If secondary programs output is shown
QUIET ?= 0
# If the log messages should be also muted
QQUIET     ?=
# If the commands issued should be printed write `DEBUG=1` if you want to see
# all commands.
DEBUG      ?=
# For coloring
TPUT       ?= $(shell $(WHICH) tput 2> /dev/null)
# If messages should have color
WITH_COLOR ?= 1

ifneq ($(strip $(QUIET)),0)
FD_OUTPUT = 2>&1 > /dev/null
else
FD_OUTPUT =
endif

ifdef DEBUG
DBG_FLAG =
DBG_FILE ?= .makefile-dbg
$(shell date | $(SED) "p; s/./=/g" > $(DBG_FILE))
else
DBG_FLAG = @
DBG_FILE =
endif

define log-debug
>> $(or $(DBG_FILE),/dev/null) echo
endef

# Print commands like [CMD]
define print-cmd-name
"[$(COLOR_LB) \
$(shell \
	if test "$(1)" = g++; then \
		echo -n GXX; \
	elif test "$(1)" = gcc; then \
		echo -n GCC; \
	elif test "$(1)" = icc; then \
		echo -n ICC; \
	elif test "$(1)" = cc; then \
		echo -n CC; \
	elif test "$(1)" = povray; then \
		echo -n POV; \
	elif test "$(1)" = perl; then \
		echo -n PL; \
	elif test "$(1)" = perl5; then \
		echo -n PL5; \
	elif test "$(1)" = ruby; then \
		echo -n RB; \
	elif test "$(1)" = ruby2; then \
		echo -n RB2; \
	elif test "$(1)" = python; then \
		echo -n PY; \
	elif test "$(1)" = python2; then \
		echo -n PY2; \
	elif test "$(1)" = python3; then \
		echo -n PY3; \
	elif test "$(1)" = pdflatex; then \
		echo -n pdfTeX; \
	elif test "$(1)" = bash; then \
		echo -n BASH; \
	elif test "$(1)" = gnuplot; then \
		echo -n GPT; \
	elif test "$(1)" = mupdf; then \
		echo -n muPDF; \
	else \
		echo -n "$(1)" | tr a-z A-Z ; \
	fi
)\
$(COLOR_E)]"
endef

ifndef QQUIET

ifeq ($(strip $(WITH_COLOR)),1)
# Red
COLOR_R         ?= $(if $(TPUT),$(shell $(TPUT) setaf 1),"\033[0;31m")
# Green
COLOR_G         ?= $(if $(TPUT),$(shell $(TPUT) setaf 2),"\033[0;32m")
# Yellow
COLOR_Y         ?= $(if $(TPUT),$(shell $(TPUT) setaf 3),"\033[0;33m")
# Dark blue
COLOR_DB        ?= $(if $(TPUT),$(shell $(TPUT) setaf 4),"\033[0;34m")
# Lila
COLOR_L         ?= $(if $(TPUT),$(shell $(TPUT) setaf 5),"\033[0;35m")
# Light blue
COLOR_LB        ?= $(if $(TPUT),$(shell $(TPUT) setaf 6),"\033[0;36m")
# Empty color
COLOR_E         ?= $(if $(TPUT),$(shell $(TPUT) sgr0),"\033[0m")
ARROW           ?= @echo "$(COLOR_L)===>$(COLOR_E)"
else
ARROW           ?= @echo "===>"
endif #WITH_COLOR

ECHO            ?= @echo

else
ARROW           := @ > /dev/null echo
ECHO            := @ > /dev/null echo
endif #QQUIET





# File: cxx.m4




CXX_EXTENSIONS ?= cpp C cc cxx CC
define cxx_obj_compile_rule
%.o: %.$(1)
	$$(ECHO) $$(call print-cmd-name,$$(CXX)) $$(@)
	$$(DBG_FLAG)$$(CXX) $$(CXXFLAGS) -c $$< -o $$*.o
endef
define cxx_dep_compile_rule
%.d: %.$(1)
	$$(ECHO) $$(call print-cmd-name,DEP) $$(@)
	$$(DBG_FLAG)$$(CXX) $$(CXXFLAGS) -M -MF $$@ $$<
endef
$(foreach EXT,$(CXX_EXTENSIONS),$(eval $(call cxx_dep_compile_rule,$(EXT))))
$(foreach EXT,$(CXX_EXTENSIONS),$(eval $(call cxx_obj_compile_rule,$(EXT))))




# File: c.m4




C_EXTENSIONS ?= c
define c_obj_compile_rule
%.o: %.$(1)
	$$(ECHO) $$(call print-cmd-name,$$(CC)) $$(@)
	$$(DBG_FLAG)$$(CC) $$(CFLAGS) -c $$< -o $$*.o
endef
define c_dep_compile_rule
%.d: %.$(1)
	$$(ECHO) $$(call print-cmd-name,DEP) $$(@)
	$$(DBG_FLAG)$$(CC) $$(CFLAGS) -M -MF $$@ $$<
endef
$(foreach EXT,$(C_EXTENSIONS),$(eval $(call c_dep_compile_rule,$(EXT))))
$(foreach EXT,$(C_EXTENSIONS),$(eval $(call c_obj_compile_rule,$(EXT))))




# File: fortran.m4




FC_EXTENSIONS ?= F90 f90 F95 f95 F03 f03 F f
define fc_obj_compile_rule
%.o: %.$(1)
	$$(ECHO) $$(call print-cmd-name,$$(FC)) $$(@)
	$$(DBG_FLAG)$$(FC) $$(FCFLAGS) -c $$< -o $$*.o
endef
define fc_dep_compile_rule
%.d: %.$(1)
	$$(ECHO) $$(call print-cmd-name,DEP) $$(@)
	$$(DBG_FLAG)$$(FC) $$(FCFLAGS) -M -MF $$@ $$<
endef
$(foreach EXT,$(FC_EXTENSIONS),$(eval $(call fc_dep_compile_rule,$(EXT))))
$(foreach EXT,$(FC_EXTENSIONS),$(eval $(call fc_obj_compile_rule,$(EXT))))




# File: tags.m4




tags: $(SOURCES) ## Create tags
	$(ECHO) $(call print-cmd-name,$(CTAGS)) $(@)
	$(DBG_FLAG)ctags -R --sort=yes --c++-kinds=+p --fields=+iatS --extra=+q \
		$(SOURCES) $(subst -I,,$(INCLUDE_FLAGS))




# File: common-makefile/src/update.m4


MAKEFILE_UPDATE_URL ?= https://raw.githubusercontent.com/alejandrogallo/clang-makefile/master/dist/Makefile


# ===============================
# Update the makefile from source
# ===============================
#
# You can always get the  latest `Makefile` version using this target.  You may
# override the `MAKEFILE_UPDATE_URL` to  any path where you save your own
# personal makefile
#
update: ## Update the makefile from the repository
	$(ARROW) "Getting makefile from $(MAKEFILE_UPDATE_URL)"
	$(DBG_FLAG)wget $(MAKEFILE_UPDATE_URL) -O Makefile




# File: common-makefile/src/clean.m4


# Remove command flags
RM_FLAGS ?= -rf

# Default clean file to be cleaned
DEFAULT_CLEAN_FILES ?=

# Files to be cleaned
CLEAN_FILES ?= $(DEFAULT_CLEAN_FILES)

# =============
# Main cleaning
# =============
#
# This does a main cleaning of the produced auxiliary files.  Before using it
# check which files are going to be cleaned up.
#
clean: ## Remove build and temporary files
	$(ARROW) Cleaning up...
	$(DBG_FLAG) {\
		for file in $(CLEAN_FILES); do \
			test -e $$file && { \
				$(RM) $(RM_FLAGS) $$file &&      \
				echo $(call print-cmd-name,RM) "$$file";\
		 } || : ; \
		done \
	}




# File: common-makefile/src/print-variable.m4


# This is used for printing defined variables from Some other scripts. For
# instance if you want to know the value of the `PDF_VIEWER` defined in the
# Makefile, then you would do
# ```
#    make print-PDF_VIEWER
# ```
# and this would output `PDF_VIEWER=mupdf` for instance.
FORCE:
print-%:
	$(DBG_FLAG)echo '$*=$($*)'

# =====================================
# Print a variable used by the Makefile
# =====================================
#
# For debugging purposes it is useful to print out some variables that the
# makefile is using, for that just type `make print` and you will be prompted
# to insert the name of the variable that you want to know.
#
FORCE:
print: ## Print a variable
	$(DBG_FLAG)read -p "Variable to print: " variable && \
		$(MAKE) --no-print-directory print-$$variable




# File: common-makefile/src/help.m4



# ================
# Print quick help
# ================
#
# It prints a quick help in the terminal
help: ## Prints help for targets with comments
	$(DBG_FLAG)$(or $(AWK),awk) ' \
		BEGIN {FS = ":.*?## "}; \
		/^## *<<HELP/,/^## *HELP/ { \
			help=$$1; \
			gsub("#","",help); \
			if (! match(help, "HELP")) \
				print help ; \
		}; \
		/^[a-zA-Z0-9_\-.]+:.*?## .*$$/{ \
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 ; \
		};' \
		$(MAKEFILE_LIST)
	@echo ""
	@echo "  $(MAKEFILE_VERSION)"
	@echo "  $(MAKEFILE_URL)"
	@echo "  Copyright $(MAKEFILE_AUTHOR) $(MAKEFILE_LICENSE) $(MAKEFILE_DATE)"
	@echo ""




# File: common-makefile/src/help-target.m4


FORCE:
help-%:
	$(DBG_FLAG)$(SED) -n "/[#] [=]\+/,/^$*: / { /"$*":/{q}; p; } " $(MAKEFILE_LIST) \
		| tac \
		| sed -n "1,/===/ {/===/n; s/^# //p}" \
		| tac \
		| sed -n "p; 1s/./=/gp; 1a\ "




# vim: cc=80
