FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .

# Stage de production
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV=production

# Copier les fichiers construits / sources depuis le builder
COPY --from=builder /app ./

# Installer uniquement les dépendances de production
RUN npm ci --omit=dev

EXPOSE 5173

# Commande de démarrage : utilise "npm start" (assurez-vous que package.json contient un script "start")
CMD ["npm", "start"]