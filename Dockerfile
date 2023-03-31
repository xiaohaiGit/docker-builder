FROM nvidia/cuda:11.2.2-cudnn8-runtime-ubuntu20.04

RUN rm -rf /etc/apt/sources.list.d/*.list \
    && apt update && apt install -y tzdata make wget ffmpeg vim -y  \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b

ENV PATH="/root/miniconda3/bin:${PATH}"

RUN conda init bash \
    && . ~/.bashrc \
    && conda create -n dig -c main python=3.7 cudnn=7.6.5 cudatoolkit=10.2 \
    && conda activate dig \
    && pip3 install numba==0.48 librosa==0.7.0 numpy==1.19.3 scipy==1.4.1 resampy==0.3.1 tf2onnx==1.9.3 tensorflow-gpu==2.4.0 protobuf==3.20.3 \
       h5py==2.10.0 scikit-image==0.14.2 tqdm opencv-python ffmpeg-python numexpr colorama chardet \
    && conda install pytorch==1.12.1 torchvision==0.13.1 torchaudio==0.12.1 cudatoolkit=10.2 -c pytorch \
    && conda install ffmpeg -y


# COPY root /

# ENTRYPOINT [ "/usr/bin/make","-f","/Makefile" ]
