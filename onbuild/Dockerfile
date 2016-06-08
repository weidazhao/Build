FROM weidazhao/buildaspnetcore:base

COPY docker-build.sh /usr/local/bin

RUN chmod +x /usr/local/bin/docker-build.sh

ONBUILD ARG IMAGE_NAME

ONBUILD ARG PROJECT_NAME

ONBUILD ARG BUILD_CONFIGURATION

ONBUILD WORKDIR /$PROJECT_NAME

ONBUILD COPY ./project.json ./package.json ./

ONBUILD RUN dotnet restore && npm install

ONBUILD COPY . .

ONBUILD RUN dotnet publish -c $BUILD_CONFIGURATION -o /app

ONBUILD RUN echo $PROJECT_NAME > /tmp/project_name && echo $IMAGE_NAME > /tmp/image_name

ENTRYPOINT docker-build.sh