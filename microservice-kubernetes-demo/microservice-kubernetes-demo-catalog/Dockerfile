FROM openjdk:11.0.2-jre-slim
# FROM openjdk:11.0.15-jre-slim
# FROM openjdk:21-jdk-slim-buster

# Creazione di un utente non privilegiato
RUN groupadd -r non_privileged_group && useradd -r -g non_privileged_group non_privileged_user

COPY target/microservice-kubernetes-demo-catalog-0.0.1-SNAPSHOT.jar .

# Impostazione dei permessi corretti per il file dell'applicazione
RUN chown non_privileged_user:non_privileged_group microservice-kubernetes-demo-catalog-0.0.1-SNAPSHOT.jar

# Impostazione dell'utente non privilegiato come utente predefinito
USER non_privileged_user

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://localhost:8080/ || exit 1

CMD /usr/bin/java -Xmx400m -Xms400m -jar microservice-kubernetes-demo-catalog-0.0.1-SNAPSHOT.jar

EXPOSE 8080
