/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    colors: {
      'grape': "#2d182c",
      'light_purple': "#efeefb",
      'lime_green': "#cef31e",
      'white': "#ffffff",
    },
    extend: {},
  },
  plugins: [],
};
