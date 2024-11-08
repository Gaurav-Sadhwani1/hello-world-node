# Base image
FROM node:22

# Set working directory
WORKDIR /myapp

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Expose port
EXPOSE 3000

# Start the application..
CMD ["node", "myapp/app.js"]
