#Base image is ubuntu
FROM ubuntu

#The leet maintainer
MAINTAINER shubham golam <shubhamgolam10@gmail.com>

#Arguments
ARG DEBIAN_FRONTEND=noninteractive

#Environment Variables

ENV home /root
ENV GOROOT /usr/local/go
ENV GOPATH ${home}/go
ENV PATH ${GOPATH}/bin:${GOROOT}/bin:${PATH}
ENV TZ=Asia/kolkata

#Working Directory

WORKDIR ${home}

#Make directories for tools and wordlists

RUN mkdir ${home}/tools && mkdir ${home}/wordlists && mkdir ${home}/go

#Install essentials

RUN apt-get -y update && apt-get -y install curl \

        wget \
        vim \
              tar  \
                                nano \
                                python \
                                python3 \
                                python3-pip \
                                whois \
                                awscli \
                                git \
                                make \
                                nano \
                                dirb \
                                dnsrecon \
                                libpcap-dev


#Install GO
RUN wget --no-verbose --show-progress --progress=bar:force:noscroll "https://go.dev/dl/$(curl 'https://go.dev/VERSION?m=text').linux-amd64.tar.gz"
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.linux-amd64.tar.gz

#Nuclie-template

RUN cd ${home}/wordlists && git clone https://github.com/projectdiscovery/nuclei-templates.git


#Install Tools

#---subdomians---

#assetfinder
RUN go install -v github.com/tomnomnom/assetfinder@latest

#subfinder
RUN go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

#sublist3r
RUN cd ${home}/tools && git clone https://github.com/aboul3la/Sublist3r.git && \
                cd Sublist3r && pip install -r requirements.txt

#knock
RUN cd ${home}/tools && git clone https://github.com/guelfoweb/knock.git && \
cd knock && pip3 install -r requirements.txt

#httpx
RUN go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

#waybackurls
RUN go install -v github.com/tomnomnom/waybackurls@latest

#anew
RUN go install -v github.com/tomnomnom/anew@latest

#ffuf
RUN go install -v github.com/ffuf/ffuf@latest

#naabu

RUN go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

#nuclie
RUN go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest