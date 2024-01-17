import os
from conans import ConanFile, CMake


class TestConan(ConanFile):
    name = "test"
    version = "1.0.0"
    settings = "os", "compiler", "build_type", "arch"
    generators = "cmake_find_package"
    options = {"shared": [True], "fPIC": [True]}
    default_options = {"shared": True, "fPIC": True}
    requires = [
        ("sample_lib/1.0.0@dev/stable")
    ]
    _cmake = None

    def requirements(self):
        pass

    def imports(self):
        self.copy("*", "include", "include")
        self.copy("*", "etc", "etc")
        self.copy("*", "lib", "lib")
        self.copy("*", "share", "share")

    def config_options(self):
        if self.settings.os == "Windows":
            del self.options.fPIC

    def _configure_cmake(self):
        if self._cmake:
            return self._cmake
        self._cmake = CMake(self)

        self._cmake.definitions["arch"] = "win"
        if self.settings.os == "Linux":
            self._cmake.definitions["arch"] = "linux_x64"
            if self.settings.compiler.version == "6.5":
                self._cmake.definitions["arch"] = "aarch64-j3"
            if self.settings.compiler.version == "9.3":
                self._cmake.definitions["arch"] = "aarch64-j5"

        self._cmake.definitions["CMAKE_BUILD_TYPE"] = self.settings.build_type
        self._cmake.configure()
        return self._cmake

    def build(self):
        cmake = self._configure_cmake()
        cmake.build()

    def package(self):
        cmake = self._configure_cmake()
        cmake.install()
        self.copy("*.so", dst="lib", keep_path=False)
        self.copy("*", src=os.path.join(self.build_folder, "output"),
                  keep_path=True, symlinks=True)
