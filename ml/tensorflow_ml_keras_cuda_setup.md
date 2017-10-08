# Install CUDA

## Download cuda toolkit
http://developer.nvidia.com/cuda-downloads
```sh
# install it with:
sudo dpkg -i cuda-repo-ubuntu1704-9-0-local_9.0.176-1_amd64.deb
sudo apt-key add /var/cuda-repo-9-0-local/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda
```

## Prepare definitions for cuda env
```
# echo 'export PATH=$PATH:/usr/local/cuda-9.0/bin' >> $HOME/.zshrc
echo 'export PATH=$PATH:/usr/local/cuda-9.0/bin' >> $HOME/.bashrc
export PATH=$PATH:/usr/local/cuda-9.0/bin

echo 'export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64' >> $HOME/.bashrc
export LD_LIBRARY_PATH=/usr/local/cuda-9.0/lib64
```

## Verify cuda installation (optional)

```sh
# Install test samples
cuda-install-samples-9.0.sh test_dir/
cd test_dir/NVIDIA_CUDA-9.0_Samples/
# build samples - Will take a while.(OPTIONAL)
make

# RESTART YOU COMPUTER!
sudo reboot

# Run binary
NVIDIA_CUDA-9.0_Samples/bin/x86_64/linux/release/deviceQuery
NVIDIA_CUDA-9.0_Samples/bin/x86_64/linux/release/bandwidthTest

# make sure both pass

```


# install cuDNN v 7
Download cuDNN v 7 runtime edition for ubuntu 16.04
https://developer.nvidia.com/rdp/cudnn-download

```sh
sudo dpkg -i libcudnn7_7.0.3.11-1+cuda9.0_amd64.deb
echo 'export CUDA_HOME=/usr/local/cuda' >> $HOME/.bashrc
export CUDA_HOME=/usr/local/cuda
```

# Install tensorflow, jupyter and keras
Create virtualenv called tensorflow
```sh
virtualenv --system-site-packages -p python3.6 tensorflow
# Activate environment
source ~/tensorflow/bin/activate
```

## While in the virtual environment
Make sure pip is installed with version > 8.01
```sh
pip --version
#install tensorflow
pip install --upgrade tensorflow-gpu
```

### Install jupyter and keras
```sh
pip install keras
pip install jupyter
pip install --upgrade jinja2
```

# Take it for a test Run
```sh
# in virtualenv
jupyter notebook
```

In jupyter notebook try to import keras or tensorflow.
