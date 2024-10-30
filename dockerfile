FROM node:18-alpine

# Install git
RUN apk add --no-cache git

WORKDIR /react-docker-example

# Clone the GitHub repository
ADD https://github.com/abdelrahman-eladwy/react-docker-example.git .

RUN npm install


# Start the application
CMD ["npm", "start"]
