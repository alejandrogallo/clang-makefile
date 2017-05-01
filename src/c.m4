include_once(common-makefile/src/log.m4)
include_once(common-makefile/src/shell-utils.m4)
dnl
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

dnl vim: noexpandtab
