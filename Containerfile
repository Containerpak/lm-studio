FROM ubuntu:26.04 AS source

ADD --checksum=sha256:1014376d89d668c3814cd20e2b146a076146760ded1ef07b968fb61c58ded355 https://installers.lmstudio.ai/linux/x64/0.4.21-2/LM-Studio-0.4.21-2-x64.AppImage /tmp/app.AppImage

RUN chmod 0755 /tmp/app.AppImage && \
    cd /tmp && \
    ./app.AppImage --appimage-extract >/dev/null && \
    mkdir -p /stage && \
    cp -a /tmp/squashfs-root/. /stage/

FROM ghcr.io/containerpak/mesa64:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/lm-studio"

COPY --from=source /stage/ /opt/lm-studio/
COPY lm-studio /usr/bin/lm-studio
COPY lm-studio.desktop /usr/share/applications/lm-studio.desktop
COPY icon.png /usr/share/icons/hicolor/128x128/apps/lm-studio.png

RUN chmod 0755 /usr/bin/lm-studio && cpak-clean-junk

