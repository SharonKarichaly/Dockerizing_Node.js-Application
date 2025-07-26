# ===== Stage 1: Build the app =====
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /home/sharon/nodesjsapp

# Install dependencies
COPY package*.json ./
RUN npm install --production

# Copy source files
COPY . .

# ===== Stage 2: Run with distroless =====
FROM gcr.io/distroless/nodejs18

# Set working directory
WORKDIR /home/sharon/nodesjsapp

# Copy only necessary files from builder stage
COPY --from=builder /home/sharon/nodesjsapp /home/sharon/nodesjsapp

# Expose application port
EXPOSE 3000

# Run app
CMD ["app.js"]

