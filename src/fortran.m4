include_once(common-makefile/src/log.m4)
include_once(common-makefile/src/shell-utils.m4)
dnl
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

dnl vim: noexpandtab
