# syntax=docker/dockerfile:1

FROM openjdk:16-alpine3.13

WORKDIR /sample-app

COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline

FROM docker
COPY --from=docker/buildx-bin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
RUN docker buildx version

COPY src ./src

CMD ["./mvnw", "spring-boot:run"]