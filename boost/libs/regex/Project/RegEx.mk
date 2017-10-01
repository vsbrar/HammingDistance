include BuildSystem/AWSInit.mk
ifeq (1, $(INCLUDE_GUARD))

# ============================================================================

include BuildSystem/SharedOrStaticLibConfiguration.mk

# ============================================================================

LAYER := BoostRegEx
LAYER_DIRECTORY := boost/libs/regex/
PRECOMPILED_HEADERS_SOURCE := 

ifneq ($(BOOST_NO_WREGEX),)
WIN32_DEFINES = BOOST_NO_WREGEX
endif

# If Shared, set appropriate flags and defines
# Otherwise, always build a static library to avoid Static/Objects configuration inconsistencies
ifeq (Shared,$(MBS_DEFAULT_LAYER_TARGET))
	GCC4_MACOSX_COMPILER_FLAGS += -fvisibility=default
	CLANG_MACOSX_COMPILER_FLAGS += -fvisibility=default
	PUBLIC_DEFINES += BOOST_REGEX_DYN_LINK
endif

# ============================================================================

BARE_SOURCES :=  \
	c_regex_traits.cpp\
	cpp_regex_traits.cpp\
	cregex.cpp\
	fileiter.cpp\
	instances.cpp\
	posix_api.cpp\
	regex_raw_buffer.cpp\
	regex_traits_defaults.cpp\
	regex.cpp\
	static_mutex.cpp\
	wc_regex_traits.cpp\
	wide_posix_api.cpp\
	winstances.cpp\

#	icu.cpp\	we are not building on top of ICU
#	regex_debug.cpp\ we do not define BOOST_REGEX_CONFIG_INFO ...

SOURCES := $(addprefix /src/,$(BARE_SOURCES))

BARE_WIN32_SOURCES := \
	usinstances.cpp\
	w32_regex_traits.cpp\
	
WIN32_SOURCES := $(addprefix /src/,$(BARE_WIN32_SOURCES))

WIN32_EXTRA_LIBRARIES += User32$(SHARED_LIB_LINK_POSTFIX)

# ============================================================================

EXTRA_INCLUDES += $(LAYER_DIRECTORY)

# ============================================================================

PUBLIC_SYSTEM_INCLUDE_PATHS += boost
	
# ============================================================================

include BuildSystem/Build.mk

endif
