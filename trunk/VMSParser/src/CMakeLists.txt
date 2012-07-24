cmake_minimum_required(VERSION 2.8)
project( VMSParser )

set(VMS_HEADERS CSVWriter.h Debug.h FlatFileInputSource.h InputSource.h KMLPlacemarkWriter.h TSVWriter.h VMSData.h VMSSentenceParser.h Writer.h)

set(CMAKE_CONFIGURATION_TYPES "Release")

add_executable( VMSParser VMSParser.cpp ${VMS_HEADERS})
FILE(GLOB BOOST_LIBRARIES ${BOOST_LIBRARY_PATH}/*.lib)
set(LIBRARIES ${BOOST_LIBRARIES})
set(INCLUDES ${BOOST_INCLUDE_DIR} ${PARSER_SRC_DIR})
include_directories( VMSParser ${INCLUDES})
target_link_libraries( VMSParser ${LIBRARIES} )
