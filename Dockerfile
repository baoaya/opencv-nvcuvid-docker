FROM nvcr.io/nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04
ENV VIDEOSDK_VERSION 12.2.72
ENV CUDA_PKG_VERSION 12.4.1
LABEL com.nvidia.videosdk.version="${VIDEOSDK_VERSION}"

ENV LIBRARY_PATH /usr/local/cuda/lib64/stubs${LIBRARY_PATH:+:${LIBRARY_PATH}}
ENV NVIDIA_DRIVER_CAPABILITIES ${NVIDIA_DRIVER_CAPABILITIES},video

RUN apt update
RUN apt install -y build-essential
RUN apt install -y cmake
RUN apt install -y unzip
RUN apt install -y curl
RUN apt install -y pkg-config
RUN apt install -y libjpeg-dev libpng-dev libtiff-dev
RUN apt install -y libavcodec-dev libavformat-dev libswscale-dev
RUN apt install -y libv4l-dev libxvidcore-dev libx264-dev
RUN apt install -y libgtk-3-dev
RUN apt install -y libatlas-base-dev gfortran
RUN apt install -y ninja-build

WORKDIR /opt/opencv
COPY Video_Codec_SDK_${VIDEOSDK_VERSION}.zip /opt/opencv

RUN unzip -j Video_Codec_SDK_${VIDEOSDK_VERSION}.zip \
          Video_Codec_SDK_${VIDEOSDK_VERSION}/Interface/cuviddec.h \
          Video_Codec_SDK_${VIDEOSDK_VERSION}/Interface/nvcuvid.h \
          Video_Codec_SDK_${VIDEOSDK_VERSION}/Interface/nvEncodeAPI.h \
          -d /usr/local/cuda/include && \
    unzip -j Video_Codec_SDK_${VIDEOSDK_VERSION}.zip \
          Video_Codec_SDK_${VIDEOSDK_VERSION}/Lib/linux/stubs/x86_64/libnvcuvid.so \
          Video_Codec_SDK_${VIDEOSDK_VERSION}/Lib/linux/stubs/x86_64/libnvidia-encode.so \
          -d /usr/local/cuda/lib64/stubs

ENV OPENCV="4.11.0"
ENV CUDA_ARCH_BIN="8.6"
# copy files
COPY usr /usr
COPY opencv-${OPENCV}.zip
COPY opencv_contrib-${OPENCV}.zip
RUN unzip opencv-${OPENCV}.zip -d /opt/opencv/
RUN unzip opencv_contrib-${OPENCV}.zip -d /opt/opencv/
