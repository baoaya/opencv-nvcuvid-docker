# OpenCV Docker Image with CUDA and NVCUVID Support

## Overview
This GitHub resource provides a workflow to create a Docker image for OpenCV with integrated support for **CUDA** (NVIDIA's parallel computing platform) and **NVCUVID** (NVIDIA Video Decoder). Due to limitations in the `docker build` command, which cannot utilize the `--gpus` argument, a two-phase approach is required:  
1. Build a base image without GPU dependencies.  
2. Compile OpenCV inside a running container with GPU access.

## Versions Supported
The build recipes include the following versions:

- Video Codec SDK: 12.2.72
- CUDA: 12.4.1
- 

## Prerequisites
- Download compatible versions of:
  - **OpenCV** source code ([download opencv-4.11.0](https://github.com/opencv/opencv/archive/refs/tags/4.11.0.zip) [opencv-contrib-4.11.0](https://github.com/opencv/opencv_contrib/releases/tag/4.11.0))
  - **NVIDIA Video Codec SDK** ([download video_codec_sdk_12.2.72.zip](https://developer.nvidia.com/designworks/video-codec-sdk/secure/12.2/video_codec_sdk_12.2.72.zip))
- Docker installed on your system

## Build Workflow

### Step 1: Create the Base Image
Build the initial Docker image using the `docker build` command:  
```bash
docker build -t opencv-nvcuvid:base .
```

### Step 2: Launch Container with GPU Access
Run a container from the base image with full GPU support:
```bash
docker run --gpus all -itd --name build-base opencv-nvcuvid:base
```

### Step 3: Compile OpenCV Inside the Container
Access the container and execute the build script:
```bash
docker exec -it build-base bash
```
```bash
./build.sh  # This script handles OpenCV compilation with CUDA/NVCUVID
```

### Step 4: Create the Final Image
Commit the container state to generate the optimized Docker image:
```bash
docker commit build-base opencv-nvcuvid:12.4.1-cudnn-devel-ubuntu22.04
```

## Notes
Replace build.sh with your OpenCV compilation script (e.g., including CMake flags for CUDA/NVCUVID).
Verify NVIDIA driver and CUDA toolkit compatibility on the host system.
