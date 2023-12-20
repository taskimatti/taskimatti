import { fileURLToPath } from 'node:url';
import { describe, expect, it } from 'vitest';
import { setup, $fetch, fetch } from '@nuxt/test-utils';

// $fetch gets the HTML of a server-rendered page.
// fetch gets the response of a server-rendered page.

describe('Login Page', async () => {
  await setup({
    rootDir: fileURLToPath(new URL('..', import.meta.url)),
    server: true,
  });

  it('Page loads successfully', async () => {
    const res = await fetch('/login');
    expect(res.status).toBe(200);
  });

    it('Page contains "Login"', async () => {
        const html = await $fetch('/login');
        expect(html).toContain('Login');
    });
});
