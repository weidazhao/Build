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

# Install .NET Core SDK: https://www.microsoft.com/net/core#ubuntu

RUN sh -c 'echo "deb [arch=amd64] https://apt-mo.trafficmanager.net/repos/dotnet/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list' \ 
    && apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 \
    && apt-get update \
    && apt-get install dotnet-dev-1.0.0-preview1-002702

# Install Node.js, Bower and Gulp: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - \
    && apt-get install -y nodejs \
    && npm install -g bower \
    && npm install -g gulp

CMD ["sh"]
