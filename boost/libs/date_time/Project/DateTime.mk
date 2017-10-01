include BuildSystem/AWSInit.mk
ifeq (1, $(INCLUDE_GUARD))

# ============================================================================

LAYER := BoostDateTime
LAYER_DIRECTORY := boost/libs/date_time/
PRECOMPILED_HEADERS_SOURCE :=

# If Shared, set appropriate flags and defines
# Otherwise, always build a static library to avoid Static/Objects configuration inconsistencies
ifeq (Shared,$(MBS_DEFAULT_LAYER_TARGET))
	GCC4_MACOSX_COMPILER_FLAGS += -fvisibility=default
	CLANG_MACOSX_COMPILER_FLAGS += -fvisibility=default
	PUBLIC_DEFINES += BOOST_DATE_TIME_DYN_LINK
else
	STATIC_LIBRARY := $(LAYER)
endif

# ============================================================================

BARE_SOURCES :=  \
	date_generators.cpp \
	greg_month.cpp \
	greg_weekday.cpp \
	gregorian_types.cpp \
	
SOURCES := $(addprefix /src/gregorian/,$(BARE_SOURCES))

# ============================================================================

EXTRA_INCLUDES += \
	$(LAYER_DIRECTORY)

# ============================================================================

PUBLIC_SYSTEM_INCLUDE_PATHS += boost
	
# ============================================================================

include BuildSystem/Build.mk

endif
