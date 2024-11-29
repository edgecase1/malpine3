.PHONY: all

all: hacksudo malpine3

hacksudo: execbusyboxsh.c
	gcc -o hacksudo execbusyboxsh.c

hacksudo_musl: execbusyboxsh.c
	musl-gcc -o hacksudo execbusyboxsh.c

malpine3:
	docker build . --squash -f Dockerfile -t malpine3
	docker save -o malpine3.tar malpine3
	mkdir -p extracted ; rm -rf extracted && mkdir -p extracted
	tar -C extracted -xvpf malpine3.tar 
	mkdir -p rootfs ; rm -rf rootfs && mkdir -p rootfs
	tar -C rootfs -xpf extracted/*/layer.tar
	chown root:root rootfs/bin/hacksudo && sudo chmod 1755 rootfs/bin/hacksudo && stat rootfs/bin/hacksudo
	tar -C rootfs -cvpf malpine3_repacked.tar . 
	docker image load -i malpine3_repacked.tar


