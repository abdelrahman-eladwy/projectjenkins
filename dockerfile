FROM node:18-alpine
WORKDIR /react-docker-example
COPY ./react-docker-example/package*.json ./
COPY ./react-docker-example/ ./
RUN npm install
CMD ["npm", "start"]
