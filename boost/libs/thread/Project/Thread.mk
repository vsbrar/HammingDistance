include BuildSystem/AWSInit.mk
ifeq (1, $(INCLUDE_GUARD))

# ============================================================================

include BuildSystem/SharedOrStaticLibConfiguration.mk

# ============================================================================

include boost/libs/chrono/Project/BoostChrono.mk
include boost/libs/system/Project/BoostSystem.mk

# ============================================================================

LAYER := BoostThread
LAYER_DIRECTORY := boost/libs/thread/
PRECOMPILED_HEADERS_SOURCE :=

# ============================================================================

BARE_SOURCES :=  \
	future.cpp
# if appears that tss_null is only needed on windows

SOURCES := $(addprefix /src/,$(BARE_SOURCES))

BARE_MACOSX_SOURCES := \
	once.cpp\
	thread.cpp\

MACOSX_SOURCES := $(addprefix /src/pthread/,$(BARE_MACOSX_SOURCES))

BARE_LINUX_SOURCES := \
	once.cpp\
	thread.cpp\

LINUX_SOURCES := $(addprefix /src/pthread/,$(BARE_LINUX_SOURCES))

BARE_WIN32_SOURCES := \
	thread.cpp\
	tss_dll.cpp\
	tss_pe.cpp\

WIN32_SOURCES := $(addprefix /src/win32/,$(BARE_WIN32_SOURCES))\
	src/tss_null.cpp\


# ============================================================================

EXTRA_SYSTEM_INCLUDES += \
	boost

EXTRA_INCLUDES += \
	$(LAYER_DIRECTORY)

# ============================================================================

# Avoid generating dependence on libboost_date_time-vc80-mt-gd-1_39.lib causing troubles in mixed-build environments
VC_PUBLIC_DEFINES += BOOST_ALL_NO_LIB

ifeq (Shared, $(SHARED_OR_STATIC_LIB))

DEFINES += BOOST_THREAD_BUILD_DLL
PUBLIC_DEFINES += BOOST_THREAD_USE_DLL

# Needed to get something (actually all) exported because the default in Main Build System is visibility=hidden
GCC4_MACOSX_COMPILER_FLAGS += -fvisibility=default
CLANG_MACOSX_COMPILER_FLAGS += -fvisibility=default

SHARED_LIBRARY := $(LAYER)Shared

else

DEFINES += BOOST_THREAD_BUILD_LIB
PUBLIC_DEFINES += BOOST_THREAD_USE_LIB

# Make sure this library is not built as a shared library
ifeq (Shared, $(MBS_DEFAULT_LAYER_TARGET))
STATIC_LIBRARY := $(LAYER)
endif

endif # SHARED_OR_STATIC_LIB

# ============================================================================

PUBLIC_SYSTEM_INCLUDE_PATHS += \
	boost

# ============================================================================

include BuildSystem/Build.mk

endif
