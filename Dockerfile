FROM ubuntu:16.04

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
	apt-get install --no-install-recommends -y \
		curl=7.47.0-1ubuntu2.14 \
		ca-certificates=20170717~16.04.2 && \
	rm -rf /var/lib/apt/lists/*

RUN curl -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
	echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
	apt-get update && \
	apt-get install --no-install-recommends -y \
		'google-chrome-stable=80.0.3987.116-1' && \
	rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get update && \
	apt-get install --no-install-recommends -y \
		nodejs=10.19.0-1nodesource1 && \
	rm -rf /var/lib/apt/lists/*
RUN npm install -g \
	chrome-headless-render-pdf@1.8.4

RUN mkdir /tmp/html-to-pdf
WORKDIR /tmp/html-to-pdf

ENTRYPOINT ["/usr/bin/chrome-headless-render-pdf", "--chrome-option=--no-sandbox"]
