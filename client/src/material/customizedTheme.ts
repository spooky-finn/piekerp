import { PaletteOptions, ThemeOptions } from '@mui/material'

declare module '@mui/material/styles/createTypography' {
  interface TypographyOptions {
    subtitle3: TypographyStyleOptions
  }
}

declare module '@mui/material/Button' {
  interface ButtonPropsVariantOverrides {
    iconic: true
  }
}

const pallete = (preferTheme: string): PaletteOptions => ({
  ...(preferTheme === 'light'
    ? {
        // palette values for light preferTheme
        mode: 'light',
        primary: {
          main: '#4361e4',
          light: '#E7E9FB'
        },
        secondary: {
          main: '#e5534b'
        }
      }
    : {
        // palette values for dark preferTheme
        mode: 'dark',
        primary: {
          main: '#99affc',
          light: '#43435c'
        },
        secondary: {
          main: '#e5534b'
        }
      })
})

export const customizedTheme = (preferTheme: string): ThemeOptions => ({
  palette: pallete(preferTheme),
  typography: {
    fontFamily: `-apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',sans-serif`,
    subtitle1: {
      // Акцентный подзаголовок
      fontSize: '.8rem',
      textTransform: 'uppercase',
      fontWeight: 600,
      letterSpacing: '.5px',
      color: 'var(--accent) !important'
    },
    subtitle2: {
      // Нейтральный подзаголовок
      fontWeight: 600,
      textTransform: 'uppercase',
      fontSize: '.8rem'
    },
    subtitle3: {
      // Полупрозрачный подзаголовок
      fontSize: '.8rem',
      color: 'var(--lowContrast) !important',
      textTransform: 'uppercase'
    }
  },
  components: {
    MuiDialog: {
      styleOverrides: {
        paper: {
          background: 'var(--LI) !important',
          borderRadius: 'var(--br) !important',
          border: 'var(--border)'
        }
      }
    },
    MuiDialogTitle: {
      styleOverrides: {
        root: {
          background: 'var(--L2)',
          borderBottom: 'var(--border)',
          padding: '11px 1rem'
        }
      }
    },
    MuiDialogContent: {
      styleOverrides: {
        root: {
          background: 'var(--L2)',
          padding: '1rem 1rem .5rem !important'
        }
      }
    },
    MuiDialogActions: {
      styleOverrides: {
        root: {
          background: 'var(--L2)',
          borderTop: 'var(--border)',
          padding: '15px 1rem !important'
        }
      }
    },
    MuiMenu: {
      styleOverrides: {
        paper: {
          // border: 'var(--border)',
          boxShadow: 'none !important'
        }
      }
    },
    MuiMenuItem: {
      defaultProps: {
        disableRipple: true
      }
    },
    MuiListItemText: {
      styleOverrides: {
        primary: {
          fontSize: '.9rem'
        }
      }
    },
    MuiListItemIcon: {
      styleOverrides: {
        root: {
          minWidth: '25px !important',
          svg: {
            width: '17px'
          }
        }
      }
    },
    MuiButton: {
      variants: [
        {
          props: {
            variant: 'iconic'
          },
          style: {
            minWidth: '10px',
            minHeight: '10px',
            padding: '8px',
            margin: '2px',
            borderRadius: '8px',
            svg: {
              width: 20
            },
            '&.active': {
              background: 'var(--accentLight)',
              color: 'var(--accent)'
            }
          }
        }
      ],
      styleOverrides: {
        root: {
          transitionDuration: '0ms',
          textTransform: 'none',
          borderRadius: '10px'
        },
        textInfo: {
          color: 'var(--lowContrast) !important'
        }
      },
      defaultProps: {
        disableElevation: true,
        disableRipple: true
      }
    },
    MuiToggleButton: {
      defaultProps: {
        disableRipple: true
      }
    },
    MuiTextField: {
      defaultProps: {
        variant: 'filled',
        autoComplete: 'off'
      }
    },
    MuiAutocomplete: {
      styleOverrides: {
        root: {
          borderRadius: 'var(--br) !important'
        },
        paper: {
          background: 'var(--L2) !important',
          border: 'var(--border)',
          boxShadow: '0 0 20px 5px lightgrey'
        }
      }
    },
    MuiInputLabel: {
      styleOverrides: {
        root: {
          color: 'var(--lowContrast) !important'
        }
        // filter: {
        //   fontSize: '.8rem',
        //   transform: 'none',
        //   position: 'relative'
        // }
      },
      defaultProps: {
        shrink: true
      }
    },
    MuiFilledInput: {
      defaultProps: {
        disableUnderline: true,
        size: 'small'
      },
      styleOverrides: {
        root: {
          background: 'var(--L0)',
          border: '1px solid var(--border-color)',
          borderRadius: '10px',
          margin: '4px 0'
        }
      }
    },
    MuiInput: {
      defaultProps: {
        disableUnderline: true
      }
    },
    MuiInputBase: {
      styleOverrides: {
        root: {
          color: 'var(--highContrast) !important'
        }
      }
    },
    MuiOutlinedInput: {
      styleOverrides: {
        notchedOutline: {
          border: 'none'
        }
      }
    },
    MuiPopover: {
      styleOverrides: {
        paper: {
          border: 'var(--border)',
          background: 'var(--L2)',
          borderRadius: 'var(--br) !important'
        }
      }
    },
    MuiFormControl: {
      defaultProps: {
        variant: 'filled'
      }
    },
    MuiSelect: {
      styleOverrides: {
        select: {
          // boxShadow: 'none !important'
        }
      },
      defaultProps: {
        variant: 'filled',
        size: 'small'
      }
    },

    MuiCheckbox: {
      defaultProps: {
        disableRipple: true,
        color: 'primary',
        size: 'small'
      }
    }
  }
})
