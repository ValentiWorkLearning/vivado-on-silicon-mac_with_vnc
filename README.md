## Container base:
https://hub.docker.com/r/accetto/ubuntu-vnc-xfce/

## Vivado on Apple Silicon:
https://github.com/ichi4096/vivado-on-silicon-mac

## Container launch:
docker run --rm --name vivado_container -p 45901:5901 -p 46901:6901  --mount type=bind,source="/Users/username/Downloads/vivado-on-silicon-mac-main",target="/home/user" docker.io/library/me_vivado_apple