include BuildSystem/AWSInit.mk
ifeq (1, $(INCLUDE_GUARD))

# ============================================================================

include BuildSystem/SharedOrStaticLibConfiguration.mk
include boost/libs/system/Project/BoostSystem.mk

# ============================================================================

define boost_filesystem_v2
$(call MBS-ERROR,Boost.Filesystem Version 2 is deprecated$(COMMA) and is not included in Boost releases 1.48 and later.)
endef

define boost_filesystem_v3
endef

# Version 2 was the default version for Boost release 1.44 and 1.45.
# Version 3 is the default starting with release 1.46.
$(call AddConfiguration,boost_filesystem_v3/boost_filesystem_v2)

# ============================================================================

LAYER := BoostFileSystem
LAYER_DIRECTORY := boost/libs/filesystem

# ============================================================================

PRECOMPILED_HEADERS_SOURCE :=

SOURCES := $(addprefix src/,\
	codecvt_error_category.cpp\
	operations.cpp\
	path_traits.cpp\
	path.cpp\
	portability.cpp\
	unique_path.cpp\
	utf8_codecvt_facet.cpp\
	windows_file_codecvt.cpp\
)

# ============================================================================

PUBLIC_SYSTEM_INCLUDE_PATHS += boost

# Avoid generated dependence on libboost_system-vc80-mt-gd-1_XX.lib causing troubles in mixed-build environments
VC_DEFINES += BOOST_ALL_NO_LIB

WIN32_EXTRA_LIBRARIES += \
	Advapi32$(SHARED_LIB_LINK_POSTFIX)

# ============================================================================

ifeq (Shared,$(MBS_DEFAULT_LAYER_TARGET))
PUBLIC_DEFINES += BOOST_FILESYSTEM_DYN_LINK
endif

# ============================================================================

include BuildSystem/Build.mk

endif
