set(pinScript  "${CMAKE_CURRENT_LIST_DIR}/pins.py")
set(pinFileDir "${CMAKE_CURRENT_LIST_DIR}/../generated")
set(pinFile    "${pinFileDir}/pins.array")

file(MAKE_DIRECTORY "${pinFileDir}")

set_source_files_properties("${pinFile}" PROPERTIES HEADER_FILE_ONLY TRUE)
set_source_files_properties("../mbed-hal/PinNames.h" PROPERTIES HEADER_FILE_ONLY TRUE
                            OBJECT_DEPENDS ${pinFile})
set_source_files_properties("pins.c" PROPERTIES
                            OBJECT_DEPENDS ${pinFile})

add_custom_target(pinNames ALL DEPENDS "${pinFile}")

add_custom_command(OUTPUT "${pinFile}"
                  MAIN_DEPENDENCY "${YOTTA_CONFIG_MERGED_JSON_FILE}"
                  COMMAND python "${pinScript}" "${YOTTA_CONFIG_MERGED_JSON_FILE}" "${pinFile}"
                  COMMENT "Generating ${pinFile}")
