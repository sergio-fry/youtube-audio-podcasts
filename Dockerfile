FROM node:7.5

# Based on yt-audio-to-podcast 
# https://github.com/danielpgross/yt-audio-to-podcast

ENV REVISION f610847
ENV REPO https://github.com/danielpgross/yt-audio-to-podcast.git

RUN mkdir /app
WORKDIR /app

RUN git clone $REPO /app && git checkout $REVISION 

RUN npm install

RUN awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list

RUN apt-get update && apt-get install -y ffmpeg

EXPOSE 80

CMD ["node", "server.js"]
