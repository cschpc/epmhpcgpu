# Dataset and scripts for the paper Evaluating Programming Models for the HPC GPU Ecosystem

# Directories

## sc_script

It is the output fromt he SC script to collect data from the three used systems

## babelstream

The directory for the BabelStream

## miniBUDE

The directory for the miniBUDE 

## Instructions in case that there will be no job submission

Under each benchmark there is directory called results with the data that we used for the plots. If you do not want to submit the jobs, then you can use these files with the `paste` commands

# Kokkos installation

## AMD
```
git clone -b develop https://github.com/kokkos/kokkos.git
cd kokkos
mkdir build
cd build
cmake -DKokkos_ARCH_VEGA908=on -DCMAKE_CXX_COMPILER=hipcc \
      -DKokkos_ENABLE_HIP=on -DKokkos_ENABLE_SERIAL=on \
      -DKokkos_ENABLE_TESTS=on \
      -DKokkos_ENABLE_HIP_RELOCATABLE_DEVICE_CODE=off \
      ..
make -j10
```

## NVIDIA
```
git clone -b develop https://github.com/kokkos/kokkos.git
cd kokkos
mkdir build
cd build
```
### V100
```
cmake -DCMAKE_CXX_COMPILER=/scratch/project/markoman/amd/BabelStream/new/kokkos/bin/nvcc_wrapper \
-DCMAKE_INSTALL_PREFIX=/scratch/project/markoman/amd/BabelStream/new/kokkos/install \
-DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_CUDA=ON  -DKokkos_ARCH_VOLTA70=ON \
-DKokkos_CUDA_DIR=/path_cuda ..
```

### A100
```
cmake -DCMAKE_CXX_COMPILER=/scratch/project/markoman/amd/BabelStream/new/kokkos/bin/nvcc_wrapper \
-DCMAKE_INSTALL_PREFIX=/scratch/project/markoman/amd/BabelStream/new/kokkos/install \
-DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_CUDA=ON  -DKokkos_ARCH_AMPERE80=ON \
-DKokkos_CUDA_DIR=/path_cuda/ ..
```


# BabelStream

* Install BabelStream according to the instructions from the official repository

* Basic instructions and used version
```
git clone https://github.com/UoB-HPC/BabelStream.git
cd BabelStream
git checkout 6fe81e1
```
* We include instructions only for the cases that the default provided compilation was not working or we had to add a flag

## Kokkos

### NVIDIA V100
```
cmake -Bbuild -H. -DMODEL=Kokkos -DCMAKE_CXX_COMPILER=/scratch/project/markoman/kokkos/bin/nvcc_wrapper \
-DCMAKE_INSTALL_PREFIX=/scratch/project/markoman/kokkos/install -DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_CUDA=ON\
-DKokkos_ARCH_VOLTA70=ON -DKokkos_CUDA_DIR=/path_to_your_cuda \
-DKOKKOS_IN_TREE=/scratch/project/markoman/kokkos -DCXX_FLAGS="--expt-extended-lambda" -DKokkos_ENABLE_CUDA_LAMBDA=ON
```
### NVIDIA A100
```
cmake -Bbuild -H. -DMODEL=Kokkos -DCMAKE_CXX_COMPILER=/scratch/project/markoman/kokkos/bin/nvcc_wrapper \
-DCMAKE_INSTALL_PREFIX=/scratch/project/markoman/kokkos/install -DKokkos_ENABLE_SERIAL=ON -DKokkos_ENABLE_CUDA=ON\
-DKokkos_ARCH_AMPERE80=ON -DKokkos_CUDA_DIR=path_your_cuda\
-DKOKKOS_IN_TREE=/scratch/project/markoman/kokkos -DCXX_FLAGS="--expt-extended-lambda" -DKokkos_ENABLE_CUDA_LAMBDA=ON
```
### AMD MI100
```
cmake -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_INSTALL_PREFIX=/home/markoman/kokkos/install -DKokkos_ENABLE_OPENMP=ON -DKokkos_ENABLE_HIP=ON  -DKokkos_ARCH_VEGA908=ON ..
```
## OpenMP Offloading

### NVIDIA 

#### V100
```
nvc++ -mp=gpu -gpu=cc70 -O3 -std=c++11 -DOMP -DOMP_TARGET_GPU  main.cpp OMPStream.cpp  -o omp-stream
```
#### A100
```
nvc++ -mp=gpu -gpu=cc80 -O3 -std=c++11 -DOMP -DOMP_TARGET_GPU  main.cpp OMPStream.cpp  -o omp-stream
```

## ALPAKA (CUPLA)

Alpaka: 
```
git clone https://github.com/alpaka-group/cupla.git
cd cupla
git checkout f60a0ac
export CUPLA_ROOT=$PWD

cd path/BabelStream/build
```
### MI100

* Export the CMAKE_MODULE_PATH to your HIP cmake
```
export CMAKE_MODULE_PATH=/opt/rocm-4.2.0/hip/cmake/:$CMAKE_MODULE_PATH
```

* CMAKE
```
cmake -DMODEL=CUPLA -DALPAKA_ACC_GPU_HIP_ENABLE=ON -DALPAKA_HIP_ARCH=908 ..
```
### NVIDIA


* V100
```
cmake -DMODEL=CUPLA -DALPAKA_ACC_GPU_CUDA_ENABLE=ON -DALPAKA_CUDA_ARCH=70 ..
```

* A100
```
cmake -DMODEL=CUPLA -DALPAKA_ACC_GPU_CUDA_ENABLE=ON -DALPAKA_CUDA_ARCH=80 ..
```

## Patches

The patches are required for perfromance tuning, to run the default benchmarks, do not apply the patches.
Patches are required only for BabelStream
The Alpaka version of BabelStream is located here: https://github.com/jyoung3131/BabelStream/tree/v3.4-alpaka

### MI100
```
patch HIPStream.cpp < patch_babel_hip.patch

patch SYCLStream.cpp < patch_babel_hipsycl_mi100.patch

patch CUPLAStream.h < patch_alpaka_mi100.patch
```
### A100
```
patch CUDAStream.h < patch_babel_cuda_a100.patch

patch SYCLStream.cpp < patch_babel_hipsycl_a100.patch

patch CUPLAStream.h < patch_alpaka_a100.patch
```


# miniBUDE
```
https://github.com/UoB-HPC/miniBUDE.git
cd miniBUDE
git checkout 1af5b39
```
## Installation

### MI100 (HIP)

* Some patches are required only for the HIP version

```
cp -r cuda hip
cd hip
patch shared.h < ../patch_hip_mi100.patch
patch Makefile < ../patch_hip_mi100_makefile.patch
make USE_HIP=1 
```
### NVIDIA
```
cd cuda
```
* Edit the Makefile for the 70/80 compute architecture for NVIDIA
```
make
```

# Execution

## BabelStream

* Transfer the output files fromt he submissions below to the same system in order to be able to create common files


### HIP CUDA

```
sbatch amd_mi100/babel_hip_mi100.sh

./common/extract.sh babel_hip_mi100_out babel_hip_mi100.dat
```
```
sbatch nvidia_v100/bbabel_cuda_v100.sh

./common/extract.sh babel_cuda_v100_out babel_cuda_v100.dat
```
```
sbatch nvidia_a100/bbabel_cuda_a100.sh

./common/extract.sh babel_cuda_a100_out babel_cuda_a100.dat
```
```
paste babel_hip_mi100.dat babel_cuda_v100.dat babel_cuda_a100.dat > babel_hip_cuda_all.dat

./common/replaceall.sh babel_hip_cuda_all babel_cuda_hip_all 795 860 910 960 970 1020 1300 1350 1350 1410 "HIP and CUDA"
```
A new png file is create and called babel_cuda_hip_all.png


### OpenMP offloading
```
sbatch amd_mi100/babel_omp_mi100.sh

./common/extract.sh babel_omp_mi100_out babel_omp_mi100.dat
```
```
sbatch nvidia_v100/babel_omp_v100.sh

./common/extract.sh babel_omp_v100_out babel_omp_v100.dat
```
```
sbatch nvidia_a100/babel_omp_a100.sh

./common/extract.sh babel_omp_a100_out babel_omp_a100.dat
```
```
paste babel_omp_mi100.dat babel_omp_v100.dat babel_omp_a100.dat > babel_omp_all.dat

./common/replaceall_omp.sh babel_omp_all babel_omp_all 780 830 370 420 890 950 1210 1270 1300 1400 "OpenMP Offloading"
```
A new png file is created and called babel_omp_all.png


### HIPSYCL
```
sbatch amd_mi100/babel_hipsycl_mi100.sh

./common/extract.sh babel_hipsycl_mi100_out babel_hipsycl_mi100.dat
```
```
sbatch nvidia_v100/babel_hipsycl_v100.sh

./common/extract.sh babel_hipsycl_v100_out babel_hipsycl_v100.dat
```
```
sbatch nvidia_a100/babel_hipsycl_a100.sh

./common/extract.sh babel_hipsycl_a100_out babel_hipsycl_a100.dat
```
```
paste babel_hipsycl_mi100.dat babel_hipsycl_v100.dat babel_hipsycl_a100.dat > babel_hipsycl_all.dat

./common/replaceall.sh babel_hipsycl_all babel_hipsycl_all 770 830 830 880 930 980 1260 1300 1320 1380 "hipSYCL"
```
A new png file is created and called babel_hipsycl_all.png


### Alpaka
```
sbatch amd_mi100/babel_alpaka_mi100.sh

./common/extract.sh babel_alpaka_mi100_out babel_alpaka_mi100.dat
```
```
sbatch nvidia_v100/babel_alpaka_v100.sh

./common/extract.sh babel_alpaka_v100_out babel_alpaka_v100.dat
```
```
sbatch nvidia_a100/babel_alpaka_a100.sh

./common/extract.sh babel_alpaka_a100_out babel_alpaka_a100.dat
```
```
paste babel_alpaka_mi100.dat babel_alpaka_v100.dat babel_alpaka_a100.dat > babel_alpaka_all.dat

./common/replaceall.sh babel_alpaka_all babel_alpaka_all 785 845 900 960 970 1020 1280 1330 1350 1410 "Alpaka"
```
A new png file is created and called babel_alpaka_all.png


### Kokkos
```
sbatch amd_mi100/babel_kokkos_mi100.sh

./common/extract.sh babel_kokkos_mi100_out babel_kokkos_mi100.dat
```
```
sbatch nvidia_v100/babel_kokkos_v100.sh

./common/extract.sh babel_kokkos_v100_out babel_kokkos_v100.dat
```
```
sbatch nvidia_a100/babel_kokkos_a100.sh

./common/extract.sh babel_kokkos_a100_out babel_kokkos_a100.dat
```
```
paste babel_kokkos_mi100.dat babel_kokkos_v100.dat babel_kokkos_a100.dat > babel_kokkos_all.dat

./common/replaceall_noopt.sh babel_kokkos_all babel_kokkos_all 600 620 680 710 711 840 960 990 1120 1180 1300 1410 "Kokkos"
```
A new png file is created and called babel_kokkos_all.png

## miniBUDE

* The input file big5 is provided and need to put the proper path in the submission files

### HIP
```
sbatch minibude_hip_mi100.sh

./extract.sh minibude_hip_mi100_out minibude_hip_mi100.dat
```

### CUDA

```
sbatch minibude_cuda_v100.sh

./extract.sh minibude_cuda_v100_out minibude_cuda_v100.dat
```
```
sbatch minibude_cuda_a100.sh

./extract.sh minibude_cuda_a100_out minibude_cuda_a100.dat
```
### Analysis

* Transfer the output files to the same system
```
paste minibude_hip_mi100.dat minibude_cuda_v100.dat minibude_cuda_a100.dat > minibude_hip_cuda_all.dat

./replace3bude.sh minibude_hip_cuda_all minibude_hip_cuda_all 10800 11050 13800 14000 22700 22950 "CUDA and HIP"
```

* A new file called minibude_hip_cuda_all.png is created
