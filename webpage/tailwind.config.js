/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{html,ts}",
  ],
  darkMode: 'media',
  theme: {
    extend: {
      colors: {
        primary: {
          DEFAULT: '#1D4ED8', // main primary color
          hover: '#1E40AF', // hover state for primary
          light: '#3B82F6', // light variant of primary (for buttons)
        },
        background: {
          DEFAULT: '#FFFFFF', // light mode background
          card: '#1F1F1F', // dark mode card background
          card2: '#F3F4F6', // light mode card background
          inverse: '#F3F4F6', // light mode card background
        },
        darkbg: {
          DEFAULT: 'rgba(33, 33, 33, 1)', // main dark background
          card: 'rgba(44, 44, 44, 1)', // for tables
        },
        text: {
          DEFAULT: '#000000', // light mode text
          light: '#4B5563', // muted/secondary text
          inverse: '#FFFFFF', // dark mode text
        },

        // Border
        border: {
          DEFAULT: '#E0E0E0', // light borders
          dark: '#3F3F3F', // dark borders
        },
      },
    },
  },
  plugins: [],
};