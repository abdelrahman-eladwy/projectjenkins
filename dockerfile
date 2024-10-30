

# Stage 1: Build Stage
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /react-docker-example

# Add and extract the repository directly using ADD
ADD https://github.com/abdelrahman-eladwy/react-docker-example/archive/refs/heads/main.zip ./

# Install unzip and extract the project files
RUN apk add --no-cache unzip && \
    unzip main.zip && \
    mv react-docker-example-main/* . && \
    rm -rf react-docker-example-main main.zip

# Install dependencies
RUN npm install

# Build the application
RUN npm run build

# Stage 2: Production Stage (using a lightweight server)
FROM nginx:alpine

# Copy the built React app from the builder stage
COPY --from=builder /react-docker-example/build /usr/share/nginx/html

# Expose the default HTTP port
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
