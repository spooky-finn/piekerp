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
    MuiMenu: {
      styleOverrides: {
        paper: {
          border: '1px solid var(--border)',
          boxShadow: '0 10px 50px 0 var(--bs) !important',
          borderRadius: 'var(--br)',
        }
      }
    },
    MuiMenuItem: {
      styleOverrides: {
        root: {
          fontSize: '.8rem',
          padding: '4px 15px !important'
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
          }
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
          minWidth: '10px',
          minHeight: '10px',
          padding: '4px 6px',
          'svg':{
            width: 20
          },
          'path': {
            color: theme.palette.text.secondary,
            strokeWidth: .4,
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
    MuiToggleButton: {
      defaultProps: {
        disableRipple: true,
      }
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
    },
    MuiDrawer: {
      styleOverrides: {
        paper: {
          background: 'var(--L0-glass)',
          margin: '.6rem',
          height: '98%',
          border: '1px solid var(--border)',
          borderRadius: 'var(--br)',
        }
      }
    }
  },
})