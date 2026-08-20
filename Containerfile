FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/lm-studio"

RUN apt-get update && \
    apt-get install -y --no-install-recommends libnspr4 libnss3 && \
    mkdir -p /usr/share/icons/hicolor/128x128/apps && \
    ln -sf /usr/share/icons/hicolor/0x0/apps/lm-studio.png /usr/share/icons/hicolor/128x128/apps/lm-studio.png && \
    cpak-clean-junk

COPY lm-studio /usr/bin/lm-studio
COPY lm-studio.desktop /usr/share/applications/lm-studio.desktop

RUN chmod 0755 /usr/bin/lm-studio
