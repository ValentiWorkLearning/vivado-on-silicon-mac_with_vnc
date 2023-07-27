## Container base:
https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/

## Vivado on Apple silicon:
https://github.com/ichi4096/vivado-on-silicon-mac

## Container launch:
1) Follow the guiline installation from the base repository https://github.com/ichi4096/vivado-on-silicon-mac and install the Vivado tool according to README.
Please note, that it's not necessary to setup the XQuartz application for this purpouse


2) Build the container and launch it with the specified ports
```shell
docker build -t me_vivado_apple .

docker run --rm --name vivado_container -p 45901:5901 -p 46901:6901  --mount type=bind,source="/Users/username/Downloads/vivado-on-silicon-mac-main",target="/home/user" docker.io/library/me_vivado_apple

```

3) Open container shell and execute:
```shell
/home/user/Xilinx/Vivado/*/settings64.sh
/home/user/Xilinx/Vivado/*/bin/vivado
```

## Screenshots
### Sample design with ZYNQ Processing System IP
![telegram-cloud-photo-size-2-5339203163284164374-y](https://github.com/ValentiWorkLearning/vivado-on-silicon-mac_with_vnc/assets/25596072/87c143ea-fddd-4f9a-b6a7-7a1b44909331)

### Implemented design with the generated bitstream
![telegram-cloud-photo-size-2-5339203163284164394-y](https://github.com/ValentiWorkLearning/vivado-on-silicon-mac_with_vnc/assets/25596072/002345ab-39d8-46da-af2b-52e82f00c319)

