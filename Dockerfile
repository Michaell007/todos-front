# Étape 1 : Build du projet
FROM node:18-alpine AS build
WORKDIR /app

# Copier les dépendances
COPY package*.json ./
RUN npm install

# Copier tout le code
COPY . .

# Build de l'app
RUN npm run build


# Étape 2 : Image légère avec NGINX
FROM nginx:stable-alpine

# Copier le build dans nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copier une configuration nginx personnalisée (optionnel)
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
