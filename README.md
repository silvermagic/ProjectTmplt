## 安装

### 环境配置

> 安装Conan

```
pip install conan==1.60.0 --no-cache-dir --user
```

> 安装依赖

```
tee conanfile.txt <<-EOF
[requires]
boost/1.83.0
fmt/10.0.0
[generators]
CMakeDeps
CMakeToolchain
[layout]
cmake_layout
EOF

conan install conanfile.txt --build=missing
```

### 编译

```
cd simple
./build.sh

cd sample
./build.sh

cd sample_lib
./build.sh

cd sample_lib/example
./build.sh
```

### 运行

```
cd simple/build/bin
./sample ..

cd sample/build/package/bin
export LD_LIBRARY_PATH=../lib:$LD_LIBRARY_PATH
./sample ..

cd sample_lib/example/build/package/bin
export LD_LIBRARY_PATH=../lib:$LD_LIBRARY_PATH
./demo ..
```

## 概述

### conan目录

> simple

标准官方示例

> sample

通过`conanfile.py`的`import`方法，将依赖库的头文件和库文件拷贝到`CMAKE_BINARY_DIR`目录下，然后通过设置`include_directories("${CMAKE_BINARY_DIR}/include")`和`link_directories("${CMAKE_BINARY_DIR}/lib")`实现对依赖库的引用。

> sample_lib

- 包含跨平台模板
- 自动导出头文件，并保持原目录结构
- 包含符号可见性控制