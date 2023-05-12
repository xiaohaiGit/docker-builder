FROM nvidia/cuda:12.0.0-cudnn8-runtime-ubuntu22.04

RUN rm -rf /etc/apt/sources.list.d/*.list \
    && apt update && apt install -y tzdata make wget ffmpeg vim -y  \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b

ENV PATH="/root/miniconda3/bin:${PATH}"

RUN conda init bash \
    && . ~/.bashrc \
    && conda create -n dig -c main python=3.10 cudnn=8.2 cudatoolkit=11.3 \
    && conda activate dig \
    && pip3 install numba==0.48 librosa==0.7.0 numpy==1.19.3 scipy==1.4.1 resampy==0.3.1 tf2onnx==1.9.3 tensorflow-gpu==2.4.0 protobuf==3.20.3 \
       h5py==2.10.0 scikit-image==0.14.2 tqdm opencv-python ffmpeg-python numexpr colorama chardet av pims \
    && conda install pytorch torchvision torchaudio pytorch-cuda=11.8 -c pytorch -c nvidia


# COPY root /

# ENTRYPOINT [ "/usr/bin/make","-f","/Makefile" ]
