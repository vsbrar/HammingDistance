include BuildSystem/AWSInit.mk
ifeq (1, $(INCLUDE_GUARD))

# ============================================================================

include BuildSystem/SharedOrStaticLibConfiguration.mk

# ============================================================================

define boost_system_deprecated
endef

define boost_system_nodeprecated
PUBLIC_DEFINES += BOOST_SYSTEM_NO_DEPRECATED
endef

$(call AddConfiguration,boost_system_deprecated/boost_system_nodeprecated)

# ============================================================================

LAYER := BoostSystem
LAYER_DIRECTORY := boost/libs/system/
PRECOMPILED_HEADERS_SOURCE :=
PREFIX_FILES :=

# ============================================================================
	
SOURCES := src/error_code.cpp

# ============================================================================

PUBLIC_SYSTEM_INCLUDE_PATHS += boost
	
EXTRA_INCLUDES += \
	$(LAYER_DIRECTORY)

# ============================================================================

ifeq (Shared,$(MBS_DEFAULT_LAYER_TARGET))
PUBLIC_DEFINES += BOOST_SYSTEM_DYN_LINK
endif

# ============================================================================

include BuildSystem/Build.mk

endif
