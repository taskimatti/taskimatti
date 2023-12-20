import { test, expect } from '@playwright/test';
import { config } from 'dotenv';

config();

const REGISTER_URL = 'http://localhost:3000/register';

const ERROR_MESSAGES = {
  USERNAME_REQUIRED: 'Username is required',
  EMAIL_REQUIRED: 'Email is required',
  EMAIL_NOT_UNIQUE: 'Email not unique',
  PASSWORD_REQUIRED: 'Password is required',
  INVALID_EMAIL: 'email format is not valid',
};

const fillForm = async (page: any, username: string, email: string, password: string) => {
  await page.getByPlaceholder('Username').fill(username);
  await page.getByPlaceholder('Email').fill(email);
  await page.getByPlaceholder('Password').fill(password);
};

test.describe('Register tests', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto(REGISTER_URL);
    await fillForm(page, '', '', '');
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
    await fillForm(page, '', 'user@example.com', 'password');
    await page.getByRole('button', { name: 'Register' }).click();
    await expect(page.locator('[id="__nuxt"]')).toContainText(ERROR_MESSAGES.USERNAME_REQUIRED);
  });

  test('Test empty email', async ({ page }) => {
    await fillForm(page, 'Username', '', 'password');
    await page.getByRole('button', { name: 'Register' }).click();
    await expect(page.locator('[id="__nuxt"]')).toContainText(ERROR_MESSAGES.EMAIL_REQUIRED);
  });

  test('Test invalid email', async ({ page }) => {
    await fillForm(page, 'Test user', 'user@example', 'password');
    const responsePromise = page.waitForResponse((response: any) => response.url());
    await page.getByRole('button', { name: 'Register' }).click();
    const response = await responsePromise;
    expect(response.status()).toBe(400);
    await expect(page.locator('[id="__nuxt"]')).toContainText(ERROR_MESSAGES.INVALID_EMAIL);
  });

  test('Test empty password', async ({ page }) => {
    await fillForm(page, 'Username', 'user@example.com', '');
    await page.getByRole('button', { name: 'Register' }).click();
    await expect(page.locator('[id="__nuxt"]')).toContainText(ERROR_MESSAGES.PASSWORD_REQUIRED);
  });

  test('Test already registered email', async ({ page }) => {
    await fillForm(page, 'Test user', process.env.NUXT_API_EMAIL || 'already_registered@example.com', 'password');
    const responsePromise = page.waitForResponse((response: any) => response.url());
    await page.getByRole('button', { name: 'Register' }).click();
    const response = await responsePromise;
    expect(response.status()).toBe(400);
    await expect(page.locator('[id="__nuxt"]')).toContainText(ERROR_MESSAGES.EMAIL_NOT_UNIQUE);
  });

  test('Test successful registration', async ({ page }) => {
    await fillForm(
      page,
      'Test user',
      Math.random().toString(36).slice(-8) + '@example.com',
      Math.random().toString(36).slice(-8),
    );
    const responsePromise = page.waitForResponse((response: any) => response.url());
    await page.getByRole('button', { name: 'Register' }).click();
    const response = await responsePromise;
    expect(response.status()).toBe(204);
    // navigate to /
    await expect(page.locator('[id="__nuxt"]')).toContainText('Select project');
    // check local storage for access_token
    const token = await page.evaluate(() => localStorage.getItem('access_token'));
    expect(token).not.toBeNull();
    expect(token).not.toBeUndefined();
    expect(token).not.toBe('');
    const refresh_token = await page.evaluate(() => localStorage.getItem('refresh_token'));
    expect(refresh_token).not.toBeNull();
    expect(refresh_token).not.toBeUndefined();
    expect(refresh_token).not.toBe('');
  });
});
