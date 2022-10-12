FROM node:14

RUN echo "UTC" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata


WORKDIR /usr/src

COPY [".", "/usr/src"]

RUN npm install 

EXPOSE 80

CMD npm start