FROM nvidia/cuda:12.0.0-cudnn8-runtime-ubuntu22.04

RUN rm -rf /etc/apt/sources.list.d/*.list \
    && apt update \
    && apt install -y tzdata \
    && apt -y install git \
    && apt -y install make \
    && apt -y install wget \
    && apt -y install  vim \
    && apt -y install unzip \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b

ENV PATH="/root/miniconda3/bin:${PATH}"

RUN conda init bash \
    && . ~/.bashrc \
    && conda create -n dig -c main python=3.10 \
    && conda activate dig \
    && pip install https://raw.githubusercontent.com/AwaleSajil/ghc/master/ghc-1.0-py3-none-any.whl \
    && pip install librosa numpy opencv-contrib-python opencv-python torch torchvision tqdm numba \
    && pip install -q youtube-dl \
    && pip install ffmpeg-python \
    && pip install librosa==0.9.1 \
    && conda install -c conda-forge ffmpeg=5.1.2 \
    && mkdir /tools \
    && cd /tools \
    && wget https://github.com/sczhou/CodeFormer/archive/refs/heads/master.zip -O CodeFormer.zip \
    && unzip CodeFormer.zip \
    && cd CodeFormer \
    && python basicsr/setup.py develop

# COPY root /

# ENTRYPOINT [ "/usr/bin/make","-f","/Makefile" ]
