FROM debian:8

MAINTAINER Romain Ballan <ballan.romain@gmail.com>

# install Java
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list \
    && echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get update && apt-get install -y \
        oracle-java8-installer


# Download the jar
RUN apt-get update && apt-get install -y \
        curl

ENV MINECRAFT_VERSION 1.8.8
RUN curl -fSL https://s3.amazonaws.com/Minecraft.Download/versions/$MINECRAFT_VERSION/minecraft_server.$MINECRAFT_VERSION.jar -O

# Accept EULA
RUN echo "# Generated via Docker on $(date)" > eula.txt \
    && echo "eula=TRUE" >> eula.txt

EXPOSE 25565
CMD java -jar minecraft_server.$MINECRAFT_VERSION.jar nogui