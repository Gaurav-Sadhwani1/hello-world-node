# Base image
FROM node:14

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm i --lockfile-version 3 --package-lock-only
RUN npm install express --save

# Copy source code
COPY . .

# Expose port
EXPOSE 3000

# Start the application..
CMD ["node", "app.js"]
