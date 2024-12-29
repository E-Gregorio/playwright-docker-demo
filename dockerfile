# Usar la imagen base de Playwright
FROM mcr.microsoft.com/playwright:v1.41.0-focal

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y curl git zip unzip

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos de package y de configuración
COPY package*.json ./

# Instalar las dependencias del proyecto
RUN npm ci

# Instalar Playwright
RUN npm install playwright

# Instalar solo Chrome y sus dependencias
RUN npx playwright install --with-deps chrome

# Copiar todo el código fuente al contenedor
COPY . .

# Crear el directorio de resultados
RUN mkdir -p test-results

# Exponer el puerto 9323 para el reporte de HTML
EXPOSE 9323

# Comando para ejecutar las pruebas
CMD ["npm", "run", "test:ci"]
