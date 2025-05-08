FROM node:16-alpine
WORKDIR /opt
COPY . .
RUN npm install
ENTRYPOINT ["npm", "run", "start"]