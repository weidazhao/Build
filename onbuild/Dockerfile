FROM weidazhao/buildaspnetcore:latest

COPY docker-build.sh /usr/local/bin

ONBUILD ARG IMAGE_NAME

ONBUILD ARG PROJECT_NAME

ONBUILD ARG BUILD_CONFIGURATION

ONBUILD WORKDIR /$PROJECT_NAME

ONBUILD COPY ./project.json .

ONBUILD RUN dotnet restore

ONBUILD COPY . .

ONBUILD RUN dotnet publish -c $BUILD_CONFIGURATION -o /app

ENTRYPOINT ["docker-build.sh" "$PROJECT_NAME" "$IMAGE_NAME"]