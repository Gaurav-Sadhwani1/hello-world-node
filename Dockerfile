# Base image
FROM node:14

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm i --lockfile-version 3 --package-lock-only

# Copy source code
COPY . .

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
