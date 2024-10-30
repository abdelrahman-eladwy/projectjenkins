FROM node:18-alpine
WORKDIR /react-docker-example
COPY package*.json ./
RUN npm install
COPY . .
CMD ["npm", "start"]
