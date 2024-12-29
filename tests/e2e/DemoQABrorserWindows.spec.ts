import { test, expect, Page } from '@playwright/test';
import { BrowserWindowsPage } from '../../pages/BrowserWindowPage';

test.describe('Validar la funcionalidad de las ventanas emergentes en Browser Windows de la aplicación DemoQA', () => {
    let browserWindowsPage: BrowserWindowsPage;

    test.beforeEach(async ({ page }) => {
        browserWindowsPage = new BrowserWindowsPage(page);
        await page.goto('https://demoqa.com/browser-windows');
    });

    test('TC1: Validar apertura de una nueva pestaña', async ({ page }) => {
        let page1: Page;

        await test.step('Abrir nueva pestaña al hacer clic en el botón "New Tab"', async () => {
            page1 = await browserWindowsPage.clickNewTabButtonAndOpenPopup();
        });

        await test.step('Validar que el contenido de la nueva pestaña contenga el texto "This is a sample page"', async () => {
            await page1.waitForSelector('#sampleHeading');
            await expect(page1.locator('#sampleHeading')).toContainText('This is a sample page');
        });

        await test.step('Cerrar la nueva pestaña', async () => {
            await page1.close();
        });
    });

    test('TC2: Validar apertura de una nueva ventana', async ({ page }) => {
        let page2: Page;

        await test.step('Abrir nueva ventana al hacer clic en el botón "New Window"', async () => {
            page2 = await browserWindowsPage.clickNewWindowButtonAndOpenPopup();
        });

        await test.step('Validar que el contenido de la nueva ventana contenga el texto "This is a sample page"', async () => {
            await page2.waitForSelector('#sampleHeading');
            await expect(page2.locator('#sampleHeading')).toContainText('This is a sample page');
        });

        await test.step('Cerrar la nueva ventana', async () => {
            await page2.close();
        });
    });

    test('TC3: Validar apertura de una nueva ventana de mensaje', async ({ page }) => {
        let page3: Page;

        await test.step('Abrir nueva ventana de mensaje al hacer clic en el botón "New Window Message"', async () => {
            page3 = await browserWindowsPage.clickNewWindowMessageButtonAndOpenPopup();
        });

        await test.step('Validar que el contenido de la ventana de mensaje contenga el texto específico', async () => {
            await page3.waitForSelector('body');
            await expect(page3.locator('body')).toContainText('Knowledge increases by sharing but not by saving. Please share this website with your friends and in your organization.');
        });

        await test.step('Cerrar la ventana de mensaje', async () => {
            await page3.close();
        });
    });
});