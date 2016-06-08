FROM weidazhao/buildaspnetcore:base

COPY docker-build.sh /usr/local/bin

RUN chmod +x /usr/local/bin/docker-build.sh

ONBUILD ARG DOCKER_IMAGE_REPOSITORY

ONBUILD ARG DOCKER_IMAGE_TAG

ONBUILD ARG DOCKERFILE_PATH

ONBUILD ARG PROJECT_NAME

ONBUILD ARG BUILD_CONFIGURATION

ONBUILD RUN mkdir /args \
            && echo $DOCKER_IMAGE_REPOSITORY > /args/DOCKER_IMAGE_REPOSITORY \
            && echo $DOCKER_IMAGE_TAG > /args/DOCKER_IMAGE_TAG

ONBUILD WORKDIR /$PROJECT_NAME

ONBUILD COPY $PROJECT_NAME/project.json $PROJECT_NAME/package.json ./

ONBUILD RUN dotnet restore && npm install

ONBUILD COPY $PROJECT_NAME/ ./

ONBUILD RUN dotnet publish -c $BUILD_CONFIGURATION -o /app

ONBUILD COPY $DOCKERFILE_PATH /app/Dockerfile

ENTRYPOINT docker-build.sh