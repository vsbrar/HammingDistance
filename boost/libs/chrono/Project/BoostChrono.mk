include BuildSystem/AWSInit.mk
ifeq (1, $(INCLUDE_GUARD))

# ============================================================================

include BuildSystem/SharedOrStaticLibConfiguration.mk

# ============================================================================

$(call AddRequiredConfigurations,boost_system_deprecated)

include boost/Project/Boost.mk
include boost/libs/system/Project/BoostSystem.mk

# ============================================================================

LAYER := BoostChrono
LAYER_DIRECTORY := boost/libs/chrono/

# ============================================================================

SOURCES := $(addprefix /src/,\
	chrono.cpp\
	process_cpu_clocks.cpp\
	thread_clock.cpp\
)

# ============================================================================

# Avoid auto-generation of link dependencies
VC_PUBLIC_DEFINES += BOOST_ALL_NO_LIB

ifeq (Shared, $(MBS_DEFAULT_LAYER_TARGET))

PUBLIC_DEFINES += BOOST_CHRONO_DYN_LINK

# Necessary because visibility=hidden is default:
GCC4_MACOSX_COMPILER_FLAGS += -fvisibility=default

endif

# ============================================================================

include BuildSystem/Build.mk

endif
