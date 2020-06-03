FROM openjdk:13-alpine
VOLUME /tmp
ENV TZ=Europe/Madrid
RUN ln -snf "/usr/share/zoneinfo/$TZ/" "etc/localtime" && echo "$TZ" > "/etc/timezone"
ADD target/spring-boot-ab-deployment-0.0.1-SNAPSHOT.jar spring-boot-ab-deployment.jar
EXPOSE 8080
CMD ["java","-Djava.security.egd=file:/dev/./urandom","-jar","spring-boot-ab-deployment.jar"]
