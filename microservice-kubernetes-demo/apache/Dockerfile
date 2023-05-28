FROM ubuntu:20.04

# Update Ubuntu
# Ho sostituito questa riga: RUN apt-get update ; apt-get dist-upgrade -y -qq 
RUN apt-get update ; apt-get upgrade -y -qq

# Install Apache + modules
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y -qq --no-install-recommends apache2 && \
    a2enmod proxy proxy_http proxy_ajp rewrite deflate headers proxy_connect proxy_html lbmethod_byrequests && \
    mkdir /var/lock/apache2 && mkdir /var/run/apache2

# Create non-root user
RUN groupadd -r non_privileged_group && useradd -r -g non_privileged_group non_privileged_user

# Config Apache
COPY index.html /var/www/html/index.html
COPY 000-default.conf  /etc/apache2/sites-enabled/000-default.conf

# Impostazione dei permessi corretti per i file e le directory
# RUN chown -R non_privileged_user:non_privileged_group /var/www/html

# Impostazione dell'utente non privilegiato come utente predefinito
USER non_privileged_user 

HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl --fail http://localhost:8080/ || exit 1

EXPOSE 80
CMD apache2ctl -D FOREGROUND
