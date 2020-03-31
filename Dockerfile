FROM ceph/ceph:v14.2

ENV GOPATH="/go/"


WORKDIR "/go"
# Copy source directories
#COPY . "${SRCDIR}/"
#RUN yum install -y libcephfs-devel librados-devel librbd-devel /usr/bin/cc /usr/bin/c++ make
# Build executable
ENV CGO_ENABLED=1
RUN yum install golang -y 
RUN export PATH=$PATH:$GOROOT/bin
COPY main.go main.go
RUN go build main.go

RUN ./main
ENTRYPOINT ["#!/bin/bash"]
