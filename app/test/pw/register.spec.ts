import { test, expect } from '@playwright/test';
import { config } from 'dotenv';

config();

const REGISTER_URL = 'http://localhost:3000/register';
const REGISTER_ENDPOINT = '/register';

async function fillFormAndSubmit(page: any, user: string, email: string, password: string) {
  await page.getByPlaceholder('Email').fill(email);
  await page.getByPlaceholder('Password').fill(password);
  const responsePromise = page.waitForResponse((response: any) => response.url().endsWith(REGISTER_ENDPOINT));
  await page.getByRole('button', { name: 'Register' }).click();
  return responsePromise;
}

test.describe('Register tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto(REGISTER_URL);
    await page.getByPlaceholder('Email').fill('');
    await page.getByPlaceholder('Password').fill('');
    await page.waitForTimeout(100);
  });

  test('Test that register page loads successfully', async ({ page }) => {
    await expect(page).toHaveTitle('Register');
    await expect(page.getByRole('img', { name: 'TaskiMatti logo' })).toBeVisible();
    await expect(page.getByPlaceholder('Email')).toBeVisible();
    await expect(page.getByPlaceholder('Password')).toBeVisible();
    await expect(page.getByRole('button', { name: 'register' })).toBeVisible();
    await expect(page.locator('[id="__nuxt"]')).toContainText('Already have an account? Login now!');
  });

  test('Test empty username', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(page,'', 'user@example', 'password');
    const response = await responsePromise;
    expect(response.status()).toBe(400);
    await expect(page.locator('[id="__nuxt"]')).toContainText('Invalid payload. "email" is not allowed to be empty.');
  });

  test('Test empty email', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(page,'example', '', 'password');
    const response = await responsePromise;
    expect(response.status()).toBe(400);
    await expect(page.locator('[id="__nuxt"]')).toContainText('Invalid payload. "email" is not allowed to be empty.');
  });

  test('Test invalid email', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(page,'example', 'user@example', 'password');
    const response = await responsePromise;
    expect(response.status()).toBe(400);
    await expect(page.locator('[id="__nuxt"]')).toContainText('Invalid payload. "email" must be a valid email.');
  });

  test('Test empty password', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(page,'example', 'user@example', '');
    const response = await responsePromise;
    expect(response.status()).toBe(400);
    // await expect(page.locator('[id="__nuxt"]')).toContainText('Invalid payload. "password" is not allowed to be empty.');
  });

  test('Test !gnu credentials', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(page, 'example', process.env.NUXT_API_EMAIL || '', 'password');
    const response = await responsePromise;
    expect(response.status()).toBe(401);
    // await expect(page.locator('[id="__nuxt"]')).toContainText('Invalid credentials');
  });

  test('Test valid credentials', async ({ page }) => {
    const responsePromise = fillFormAndSubmit(
      page,
      '',
      process.env.NUXT_API_EMAIL || '',
      process.env.NUXT_API_PASSWD || '',
    );
    const response = await responsePromise;
    expect(response.status()).toBe(200);
  });
});
