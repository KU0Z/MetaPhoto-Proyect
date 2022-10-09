// Styles
import '@mdi/font/css/materialdesignicons.css'
import 'vuetify/styles'


// Vuetify
import { createVuetify } from 'vuetify'
import colors from 'vuetify/lib/util/colors'
export default createVuetify({
  theme: {
    dark: true,
    themes: {
      light: {
        primary: colors.green.darken3,
        secondary: '#b0bec5',
        accent: '#8c9eff',
        error: '#b71c1c',
      },
      dark: {
        primary: colors.blueGrey.darken2,
        secondary: colors.blueGrey.lighten2,
        accent: colors.blueGrey.darken3,
      },
    },
  },
})
