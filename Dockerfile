FROM node:20-alpine as dev
WORKDIR /app
COPY package*.json ./
RUN npm install
CMD ["npm", "start"]


FROM node:20-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

