# Base image
FROM node:14

# Set working directory
WORKDIR /myapp

# Install dependencies
COPY package*.json ./
RUN npm install express --save

# Copy source code
COPY . .

# Expose port
EXPOSE 3000

# Start the application..
CMD ["node", "app.js"]
