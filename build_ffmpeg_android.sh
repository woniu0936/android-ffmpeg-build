#!/bin/sh
# NDK 所在的路径
NDK=/Users/songhuan/Library/Android/sdk/ndk/22.0.7026061
# 需要编译出的平台，这里是 arm64-v8a
ARCH=aarch64
# 支持的最低 Android API
API=21
# 编译后输出目录，在 ffmpeg 源码目录下的 /android/arm64-v8a
OUTPUT=$(pwd)/android/arm64-v8a
# NDK 交叉编译工具链所在路径
TOOLCHAIN=/Users/songhuan/Library/Android/sdk/ndk/22.0.7026061/toolchains/llvm/prebuilt/darwin-x86_64

function build {
 ./configure \
 --target-os=android \
 --prefix=$OUTPUT \
 --arch=$ARCH \
 --sysroot=$TOOLCHAIN/sysroot \
 --disable-static \
 --disable-ffmpeg \
 --disable-ffplay \
 --disable-ffprobe \
 --disable-debug \
 --disable-doc \
 --disable-avdevice \
 --enable-shared \
 --enable-cross-compile \
 --cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
 --cc=$TOOLCHAIN/bin/aarch64-linux-android$API-clang \
 --cxx=$TOOLCHAIN/bin/aarch64-linux-android$API-clang++ \
 --extra-cflags="-fpic"

 make clean all
 make -j12
 make install
}

build
