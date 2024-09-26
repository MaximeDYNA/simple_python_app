# Utiliser une image de base officielle Python
FROM python:3.8-slim

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier requirements.txt dans le répertoire de travail
COPY requirements.txt .

# Installer les dépendances de l'application
RUN pip install --no-cache-dir -r requirements.txt

# Copier le reste du code de l'application dans le conteneur
COPY . .

# Exposer le port sur lequel votre application s'exécute (ajustez si nécessaire)
EXPOSE 5000

# Commande pour démarrer l'application (ajustez en fonction de votre script)
CMD ["python3", "app.py"]
