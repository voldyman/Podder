# Check http://webdev.elementaryos.org/docs/developer-guide/cmake for documentation

project (podder)
cmake_minimum_required (VERSION 2.8)
cmake_policy (VERSION 2.6)

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/vala)

#
# Base bits
#

enable_testing ()

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share")
set (PKGDATADIR "${DATADIR}/podder")
set (GETTEXT_PACKAGE "podder")
set (RELEASE_NAME "aura")
set (VERSION "0.1")
set (VERSION_INFO "Release")
set (CMAKE_C_FLAGS "-ggdb")
set (PREFIX ${CMAKE_INSTALL_PREFIX})
set (DOLLAR "$")

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

configure_file (${CMAKE_SOURCE_DIR}/src/config.vala.cmake ${CMAKE_SOURCE_DIR}/src/config.vala)
add_definitions (-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")

# Add 'make dist' command for creating release tarball
set (CPACK_PACKAGE_VERSION ${VERSION})
set (CPACK_SOURCE_GENERATOR "TGZ")
set (CPACK_SOURCE_PACKAGE_FILE_NAME "${CMAKE_PROJECT_NAME}-${CPACK_PACKAGE_VERSION}")
set (CPACK_SOURCE_IGNORE_FILES "/build/;/.bzr/;/.bzrignore;~$;${CPACK_SOURCE_IGNORE_FILES}")

include (CPack)
add_custom_target (dist COMMAND ${CMAKE_MAKE_PROGRAM} package_source)

find_package (PkgConfig)
pkg_check_modules (DEPS REQUIRED gthread-2.0 gtk+-3.0 granite)

add_definitions (${DEPS_CFLAGS})

link_libraries (${DEPS_LIBRARIES})
link_directories (${DEPS_LIBRARY_DIRS})

find_package (Vala REQUIRED)
include (ValaVersion)
ensure_vala_version ("0.16.0" MINIMUM)

include (ValaPrecompile)
vala_precompile(VALA_C
    src/Main.vala
    src/Widgets/AppWindow.vala
    src/Widgets/Toolbar.vala
    src/Widgets/WindowToolbar.vala
    src/Widgets/ContentView.vala
    src/Widgets/SearchView.vala
    src/Backend/PodcastData.vala
    src/config.vala
PACKAGES
    granite
    gtk+-3.0
    gee-1.0
OPTIONS
    --thread
)

add_executable (podder ${VALA_C})
find_library (M_LIB m)
target_link_libraries (podder ${M_LIB})

install (TARGETS podder RUNTIME DESTINATION bin)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/podder.desktop DESTINATION share/applications)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/icon.svg DESTINATION share/podder)
install (DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/data/imgs DESTINATION share/podder/)
