const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './node_modules/flowbite/**/*.js',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      keyframes:{
        "fade-down": {
          '0%': { 
            opacity: 0,
            transform: 'translateY(-10px)' 
          },
          '100%': { 
            opacity: 100,
            transform: 'translateY(0px)' 
          },
        }
      },
      animation:{
        "fade-down": 'fade-down 1s ease-in-out',
      }
    },
  },
  plugins: [
    require('flowbite/plugin'),
    require('prettier-plugin-tailwindcss'),
    require('@tailwindcss/line-clamp'),
    require('tailwind-scrollbar-hide'),
  ],
};
