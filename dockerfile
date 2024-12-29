FROM mcr.microsoft.com/playwright:v1.41.0-focal

# Establecer el directorio de trabajo correcto
WORKDIR /e2e-tests

# Copiar los archivos de configuración
COPY package*.json ./

# Instalar dependencias
RUN npm ci

# Instalar solo el navegador Chrome
RUN npx playwright install chrome

# Copiar el resto del código
COPY . .

# Crear directorios para resultados
RUN mkdir -p test-results
RUN mkdir -p playwright-report

# Comando por defecto
CMD ["npm", "run", "test:ci"]