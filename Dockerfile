FROM osrf/ros:humble-desktop-full

ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all

# 1. Dependencias nativas del sistema, OpenGL, X11 y compiladores
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    pkg-config \
    libgl1-mesa-dev \
    libgl1-mesa-glx \
    libglew-dev \
    libglfw3-dev \
    libx11-dev \
    libxcursor-dev \
    libxinerama-dev \
    libxi-dev \
    libxrandr-dev \
    libyaml-cpp-dev \
    libsdl2-dev \
    libsdl2-image-dev \
    libsdl2-mixer-dev \
    libsdl2-ttf-dev \
    python3-pip \
    python3-dev \
    python3-setuptools \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Toda la pila de Python: MuJoCo, Pygame, DDS, RL y utilidades
RUN pip3 install --no-cache-dir \
    mujoco \
    pygame \
    PyYAML \
    cyclonedds==0.10.2 \
    numpy \
    rich \
    gymnasium \
    torch \
    stable-baselines3 \
    opencv-python

# 3. Clonar e instalar globalmente unitree_sdk2_python en el sistema
RUN git clone https://github.com/unitreerobotics/unitree_sdk2_python.git /opt/unitree_sdk2_python \
    && pip3 install --no-cache-dir /opt/unitree_sdk2_python \
    && rm -rf /opt/unitree_sdk2_python/.git

WORKDIR /workspace

# 4. Setup de ROS 2 en bashrc
RUN echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc

CMD ["/bin/bash"]
