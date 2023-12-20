import { test, expect } from '@playwright/test';
import { config } from 'dotenv';

config();

const LOGIN_URL = 'http://localhost:3000/login';
const LOGIN_ENDPOINT = '/login';

async function fillFormAndSubmit(page: any, email: string, password: string) {
  await page.getByPlaceholder('Email').fill(email);
  await page.getByPlaceholder('Password').fill(password);
  const responsePromise = page.waitForResponse((response: any) => response.url().endsWith(LOGIN_ENDPOINT));
  await page.getByRole('button', { name: 'Login' }).click();
  return responsePromise;
}

test.describe('Login tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto(LOGIN_URL);
  });

  test('Test that login page loads successfully', async ({ page }) => {
    await expect(page).toHaveTitle(/.* \| Login/); // xxx | Login
    await expect(page.getByRole('img')).toBeVisible();
    await expect(page.getByPlaceholder('Email')).toBeVisible();
    await expect(page.getByPlaceholder('Password')).toBeVisible();
    await expect(page.getByRole('button', { name: 'Login' })).toBeVisible();
  });

  test('Test empty email', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(page, '', 'password');
    const response = await responsePromise;
    expect(response.status()).toBe(400);
    await expect(page.getByRole('paragraph')).toContainText('Invalid payload. "email" is not allowed to be empty.');
  });

  test('Test invalid email', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(page, 'user@example', 'password');
    const response = await responsePromise;
    expect(response.status()).toBe(400);
    await expect(page.getByRole('paragraph')).toContainText('Invalid payload. "email" must be a valid email.');
  });

  test('Test empty password', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(page, 'user@example', '');
    const response = await responsePromise;
    expect(response.status()).toBe(400);
    // await expect(page.getByRole('paragraph')).toContainText('Invalid payload. "password" is not allowed to be empty.');
  });

  test('Test invalid credentials', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(page, 'invalid@example.com', 'password');
    const response = await responsePromise;
    expect(response.status()).toBe(401);
    // await expect(page.getByRole('paragraph')).toContainText('Invalid credentials');
  });

  test('Test valid credentials', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(
      page,
      process.env.NUXT_API_EMAIL || '',
      process.env.NUXT_API_PASSWD || '',
    );
    const response = await responsePromise;
    expect(response.status()).toBe(200);
  });
});
