TEMPLATE = lib
TARGET = git-qt

QT += core
QT -= gui qml widgets

CONFIG += c++11

DEFINES += \
    QT_NO_CAST_FROM_ASCII \
    QT_NO_CAST_TO_ASCII

INCLUDEPATH += \
    src \
    libgit2/src \
    libgit2/deps \
    libgit2/include

# dependency include paths
INCLUDEPATH += \
    libgit2/deps/regex

# platform specific include paths
unix:INCLUDEPATH += \
    libgit2/deps/http-parser
win32:INCLUDEPATH += \
    libgit2/deps/winttp

HEADERS += \
    src/git-qt.h
SOURCES += \
    src/git-qt.cpp


# libgit2
HEADERS += \
    $$files("libgit2/include", true) \
    $$files("libgit2/src/*.h") \
    $$files("libgit2/src/transports/*.h", true) \
    $$files("libgit2/src/xdiff/*.h", true) \
    $$files("libgit2/deps/regex/*.h", true)
SOURCES += \
    $$files("libgit2/src/*.c") \
    $$files("libgit2/src/transports/*.c", true) \
    $$files("libgit2/src/xdiff/*.c", true) \
    $$files("libgit2/deps/regex/*.c", true)

# libgit2 platform specific
unix {
    HEADERS += \
        $$files("libgit2/src/hash/*[^_win32].h", true) \
        $$files("libgit2/src/unix/*.h", true) \
        $$files("libgit2/deps/http-parser/*.h", true)
    SOURCES += \
        $$files("libgit2/src/unix/*.c", true) \
        $$files("libgit2/src/hash/*[^_win32].c", true) \
        $$files("libgit2/deps/http-parser/*.c", true)
}
# TODO: Doesn't work! Windows files are not required on other platforms.
#win32 {
#    HEADERS += \
#        $$files("libgit2/src/hash/*_win32.h") \
#        $$files("libgit2/deps/zlib/*.h")
#    SOURCES += \
#        $$files("libgit2/src/*_win32.c") \
#        $$files("libgit2/deps/zlib/*.c")
#}
