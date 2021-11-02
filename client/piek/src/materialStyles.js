import { color, palette } from "@mui/system";

export const muicomponents = (theme) => ({
  components: {
    MuiDialog: {
      styleOverrides: {
        paper: {
          background: 'var(--L0) !important',
          borderRadius: 'var(--br) !important',
        }
      }
    },
    MuiDialogTitle: {
      styleOverrides: {
        root: {
          color: theme.palette.text.primary,
        }
      }
    },

    MuiMenuItem: {
      styleOverrides: {
        root: {
          fontSize: '.8rem',
        }
      },
      defaultProps: {
        disableRipple: true
      }
    },
    MuiListItemText: {
      styleOverrides: {
        primary: {
          fontSize: '.8rem'
        }
      }
    },
    MuiListItemIcon: {
      styleOverrides: {
        root: {
          minWidth: '25px !important',
          'svg':{
            width: '17px'
          },
          'path':{
            strokeWidth: .8,
            stroke: 'var(--L0)'
          },
        }
      }
    },
    MuiButton: {
      styleOverrides: {
        root: {
          fontSize: '.8rem',
          textTransform: 'none !important',
        },
        textInfo: {
          color: 'var(--lowContrast) !important',
        },
        iconic: {
          minWidth: '40px',
          padding: '5px',
          'path': {
            color: theme.palette.text.primary,
            strokeWidth: .8,
            stroke: 'var(--L0)'
          },
          '&:hover': {
            background: 'var(--accentLight)',
          }
        }
      },
      defaultProps: {
        disableElevation: true,
        disableRipple: true,
      },
    },

    MuiTextField: {
      defaultProps: {
        variant: 'standard',
        autoComplete: 'off',
      }
    },
    MuiInputLabel: {
      styleOverrides: {
        root: {
          color: 'var(--lowContrast) !important',
        },
        filter: {
          fontSize: '.8rem',
          transform: 'none',
          position: 'relative',
        }
      },
      defaultProps: {
        shrink: true,
      }
    },
    MuiFilledInput: {
      defaultProps: {
        disableUnderline: 'true',
        size: 'small',
      },
      styleOverrides: {
        root: {
          background: 'var(--L1)',
          border: '1px solid var(--borderLight)',
          borderRadius: '10px',
          ':hover': {
            background: 'var(--L1)',
          },
        },

      }
    },
    MuiInput: {
      defaultProps: {
        disableUnderline: 'true'
      }
    },
    MuiInputBase: {
      styleOverrides: {
        root: {
          color: 'var(--highContrast) !important',
        }
      }
    },
    MuiOutlinedInput: {
      styleOverrides: {
        notchedOutline: {
          border: 'none',
        }
      }
    },
    MuiPopover: {
      styleOverrides: {
        paper: {
          background: 'var(--L0)',
          borderRadius: 'var(--br) !important'
        }
      }
    },
    MuiSelect: {
      styleOverrides: {
        select: {
          fontSize: '.8rem',
          boxSizing: 'border-box',
          border: 'none !important',
          outline: 'none !important',
          boxShadow: 'none !important',
          padding: 0,
        }
      }
    },
    MuiTab: {
      defaultProps: {
        disableRipple: true
      }
    },
    MuiCheckbox: {
      defaultProps: {
        disableRipple: true
      }
    }
  },
})