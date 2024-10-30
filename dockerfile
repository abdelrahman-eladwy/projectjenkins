FROM node:18-alpine
WORKDIR /react-docker-example
COPY ./react-docker-example/package*.json ./
RUN npm install
COPY ./react-docker-example/ ./
CMD ["npm", "start"]
