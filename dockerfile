# Usar la imagen base de Playwright (incluye las dependencias necesarias para navegadores)
FROM mcr.microsoft.com/playwright:v1.41.0-focal

# Instalar dependencias adicionales que puedas necesitar
RUN apt-get update && apt-get install -y curl git zip unzip wget

# Configuración opcional: instalar Chrome si realmente lo necesitas aparte del manejado por Playwright
# Si Playwright lo maneja correctamente, esta sección podría omitirse.
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get update && apt-get install -y google-chrome-stable

# Establecer el directorio de trabajo en el contenedor
WORKDIR /e2e-tests

# Copiar los archivos de configuración de NPM
COPY package*.json ./

# Instalar las dependencias del proyecto
RUN npm ci

# Instalar Playwright con Chrome
RUN npx playwright install --with-deps --force chrome


# Copiar todo el código fuente al contenedor
COPY . .

# Crear directorio para guardar los resultados de las pruebas
RUN mkdir -p /test-results

# Exponer el puerto 9323 para el reporte HTML de Playwright
EXPOSE 9323

# Comando para ejecutar las pruebas en el contenedor
CMD ["npm", "run", "test:ci"]
