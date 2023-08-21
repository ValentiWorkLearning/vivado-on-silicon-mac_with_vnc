# Container for running Vivado on M1/M2 macs
# though it should work equally on Intel macs
FROM --platform=linux/amd64 accetto/ubuntu-vnc-xfce
RUN apt update && apt upgrade -y

# install gui
RUN apt install -y --no-install-recommends --allow-unauthenticated \
dbus dbus-x11 x11-utils xorg alsa-utils mesa-utils net-tools \
libgl1-mesa-dri gtk2-engines lxappearance fonts-droid-fallback sudo firefox \
ubuntu-gnome-default-settings ca-certificates curl gnupg lxde arc-theme \
gtk2-engines-murrine gtk2-engines-pixbuf gnome-themes-standard nano xterm

# dependencies for Vivado
RUN apt install -y --no-install-recommends --allow-unauthenticated \
python3-pip python3-dev build-essential git gcc-multilib g++ \
ocl-icd-opencl-dev libjpeg62-dev libc6-dev-i386 graphviz make \
unzip libtinfo5 xvfb libncursesw5 locales libswt-gtk-4-jni


# buildroot dependencies
RUN apt-get install -y git build-essential fakeroot libncurses5-dev libssl-dev ccache
RUN apt-get install -y dfu-util u-boot-tools device-tree-compiler libssl1.0-dev mtools
RUN apt-get install -y bc python cpio zip unzip rsync file wget


RUN apt-get install -y \
    build-essential \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    cpio \
    g++ \
    gcc \
    git \
    gzip \
    locales \
    libncurses5-dev \
    libdevmapper-dev \
    libsystemd-dev \
    make \
    mercurial \
    whois \
    patch \
    perl \
    python3 \
    rsync \
    sed \
    tar \
    vim \ 
    unzip \
    wget \
    bison \
    flex \
    libssl-dev \
    libfdt-dev \
    file


# Litex framework dependencies
RUN mkdir -p /home/litex_setup
WORKDIR /home/litex_setup
RUN apt install -y libevent-dev libjson-c-dev verilator zlib1g-dev 
RUN locale-gen en_US.utf8
RUN wget https://github.com/stnolting/riscv-gcc-prebuilt/releases/download/rv32i-4.0.0/riscv32-unknown-elf.gcc-12.1.0.tar.gz
RUN mkdir /opt/riscv
RUN tar -xzf riscv32-unknown-elf.gcc-12.1.0.tar.gz -C /opt/riscv/
ENV PATH="$PATH:/opt/riscv/bin"

RUN echo 'alias python=python3' > ~/.bashrc

RUN wget https://bootstrap.pypa.io/pip/3.6/get-pip.py
RUN python3 get-pip.py
RUN git clone https://github.com/stnolting/neorv32.git

## Litex installation
RUN wget https://raw.githubusercontent.com/enjoy-digital/litex/master/litex_setup.py
RUN chmod +x litex_setup.py
RUN ./litex_setup.py --init --install --user root --config=full
RUN ./litex_setup.py --update
RUN pip3 install meson ninja


ENV PATH="$PATH:/root/.local/bin"

# create user "user" with password "pass"
RUN useradd --create-home --shell /bin/bash --user-group --groups adm,sudo user
RUN sh -c 'echo "user:pass" | chpasswd'
# RUN cp -r /root/{.config,.gtkrc-2.0,.asoundrc} /home/user
RUN chown -R user:user /home/user
RUN mkdir -p /home/user/.config/pcmanfm/LXDE/
RUN ln -sf /usr/local/share/doro-lxde-wallpapers/desktop-items-0.conf \
/home/user/.config/pcmanfm/LXDE/

# Set the locale, because Vivado crashes otherwise
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
WORKDIR /dockerstartup