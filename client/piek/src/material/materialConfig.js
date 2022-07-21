const materialConfig = (theme) => ({
  components: {
    MuiDialog: {
      styleOverrides: {
        paper: {
          background: 'var(--LI) !important',
          borderRadius: 'var(--br) !important',
          border: 'var(--border)',
        }
      }
    },
    MuiDialogTitle: {
      styleOverrides: {
        root: {
          color: theme.palette.text.primary,
          background: 'var(--L2)',
          borderBottom: 'var(--border)',
          padding: '11px 1rem',
          fontSize: '.9rem'
        }
      }
    },
    MuiDialogContent: {
      styleOverrides: {
        root: {
          background: 'var(--L2)',
          padding: '1rem 1rem .5rem !important',
        }
      }
    },
    MuiDialogActions: {
      styleOverrides: {
        root: {
          background: 'var(--L2)',
          borderTop: 'var(--border)',
          padding: '10px 1rem !important',
        }
      }
    },
    MuiMenu: {
      styleOverrides: {
        paper: {
          border: 'var(--border)',
          boxShadow: 'none !important',
          borderRadius: 'var(--br)',
          background: 'var(--L2) !important',

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
          'svg': {
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
          borderRadius: 'var(--br10)',
        },
        textInfo: {
          color: 'var(--lowContrast) !important',
        },
        iconic: {
          minWidth: '10px',
          minHeight: '10px',
          padding: '4px 6px',
          'svg': {
            width: 20
          },
          'path': {
            color: theme.palette.text.secondary,
            strokeWidth: .2,
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
    MuiAutocomplete: {
      styleOverrides: {
        root: {
          borderRadius: 'var(--br) !important',
        },
        paper: {
          background: 'var(--L0) !important',
          fontSize: '13px',
          // color: 'var(--lowContrast)',
        }
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
          border: '1px solid var(--border-colorLight)',
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
        },
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
          // margin: '.6rem',
          // height: '98%',
          // border: 'var(--lowContrast)',
          // borderRadius: 'var(--br)',
        }
      }
    }
  },
})


export default materialConfig