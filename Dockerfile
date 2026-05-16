# Stage 1: build & test
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run lint && npm test

# Stage 2: production image
FROM node:20-alpine AS production
WORKDIR /app
ENV NODE_ENV=production
COPY package*.json ./
RUN npm ci --only=production
COPY src/ ./src/
EXPOSE 3000
USER node
CMD ["node", "src/index.js"]
