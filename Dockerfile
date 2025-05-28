FROM openjdk:8
LABEL org.opencontainers.image.authors="Lucas Williams <wililupy@lucaswilliams.net>" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.description="Broadview Analytics Java Application from Broadcom running as a Container"

RUN apt update && apt upgrade -y && apt install git libxext6 libxrender1 libxtst6 -y
RUN git clone https://github.com/wililupy/Broadview-Analytics.git

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

WORKDIR /Broadview-Analytics/bin
RUN mkdir -p pcap 

ENV DISPLAY=:0

EXPOSE 8080
EXPOSE 9070
VOLUME ["/Broadview-Analytics/bin/pcap", "Broadview-Analytics/bin/switchdetails"]

ENTRYPOINT ["java", "-jar", "broadview-analytics.jar"]
