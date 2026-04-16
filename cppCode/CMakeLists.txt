cmake_minimum_required(VERSION 3.10)

project(MyProject)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

include_directories(include)

add_executable(MyProject
    src/main.cpp
    src/utils.cpp
    src/math.cpp
)

# ---------------------------------------------
# Build commands:
#   cmake -S . -B build
#   cmake --build build
#
# CodeQL database creation:
#   codeql database create mydb ^
#     --language=cpp ^
#     --source-root=. ^
#     --command="cmake --build build --clean-first"
# ---------------------------------------------