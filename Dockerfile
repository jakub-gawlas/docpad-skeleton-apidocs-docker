FROM node:7.7.4
RUN apt-get update && \
    apt-get install -y git-core
RUN git clone https://github.com/hybris/docpad-skeleton-apidocs.git
WORKDIR /docpad-skeleton-apidocs
RUN npm install -g bower gulp docpad --silent
RUN npm install --silent && \
    bower install -f --allow-root && \
    npm run copy:modernizr && \
    npm run copy:zeroclipboard && \
    npm run build:lunrplugin && \
    gulp getDependencyInteractiveDocu
RUN mkdir ./registry
COPY resources/registry ./registry
RUN apt-get install -y python python-pyinotify python-yaml
RUN mkdir /watcher && mkdir ~/.watcher
COPY resources/watcher /watcher
RUN chmod +x /watcher/watcher.py
RUN cp /watcher/jobs.yml ~/.watcher/
RUN mkdir /docu-src
RUN docpad generate
EXPOSE 9778
VOLUME /docu-src
CMD npm run init -- -l './registry' && \
         /watcher/watcher.py start && \
         docpad run
