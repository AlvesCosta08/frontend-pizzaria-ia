# --- Estágio de desenvolvimento ---
FROM node:20-alpine as dev
WORKDIR /app
COPY package*.json ./
RUN npm install
CMD ["npm", "start"]

# --- Estágio de build ---
FROM node:20-alpine as build
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# --- Estágio de produção ---
FROM nginx:alpine AS prod
# Copia a pasta de construção gerada no estágio 'build' para o diretório padrão do Nginx
COPY --from=build /app/dist /usr/share/nginx/html 
# Expõe a porta 80 (padrão para Nginx)
EXPOSE 80
# O Nginx inicia automaticamente com o CMD padrão dele

