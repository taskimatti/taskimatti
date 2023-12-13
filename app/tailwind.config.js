/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "src/components/**/*.{js,vue,ts}",
    "src/layouts/**/*.vue",
    "src/pages/**/*.vue",
    "src/plugins/**/*.{js,ts}",
    "src/app.vue",
    "src/error.vue",
  ],
  theme: {
    extend: {
            fontFamily: {
            sans: ['Your Font Name', 'sans-serif'],
            serif: ['Your Serif Font', 'serif'],
        },
        colors: {
            cringe_back: '#464646',
            cringe: '#2E2E2E',
            cringe_front: '#D6D6D6',
            cringe_text: '#9E86C8',
            cringe_box: '#1D1D1D',
            cringe_boxtext: '#DC6395',
            cringe_boxtext2: '#E34040',
            cringe_boxtext3: '#FFC972',
            cringe_boxtext4: '#4FBB5A',
        }
    },
  },
  plugins: [],
}

