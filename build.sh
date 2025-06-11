#!/bin/bash

OPENCV="4.11.0"
CUDA_ARCH_BIN="8.6"
mkdir /opt/openv/opencv-${OPENCV}/build
cd /opt/openv/opencv-${OPENCV}/build
cmake -GNinja \
    -D OPENCV_EXTRA_MODULES_PATH=/opt/openv/opencv_contrib-${OPENCV}/modules \
    -D WITH_CUDA=ON \
    -D WITH_CUDNN=ON \
    -D WITH_NVCUVID=ON \
    -D WITH_CUBLAS=ON \
    -D WITH_OPENGL=ON \
    -D WITH_FFMPEG=ON  \
    -D WITH_V4L=ON \
    -D WITH_LIBV4L=ON \
    -D ENABLE_FAST_MATH=ON \
    -D CUDA_FAST_MATH=ON \
    -D CUDA_ARCH_BIN=${CUDA_ARCH_BIN} \
    -D OPENCV_ENABLE_NONFREE=ON \
    -D WITH_GSTREAMER=OFF \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_opencv_apps=ON \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=ON \
    -D PYTHON_DEFAULT_EXECUTABLE=$(python3 -c "import sys; print(sys.executable)")   \
    -D PYTHON3_EXECUTABLE=$(python3 -c "import sys; print(sys.executable)")   \
    -D PYTHON3_NUMPY_INCLUDE_DIRS=$(python3 -c "import numpy; print (numpy.get_include())") \
    -D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
    -D CUDA_CUDA_LIBRARY=/lib/x86_64-linux-gnu/libcuda.so.1 \
    -D CUDA_nvcuvid_LIBRARY=/lib/x86_64-linux-gnu/libnvcuvid.so.1 \
    -D CUDA_nvidia-encode_LIBRARY=/lib/x86_64-linux-gnu/libnvidia-encode.so.1 \
    .. && \
    ninja && \
    ninja install
