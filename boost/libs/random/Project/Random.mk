include BuildSystem/AWSInit.mk
ifeq (1, $(INCLUDE_GUARD))

# ============================================================================

include boost/libs/system/Project/BoostSystem.mk


# ============================================================================

LAYER := BoostRandom
LAYER_DIRECTORY := boost/libs/random

# ============================================================================

PRECOMPILED_HEADERS_SOURCE :=

SOURCES := $(addprefix src/, random_device.cpp )

# ============================================================================

PUBLIC_SYSTEM_INCLUDE_PATHS += boost

# Avoid generated dependence on libboost_system-vc80-mt-gd-1_XX.lib causing troubles in mixed-build environments
VC_DEFINES += BOOST_ALL_NO_LIB

WIN32_EXTRA_LIBRARIES += Advapi32.lib

# ============================================================================

ifeq (Shared,$(MBS_DEFAULT_LAYER_TARGET))
PUBLIC_DEFINES += BOOST_RANDOM_DYN_LINK
endif

# ============================================================================

include BuildSystem/Build.mk

endif
