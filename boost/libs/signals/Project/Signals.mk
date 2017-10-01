include BuildSystem/AWSInit.mk
ifeq (1, $(INCLUDE_GUARD))

# ============================================================================

include boost/Project/Boost.mk

LAYER := BoostSignals
LAYER_DIRECTORY := boost/libs/Signals/
PRECOMPILED_HEADERS_SOURCE :=

# ============================================================================

BARE_SOURCES :=  \
	trackable.cpp \
	connection.cpp \
	named_slot_map.cpp \
	signal_base.cpp \
	slot.cpp \
	
SOURCES := $(addprefix /src/,$(BARE_SOURCES))

# ============================================================================

EXTRA_INCLUDES += \
	$(LAYER_DIRECTORY)

# ============================================================================

include BuildSystem/Build.mk

endif
