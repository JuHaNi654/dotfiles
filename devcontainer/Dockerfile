# syntax=docker/dockerfile:1
FROM ubuntu:26.04@sha256:b7f48194d4d8b763a478a621cdc81c27be222ba2206ca3ca6bc42b49685f3d9e

ENV DEBIAN_FRONTEND=noninteractive

# User
ARG USERNAME=devcontainer
ARG USER_UID=1001
ARG USER_GID=$USER_UID

# Versions
ARG NODE_VERSION=24.18.0
ARG GO_VERSION=1.26.4
ARG BUN_VERSION=1.3.14

# Update system
RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
    locales \
    git \
    curl \
    ca-certificates \
    sudo \
    tmux \
    wget \
    xz-utils \
    rsync \
    unzip && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/lists/*

# Install nodejs 
RUN mkdir -p /usr/local/lib/nodejs && \
    wget -qO- "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" | \
    tar -xJv -C /usr/local/lib/nodejs --strip-components=1

# Install nvim 
RUN mkdir -p /usr/local/lib/nvim && \
    wget -qO- "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz" | \
    tar -xzvf - -C /usr/local/lib/nvim --strip-components=1

# Install go
RUN mkdir -p /usr/local/lib/go && \
    wget -qO- "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" | \
    tar -xzvf - -C /usr/local/lib/go --strip-components=1

RUN mkdir -p /usr/local/lib/bun/bin && \
    wget -q "https://github.com/oven-sh/bun/releases/download/bun-v${BUN_VERSION}/bun-linux-x64.zip" && \
    unzip bun-linux-x64 && mv bun-linux-x64/bun /usr/local/lib/bun/bin/ && \
    rm -rf bun-linux-x64 bun-linux-x64.zip

ENV PATH="/usr/local/lib/nodejs/bin:\
/usr/local/lib/nvim/bin:\
/usr/local/lib/go/bin:\
/usr/local/lib/bun/bin:\
${PATH}"

RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

RUN groupadd --gid $USER_GID $USERNAME && \
    useradd --uid $USER_UID --gid $USER_GID -m -s /bin/bash $USERNAME && \
    echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

CMD ["/bin/bash"]
