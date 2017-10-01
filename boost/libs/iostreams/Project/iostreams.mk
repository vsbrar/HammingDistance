include BuildSystem/AWSInit.mk
ifeq (1, $(INCLUDE_GUARD))

# ============================================================================

include zlib/Project/ZLib.mk

# ============================================================================

# TODO: Add configurations for switching zlib/bzip2 support on or off
# $(call AddConfiguration,boost_iostreams_zlib/boost_iostreams_no_zlib)
# $(call AddConfiguration,boost_iostreams_no_bzip2/boost_iostreams_bzip2)

# ============================================================================

LAYER := BoostIOStreams
LAYER_DIRECTORY := boost/libs/iostreams/

# ============================================================================

ifeq (Shared,$(MBS_DEFAULT_LAYER_TARGET))
GCC4_MACOSX_COMPILER_FLAGS += -fvisibility=default
CLANG_MACOSX_COMPILER_FLAGS += -fvisibility=default
PUBLIC_DEFINES += BOOST_IOSTREAMS_DYN_LINK
endif

# Do not generate automatic linking dependencies 
VC_DEFINES += BOOST_ALL_NO_LIB

# ============================================================================

BARE_SOURCES :=  \
	file_descriptor.cpp\
	gzip.cpp\
	mapped_file.cpp\
	zlib.cpp\

SOURCES := $(addprefix /src/,$(BARE_SOURCES))

# ============================================================================

PUBLIC_SYSTEM_INCLUDE_PATHS += boost

# ============================================================================

include BuildSystem/Build.mk

endif
