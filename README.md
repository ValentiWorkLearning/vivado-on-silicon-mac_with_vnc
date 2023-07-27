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