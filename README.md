Playwright Docker Demo
Este proyecto demuestra la implementación de pruebas automatizadas E2E utilizando Playwright con TypeScript, Docker y CircleCI. El proyecto incluye pruebas automatizadas para la aplicación DemoQA, específicamente para la funcionalidad de Browser Windows.
🚀 Tecnologías Utilizadas

Playwright v1.41.0
TypeScript
Docker
CircleCI
Node.js

📁 Estructura del Proyecto
Copyplaywright-docker-demo/
├── .circleci/
│   └── config.yml
├── pages/
│   └── BrowserWindowPage.ts
├── tests/
│   └── e2e/
│       └── DemoQABrorserWindows.spec.ts
├── dockerfile
├── docker-compose.yml
├── playwright.config.ts
└── package.json
🛠️ Configuración del Proyecto
Requisitos Previos

Node.js (última versión LTS)
Docker Desktop
Git

Instalación

Clonar el repositorio:

bashCopygit clone <url-del-repositorio>
cd playwright-docker-demo

Instalar dependencias:

bashCopynpm ci

Instalar navegadores de Playwright:

bashCopynpx playwright install chrome
🐳 Configuración de Docker
Dockerfile
dockerfileCopyFROM mcr.microsoft.com/playwright:v1.41.0-focal

WORKDIR /e2e-tests

COPY package*.json ./
RUN npm ci
RUN npx playwright install chrome

COPY . .

RUN mkdir -p test-results
RUN mkdir -p playwright-report

CMD ["npm", "run", "test:ci"]
Docker Compose
yamlCopyservices:
  e2e-tests:
    build: .
    container_name: playwright-tests
    volumes:
      - ./test-results:/e2e-tests/test-results
      - ./playwright-report:/e2e-tests/playwright-report
    environment:
      - CI=true
🔄 Configuración de CircleCI
yamlCopyversion: 2.1

orbs:
  docker: circleci/docker@2.1.1
  browser-tools: circleci/browser-tools@1.4.1

jobs:
  e2e-tests:
    docker:
      - image: mcr.microsoft.com/playwright:v1.41.0-focal
    resource_class: large

    steps:
      - checkout
      - setup_remote_docker:
          docker_layer_caching: true
      - run:
          name: Install dependencies
          command: |
            npm ci
            npx playwright install chrome
      - run:
          name: Run E2E Tests
          command: npm run test:ci
      - store_test_results:
          path: test-results
      - store_artifacts:
          path: playwright-report
          destination: playwright-report

workflows:
  version: 2
  test:
    jobs:
      - e2e-tests
📝 Scripts Disponibles
En el archivo package.json:
jsonCopy{
  "scripts": {
    "test": "playwright test",
    "test:ci": "playwright test --config=playwright.config.ts",
    "test:headed": "playwright test --headed",
    "test:debug": "playwright test --debug",
    "report": "playwright show-report",
    "report:html": "playwright show-report playwright-report",
    "clean": "rimraf test-results playwright-report"
  }
}
🚀 Ejecución de Pruebas
Localmente sin Docker
bashCopynpm run test
Con Docker
bashCopy# Construir la imagen
docker-compose build

# Ejecutar las pruebas
docker-compose up
Modo Debug
bashCopynpm run test:debug
Ver Reportes
bashCopynpm run report
📊 Resultados y Reportes
Los resultados de las pruebas y reportes se almacenan en:

test-results/: Resultados de las pruebas
playwright-report/: Reportes HTML detallados

🔄 Integración Continua
El proyecto está configurado para ejecutarse en CircleCI. Cada push al repositorio activará:

Construcción del contenedor Docker
Ejecución de las pruebas
Generación y almacenamiento de reportes
Almacenamiento de resultados de pruebas

📱 Page Objects
El proyecto utiliza el patrón Page Object Model (POM) para mantener el código organizado y mantenible. Ejemplo de un Page Object:
typescriptCopy// pages/BrowserWindowPage.ts
export class BrowserWindowsPage {
    readonly page: Page;
    readonly newTabButton: Locator;
    // ... resto del código
}
🧪 Pruebas
Las pruebas están escritas utilizando el framework de Playwright Test y están organizadas en describe blocks con steps claros:
typescriptCopytest.describe('Validar la funcionalidad de las ventanas emergentes...', () => {
    test('TC1: Validar apertura de una nueva pestaña', async ({ page }) => {
        // ... código de la prueba
    });
});
📫 Contribuir

Fork el proyecto
Crear una rama para tu feature (git checkout -b feature/AmazingFeature)
Commit tus cambios (git commit -m 'Add some AmazingFeature')
Push a la rama (git push origin feature/AmazingFeature)
Abrir un Pull Request

📝 Licencia
