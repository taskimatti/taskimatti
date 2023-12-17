import { fileURLToPath } from 'node:url';
import { describe, expect, it } from 'vitest';
import { setup, $fetch, isDev } from '@nuxt/test-utils';

describe('Login Page', async () => {
  await setup({
    rootDir: fileURLToPath(new URL('..', import.meta.url)),
    server: true,
  });

  it('Renders Login Page', async () => {
    const pageContent = await $fetch('/login');
    expect(pageContent).toMatch('Pythonkieltäytyjät Ry | Login');
  });

  if (isDev()) {
    it('[dev] ensure vite client script is added', async () => {
      const pageContent = await $fetch('/login');
      expect(pageContent).toMatch('/_nuxt/@vite/client"');
    });
  }
});
