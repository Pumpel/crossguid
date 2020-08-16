find_package(PkgConfig)

pkg_check_modules(PKG_LIBUUID QUIET uuid)

set(LIBUUID_DEFINITIONS ${PKG_LIBUUID_CFLAGS_OTHER})
set(LIBUUID_VERSION ${PKG_LIBUUID_VERSION})

find_path(
  LIBUUID_INCLUDE_DIR uuid libuuid
    PATH_SUFFIXES include
    )

find_library(LIBUUID_LIBRARY NAMES uuid
            HINTS ${PC_LIBUUID_LIBDIR} ${PC_LIBUUID_LIBRARY_DIRS} )

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Libuuid
	FOUND_VAR
		LIBUUID_FOUND
	REQUIRED_VARS
		LIBUUID_LIBRARY
		LIBUUID_INCLUDE_DIR
	VERSION_VAR
		LIBUUID_VERSION
)

if(LIBUUID_FOUND AND NOT TARGET LibUUID::UUID)
	add_library(LibUUID::UUID UNKNOWN IMPORTED)
	set_target_properties(LibUUID::UUID PROPERTIES
		IMPORTED_LOCATION "${LIBUUID_LIBRARY}"
		INTERFACE_COMPILE_OPTIONS "${LIBUUID_DEFINITIONS}"
		INTERFACE_INCLUDE_DIRECTORIES "${LIBUUID_INCLUDE_DIR}"
	)
endif()

mark_as_advanced(LIBUUID_INCLUDE_DIR LIBUUID_LIBRARY)

include(FeatureSummary)
set_package_properties(LIBUUID PROPERTIES
	URL "http://www.kernel.org/pub/linux/utils/util-linux/"
	DESCRIPTION "uuid library in util-linux"
)