# Étape 1 : Construire l'application
FROM node:18 AS build

# Créer et aller dans le dossier de l'app
WORKDIR /app

# Copier package.json et installer les dépendances
COPY package*.json ./
RUN npm install --only=production

# Copier tout le reste du code
COPY . .

# Étape 2 : Image finale
FROM node:18-slim

WORKDIR /app

# Copier depuis l'étape de build
COPY --from=build /app /app

# Exposer le port (change si ton app écoute sur un autre port)
EXPOSE 3000

# Lancer l'app
CMD ["npm", "start"]
