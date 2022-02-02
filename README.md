# HammingDistance

Intro
------------------------------------------------------------------------------
This branch contains a library and an executable for calculating Hamming Distance.

Program Usage
------------------------------------------------------------------------------
HammingDistanceCalculator -h for help

Example:
HammingDistanceCalculator 1011 1011

# Setting up development environment
#### CMake
The system uses CMake as build generator.
For more info on CMake visit https://cmake.org/.

Install and build CMake to your development environment as below:
```bash
wget https://cmake.org/files/v3.18/cmake-3.18.0.tar.gz
tar xzf cmake-3.18.0.tar.gz
cd cmake-3.18.0
./bootstrap
make 
sudo make install
cmake --version
```

Building
------------------------------------------------------------------------------
The cmake lists file can be found in the Makefiles directory of the particular layer.

The code is made cross platform and can be build or run on any platform.
As of now it is tested and built on MacOSX only.
The dependencies like googletest and boost are included in the project itself.
Utmost care has been taken to automate the build process as much as possible
and a CMake build system is created for the ease.

To build everything:
In parent directory type "make"
This will build install and test everything.
The build output is placed in "Output" folder.

To test everything:
In parent directory type "make test"
This will test everything.
The build output is placed in "Output" folder.

To install everything:
In parent directory type "make install"
This will install everything.
The build output is placed in "Output" folder.

To clean everything:
In parent directory type "make clean"
This will clean everything.

To bulid a particular layer:
cd LayerDirectory/Makefiles
mkdir build
cd build
cmake ..
make
The executables will be placed in the cmake binary tree directory in this case.
You can create any other directory and run cmake again to create out of tree builds.

Running tests:
make test

Install:
make install

Code Organisation
------------------------------------------------------------------------------

1. Folder structure layout
The code is organised into layers where each layer may or may not depend on other.
This is done to provide abstraction and ease of code management in version control.

For example:
The user of library will have no interest in including the library tester into his
project and he can just use the library layer. This is really helpful where multiple
projects are using the particular layer.

2. File naming conventions
File names follow G or P prefix along with first three chars of layer name.
Where G prefix is for cross platform files and P is for platform specific files.

For Example:
Layer HammingDistance the files name will have the GHD prefix.

For headers that are public i.e. to be shared by other layers to
be in parent directory of layer.
Private headers and sources to in 'Sources' directory.

4. Code style guild lines
The code follows GNU, Amazon and Hungarian style guild lines.

5. Documentation
The code uses Doxygen tags.

Testing
------------------------------------------------------------------------------
1. Each layer has testers for it.
2. The testing frameworks used are googletest and ctest.
3. The test cases can be run using 'make test' command or running the tester executables.
For example for HammingDistance library there is a tester called as HammingDistanceTester.
	Build the HammingDistanceTester (this is described under Building).
	Run the executable.
	type 'HammingDistanceTester --help' for more tests usage.
	
Current Failing Tests
------------------------------------------------------------------------------
1. HammingDistanceTest, testIncorrectInput. Commented out!

Improvements
------------------------------------------------------------------------------
1. CMake Add_ExternalProject can be used in cmake for gtest and boost.
However this can cause problems if the newer versions have broken something.
2. The build system can be improved to use boost as a external project.
3. The install directories can use GNUInstallDirs.
