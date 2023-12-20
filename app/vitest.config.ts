import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    include: ['test/vitest/**/*.{test,spec}.?(c|m)[jt]s?(x)']
  },
})