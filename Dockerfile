# Base image
FROM node:22

# Set working directory
WORKDIR /app

# Install dependencies
COPY myapp/package.json ./ 
RUN npm install

# Copy source code
COPY myapp/ ./ 

# Expose port
EXPOSE 3000

# Start the application..
CMD ["node", "app.js"]
