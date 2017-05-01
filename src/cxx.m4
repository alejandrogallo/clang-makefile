include_once(common-makefile/src/log.m4)
include_once(common-makefile/src/shell-utils.m4)
dnl
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

dnl vim: noexpandtab
