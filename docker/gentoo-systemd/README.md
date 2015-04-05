# gentoo systemd docker image

## usage

        git clone https://github.com/gentoo/gentoo-docker-images
        cd gentoo-docker-images/amd64
        bash -ex build.sh

        cd ../../
        docker build -t gentoo-systemd
        docker exec -i -t $(docker run -t --cap-add=SYS_ADMIN -d gentoo-systemd /usr/lib/systemd/systemd) bash
