FROM alpine:3.8

RUN apk update \
 && apk add python py-pip py-setuptools git ca-certificates \
 && pip install python-dateutil

RUN git clone https://github.com/s3tools/s3cmd.git /opt/s3cmd \
 && ln -s /opt/s3cmd/s3cmd /usr/bin/s3cmd

WORKDIR /opt

ADD ./files/s3cfg /opt/.s3cfg
ADD ./files/main.sh /opt/main.sh

# Main entrypoint script
RUN chmod 777 /opt/main.sh

# Folders for s3cmd optionations
RUN mkdir /opt/src \
 && mkdir /opt/dest

WORKDIR /
CMD ["/opt/main.sh"]
