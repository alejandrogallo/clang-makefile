include_once(common-makefile/src/log.m4)
include_once(common-makefile/src/shell-utils.m4)
dnl
tags: $(SOURCES) ## Create tags
	$(ECHO) $(call print-cmd-name,$(CTAGS)) $(@)
	$(DBG_FLAG)ctags -R --sort=yes --c++-kinds=+p --fields=+iatS --extra=+q \
		$(SOURCES) $(subst -I,,$(INCLUDE_FLAGS))
