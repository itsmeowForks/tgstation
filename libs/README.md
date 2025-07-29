# External Library System

## Purpose

The purpose of this system is to allow simple management of external libraries that are used by the DM runtime and ship portions of DM code. Forks should be able to easily adjust the parameters which define how the library is built, downloaded, installed, and updated.

Libraries should be easy to add, remove, and update, as well as require very little manual interaction outside of the library definition file to manage.

## About

### Library Types

Each direct subfolder of the libs/ folder defines a type of library.

All library types contain the following scripts:

- `build_install_all.sh`
- `download_install_all.sh`

These scripts run setup for all individual libraries of their own type, as each type can define its own setup methods. Typically this would be used for different languages a library is written in or tools required to download/compile it, as most languages share common requirements and can be adjusted with the individual library's configuration to make a more specific build or install process.

### Libraries

Every library is contained in a folder within its type's folder. For example, `libs/rust/rustg`.

The library folder should always contain a `lib_info.sh`, which defines the parameters used for downloading, building, and installing the library.

The folder should match the name contained within the `LIBRARY_NAME` field of `lib_info.sh`.

Generally, libraries define the following variables:

```bash
# The name of the library. This is also the name of the folder that lib_info is in and the name used for the folder that will contain the DME.
export LIBRARY_NAME="mylib"
# The version or tag for this library
export LIBRARY_VERSION="1.0.0"
# The git repository for the library, used for downloads and cloning source
export LIBRARY_GIT="https://github.com/myorg/mylib"
# The path within a built version of the repository to find a DME
# Any #include files will automatically be collected and copied into the game as well.
export LIBRARY_DME_PATH_BUILD="target/dm/mylib.dme"
# The path to a ZIP file in a GitHub Release which contains all relevant DM code, including a DME
export LIBRARY_DM_ZIP_DOWNLOAD_PATH="mylib_dm.zip"
# The name of the DME within the ZIP file specified
export LIBRARY_DM_ZIP_DME_NAME="mylib.dme"

# The name of the library executable file for different architectures and operating systems.
export LIBRARY_EXECUTABLE_LINUX_32="mylib.so"
export LIBRARY_EXECUTABLE_LINUX_64="mylib64.so"
export LIBRARY_EXECUTABLE_WINDOWS_32="mylib.dll"
export LIBRARY_EXECUTABLE_WINDOWS_64="mylib64.dll"
```

Other definitions are specific to the type and can be used to customize the setup process for the specific library.

#### Library Scripts

Generally, each library type has three shared scripts:

- `build.sh`: Builds the library from source by cloning it at the version's tag, installing necessary dependencies, and adding additional compiler flags.
- `download.sh`: Downloads the library from GitHub Releases.
- `install.sh`: Takes the downloaded or installed library and copies it to the correct locations for runtime.

#### Library DM

Each library can bundle DM code that will be included in the main DME. Libraries are each given their own DME file that can include any number of other DM files.
