## Container base:
https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/

## Vivado on Apple silicon:
https://github.com/ichi4096/vivado-on-silicon-mac

## Container first launch and Vivado installation:
1) Download Xilinx official WebVersion Linux installer. Copy it to the root of the repo.

2) Build the container and launch it with the specified ports

```sh
docker build -t me_vivado_apple .

docker run --rm --name vivado_container -p 45901:5901 -p 46901:6901  \
--mount type=bind,source="/Users/$USER/Downloads/vivado-on-silicon-mac-main",target="/home/user" \
docker.io/library/me_vivado_apple
```

3) In the separate console session connect to the running container. For that execute
```docker ps```
You'll see the running **CONTAINER ID**. Connect to the docker container:
```docker exec -it id_of_the_container /bin/bash```

4) Extract installer to **/home/user/installer**

```sh
/home/user/Xilinx_Unified_2023.1_0507_1903_Lin64.bin --target /home/user/installer --noexec
```

4) If the custom configuration is required - generate config. By default the install_config.txt can be used.

```sh
/home/user/installer/xsetup -b ConfigGen
```

5) Generate your auth token. You'll be promted to enter you e-mail and password for AMD account.

```sh
/home/user/installer/xsetup  -b AuthTokenGen
```

6) Start the installation

```sh
/home/user/installer/xsetup --agree XilinxEULA,3rdPartyEULA -b Install -c /home/user/install_config.txt
```


## Vivado tool launch
```sh
/home/user/Xilinx/Vivado/*/settings64.sh
/home/user/Xilinx/Vivado/*/bin/vivado
```

## Litex example build for EBAZ4205 board with X5 crystal for PL soldered
```sh
export LITEX_ENV_VIVADO=/home/user/Xilinx/Vivado/2023.1/
python3 -m litex_boards.targets.ebaz4205 --build --output-dir=/home/user/litex_bulild
```

## Programmer setup:
1) Build the repo:
https://github.com/jiegec/jtag-remote-server

```
system_profiler SPUSBDataType
./jtag-remote-server -p 6010 -x
host.docker.internal
```
TODO: describe the flashing flow in detail

## Zephyr simple test
1)
```sh
source /home/zephyr_setup/zephyr/zephyr-env.sh 
cmake -DBOARD=qemu_riscv32 $ZEPHYR_BASE/samples/hello_world
```

## Screenshots
### Sample design with ZYNQ Processing System IP
![telegram-cloud-photo-size-2-5339203163284164374-y](https://github.com/ValentiWorkLearning/vivado-on-silicon-mac_with_vnc/assets/25596072/87c143ea-fddd-4f9a-b6a7-7a1b44909331)

### Implemented design with the generated bitstream
![telegram-cloud-photo-size-2-5339203163284164394-y](https://github.com/ValentiWorkLearning/vivado-on-silicon-mac_with_vnc/assets/25596072/002345ab-39d8-46da-af2b-52e82f00c319)

