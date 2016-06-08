FROM ubuntu:14.04

# Install cURL and Git
RUN apt-get update \
    && apt-get install -y curl git		

# Install Docker: https://github.com/docker-library/docker/blob/master/1.11/Dockerfile

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.11.2
ENV DOCKER_SHA256 8c2e0c35e3cda11706f54b2d46c2521a6e9026a7b13c7d4b8ae1f3a706fc55e1

RUN set -x \
	&& curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz" -o docker.tgz \
	&& echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& docker -v

# Install .NET CLI dependencies and .NET Core SDK: https://github.com/dotnet/dotnet-docker/blob/master/1.0.0-preview1/Dockerfile

# Work around https://github.com/dotnet/cli/issues/1582 until Docker releases a
# fix (https://github.com/docker/docker/issues/20818). This workaround allows
# the container to be run with the default seccomp Docker settings by avoiding
# the restart_syscall made by LTTng which causes a failed assertion.
ENV LTTNG_UST_REGISTER_TIMEOUT 0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        clang-3.5 \
        libc6 \
        libcurl3 \
        libgcc1 \
        libicu52 \
        liblttng-ust0 \
        libssl1.0.0 \
        libstdc++6 \
        libtinfo5 \
        libunwind8 \
        libuuid1 \
        zlib1g \
    && rm -rf /var/lib/apt/lists/*

ENV DOTNET_CORE_SDK_VERSION 1.0.0-preview1-002702
RUN curl -SL https://dotnetcli.blob.core.windows.net/dotnet/beta/Binaries/$DOTNET_CORE_SDK_VERSION/dotnet-dev-debian-x64.$DOTNET_CORE_SDK_VERSION.tar.gz --output dotnet.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf dotnet.tar.gz -C /usr/share/dotnet \
    && rm dotnet.tar.gz \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet

# Install Node.js, Bower and Gulp: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
    && apt-get install -y nodejs
    && npm install -g bower
    && npm install -g gulp

CMD ["sh"]
