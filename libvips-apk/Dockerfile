FROM gliderlabs/alpine:3.4

ARG HTTP_PROXY
ENV USERNAME alpine-sdk

RUN \
    apk --update add alpine-sdk \
    && addgroup -S ${USERNAME} \
    && adduser -S -h /home/${USERNAME} ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && addgroup ${USERNAME} abuild

COPY etc/ /etc/
USER $USERNAME
RUN \
  sudo chown -R ${USERNAME}:${USERNAME} /home/${USERNAME} \
  && sudo addgroup ${USERNAME} abuild \
  && sudo mkdir -p /var/cache/distfiles \
  && sudo chgrp abuild /var/cache/distfiles \
  && sudo chmod g+w /var/cache/distfiles \
  && abuild-keygen -a -i -n

WORKDIR /home/${USERNAME}
ENV LIBVIPS_VERSION=8.3.1 \
    LIBVIPS_SHA256=09cb7f8d5640c7693bae07080202de0cead60c668e086f2739248bacd40a1006

COPY APKBUILD /home/${USERNAME}/libvips/
RUN sudo chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# RUN cd libvips && abuild -r -u
